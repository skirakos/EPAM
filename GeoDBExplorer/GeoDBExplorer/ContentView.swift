//
//  ContentView.swift
//  GeoDBExplorer
//
//  Created by Seda Kirakosyan on 03.09.25.
//

import SwiftUI


struct CountriesResponse: Decodable {
    let data: [Country]
    let metadata: Metadata

    struct Metadata: Decodable {
        let totalCount: Int
        let currentOffset: Int
        let limit: Int?
    }
}

struct Country: Decodable, Identifiable {
    var id: String { code }
    let code: String
    let name: String
    // keep others for later if you want:
    let wikiDataId: String?
    let region: String?
    let capital: String?
    let callingCode: String?
    let currencyCodes: [String]?
    let numRegions: Int?
    let flagImageUri: String?
}

struct CitiesResponse: Decodable {
    let data: [City]
    let metadata: CountriesResponse.Metadata
}

struct City: Decodable, Identifiable {
    var id: String { wikiDataId ?? "\(name)-\(latitude)-\(longitude)" }

    let name: String
    let wikiDataId: String?
    let countryCode: String?
    let region: String?
    let latitude: Double
    let longitude: Double
    let population: Int?
}


struct CountryDetailsView: View {
    let country: Country
    @State private var cities: [City] = []
    @State private var totalCount = 0
    @State private var page = 0
    private let pageSize = 10
    @State private var isLoading = false
    @State private var output = "Requesting…"
    let rapidAPIKey = "f5f94d4850msh98f4b69b5c51ee0p1ee57ejsn78cb557e5f6a"
    
    var body: some View {
        List {
            LabeledContent("Code", value: country.code)
            if let capital = country.capital, !capital.isEmpty {
                LabeledContent("Capital", value: capital)
            }
            if let region = country.region, !region.isEmpty {
                LabeledContent("Region", value: region)
            }
            if let codes = country.currencyCodes, !codes.isEmpty {
                LabeledContent("Currencies", value: codes.joined(separator: ", "))
            }
            
            Section("Cities") {
                if cities.isEmpty && isLoading {
                    ProgressView("Loading cities…")
                } else if cities.isEmpty {
                    Text(output).font(.footnote).foregroundStyle(.secondary)
                } else {
                    ForEach(cities) { city in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(city.name).font(.body)
                            HStack(spacing: 8) {
                                if let r = city.region, !r.isEmpty { Text(r) }
                                if let p = city.population { Text("• \(p)") }
                            }
                            .font(.caption).foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle(country.name)
        .task(id: page) { await loadCities() }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button("Prev") {
                    guard page > 0, !isLoading else { return }
                    page -= 1
                }
                .disabled(page == 0 || isLoading)

                Spacer()
                Text(isLoading ? "Loading…" : "Page \(page + 1)  •  \(cities.count) / \(totalCount)")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                Spacer()

                Button("Next") {
                    guard (page + 1) * pageSize < totalCount, !isLoading else { return }
                    page += 1
                }
                .disabled((page + 1) * pageSize >= totalCount || isLoading)
            }
        }
    }
    
    private func loadCities() async {
        isLoading = true
        output = "Loading…"
        defer { isLoading = false }

        var comps = URLComponents(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/cities")!
        let size = min(pageSize, 100)
        comps.queryItems = [
            .init(name: "types", value: "CITY"),
//            .init(name: "minPopulation", value: "10000"),
            .init(name: "countryIds", value: country.code),
            .init(name: "limit", value: "\(size)"),
            .init(name: "offset", value: "\(page * size)")
        ]
        var req = URLRequest(url: comps.url!)
        req.httpMethod = "GET"
        req.setValue(rapidAPIKey, forHTTPHeaderField: "X-RapidAPI-Key")
        req.setValue("wft-geo-db.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")

        do {
            let (data, resp) = try await URLSession.shared.data(for: req)
            guard let http = resp as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
                output = "HTTP \((resp as? HTTPURLResponse)?.statusCode ?? -1)\n" + (String(data: data, encoding: .utf8) ?? "")
                return
            }
            let response = try JSONDecoder().decode(CitiesResponse.self, from: data)
            cities = response.data
            totalCount = response.metadata.totalCount
            output = "Loaded \(cities.count) of \(totalCount)"
        } catch {
            output = "Request error: \(error.localizedDescription)"
        }
    }

    
}

struct FavoriteView: View {
    var body: some View {
        
    }
}
enum AppTab: Hashable { case countries, favorites, profile }

struct ContentView: View {
    var body: some View {
        TabView() {
            NavigationStack {
                CountriesView()
            }
            .tabItem { Label("Countries", systemImage: "globe.europe.africa.fill") }
            .tag(AppTab.countries)
            
            NavigationStack {
//                FavoritesView()
            }
            .tabItem { Label("Favorites", systemImage: "heart.fill") }
            .tag(AppTab.favorites)

            // Profile tab (stub for now)
            NavigationStack {
//                ProfileView()
            }
            .tabItem { Label("Profile", systemImage: "person.crop.circle.fill") }
            .tag(AppTab.profile)
        }
    }
}

struct CountriesView: View {
    @State private var output = "Requesting…"
    @State private var countries: [Country] = []
    @State private var totalCount: Int = 0
    @State private var page: Int = 0
    @State private var pageSize: Int = 10
    @State private var isLoading: Bool = false
    
    var body: some View {
        NavigationStack {
            Group {
                if countries.isEmpty && isLoading {
                    ProgressView("Loading countries…").padding()
                }else if countries.isEmpty {
                    ScrollView { Text(output).monospaced().textSelection(.enabled).padding() }
                } else {
                    List(countries) { c in
                        NavigationLink {
                            CountryDetailsView(country: c)
                        } label: {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(c.name).font(.headline)
                                HStack(spacing: 8) {
                                    Text(c.code)
                                    if let capital = c.capital, !capital.isEmpty { Text("• \(capital)") }
                                    if let region = c.region, !region.isEmpty { Text("• \(region)") }
                                }
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 6)
                        }
                    }
                    .listStyle(.plain)
                    .overlay(alignment: .top) {
                      if isLoading { ProgressView().padding(.top, 8) }
                    }
                }
            }
            .navigationTitle("Countries")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("Prev") {
                        guard page > 0, !isLoading else { return }
                        page -= 1
                    }
                    .disabled(page == 0 || isLoading)

                    Spacer()
                    Text(isLoading ? "Loading…" : "Page \(page + 1)  •  \(countries.count) / \(totalCount)")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    Spacer()

                    Button("Next") {
                        guard (page + 1) * pageSize < totalCount, !isLoading else { return }
                        page += 1
                    }
                    .disabled((page + 1) * pageSize >= totalCount || isLoading)
                }
            }
        }
        .task(id: page) { await pingGeoDB() }

    }

    private func pingGeoDB() async {
        let rapidAPIKey = "f5f94d4850msh98f4b69b5c51ee0p1ee57ejsn78cb557e5f6a"
        isLoading = true
        output = "Loading…"
        defer { isLoading = false }

        
        guard var comps = URLComponents(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries") else {
            output = "Bad URL"; return
        }
        comps.queryItems = [
            URLQueryItem(name: "limit", value: "\(pageSize)"),
            URLQueryItem(name: "offset", value: "\(page * pageSize)")
        ]

        guard let url = comps.url else { output = "Bad URL components"; return }

        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        req.setValue(rapidAPIKey, forHTTPHeaderField: "X-RapidAPI-Key")
        req.setValue("wft-geo-db.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")

        do {
            let (data, resp) = try await URLSession.shared.data(for: req)
            let code = (resp as? HTTPURLResponse)?.statusCode ?? -1
            guard (200..<300).contains(code) else {
                output = "HTTP \(code)\n" + (String(data: data, encoding: .utf8) ?? "")
                return
            }
            let response = try JSONDecoder().decode(CountriesResponse.self, from: data)
            countries = response.data
            totalCount = response.metadata.totalCount
            output = "Loaded \(countries.count) of \(totalCount)"

            print(output)
        } catch {
            output = "Request error: \(error.localizedDescription)"
        }
        
        
    }
}
//https://wft-geo-db.p.rapidapi.com/v1/geo/places/Q65/distance?toPlaceId=Q60
#Preview {
    ContentView()
}
