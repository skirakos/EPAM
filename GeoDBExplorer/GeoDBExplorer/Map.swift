//
//  Map.swift
//  GeoDBExplorer
//
//  Created by Seda Kirakosyan on 13.09.25.
//
import SwiftUI
import Foundation
import MapKit

struct CityRowView: View {
    let city: City
    
    private var coord: CLLocationCoordinate2D {
        .init(latitude: city.latitude, longitude: city.longitude)
    }
    private var region: MKCoordinateRegion {
        .init(
            center: coord,
            span: .init(latitudeDelta: 1, longitudeDelta: 1)
        )
    }
    var body: some View {
        if isValidCoordinate(lat: city.latitude, lon: city.longitude) {
            VStack(alignment: .leading, spacing: 4) {
                Text(city.name).font(.body)
                HStack(spacing: 8) {
                    if let r = city.region, !r.isEmpty { Text(r) }
                    if let p = city.population { Text("• \(p)") }
                }
                .font(.caption).foregroundStyle(.secondary)
                
                Map(initialPosition: .region(region)) {
                    Marker(city.name, coordinate: coord)
                    
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .allowsHitTesting(false)

            }
            .padding(8)
        } else {
            ContentUnavailableView("Invalid location",
                                   systemImage: "mappin.slash",
                                   description: Text("This item has bad coordinates."))
                .frame(height: 180)
        }
    }
    
    func isValidCoordinate(lat: Double?, lon: Double?) -> Bool {
        guard let lat = lat, let lon = lon,
              lat.isFinite, lon.isFinite,
              (-90.0...90.0).contains(lat),
              (-180.0...180.0).contains(lon)
        else { return false }
        return true
    }
}


//private let cityValid = City(
//    name: "Yerevan",
//    wikiDataId: nil,
//    countryCode: "AM",
//    region: "Yerevan",
//    latitude: 40.1792,
//    longitude: 44.4991,
//    population: 1075800
//)
//
//private let cityInvalidLat = City(
//    name: "BadLat",
//    wikiDataId: nil,
//    countryCode: "XX",
//    region: nil,
//    latitude: 95.0,     // invalid (> 90)
//    longitude: 44.0,
//    population: nil
//)
//
//private let cityInvalidLon = City(
//    name: "BadLon",
//    wikiDataId: nil,
//    countryCode: "XX",
//    region: nil,
//    latitude: 40.0,
//    longitude: 181.0,   // invalid (> 180)
//    population: nil
//)
//
//private let cityNaN = City(
//    name: "NaN City",
//    wikiDataId: nil,
//    countryCode: "XX",
//    region: nil,
//    latitude: .nan,     // invalid
//    longitude: 10.0,
//    population: nil
//)
//
//private let cityInfinity = City(
//    name: "Infinity Town",
//    wikiDataId: nil,
//    countryCode: "XX",
//    region: nil,
//    latitude: 0.0,
//    longitude: .infinity, // invalid
//    population: nil
//)
//
//#Preview("Valid city") {
//    CityRowView(city: cityValid)
//        .frame(height: 260)
//        .padding()
//}
//
//#Preview("Invalid latitude") {
//    CityRowView(city: cityInvalidLat)
//        .frame(height: 260)
//        .padding()
//}
//
//#Preview("Invalid longitude") {
//    CityRowView(city: cityInvalidLon)
//        .frame(height: 260)
//        .padding()
//}
//
//#Preview("NaN & Infinity") {
//    List {
//        CityRowView(city: cityNaN)
//        CityRowView(city: cityInfinity)
//    }
//    .listStyle(.plain)
//}

