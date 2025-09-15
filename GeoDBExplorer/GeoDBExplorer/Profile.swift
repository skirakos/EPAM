//
//  Profile.swift
//  GeoDBExplorer
//
//  Created by Seda Kirakosyan on 13.09.25.
//

import SwiftUI
import PhotosUI
import CoreLocation



struct ProfileView: View {
    @State private var avatarImage: UIImage?
    @State private var pickerItem: PhotosPickerItem?
    
    private var avatarURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("avatar.jpg")
    }
    
    var body: some View {
        @AppStorage("profile.firstName") var firstName: String = ""
        @AppStorage("profile.lastName")  var lastName: String  = ""
        @AppStorage("profile.bio")       var bio: String       = ""
        @AppStorage("app.language") var lang: String = "en"
        
        VStack() {
            HStack {
                VStack {
                    PhotosPicker(selection: $pickerItem, matching: .images) {
                        if let ui = avatarImage {
                            Image(uiImage: ui).resizable()
                        } else {
                            Image(systemName: "person.crop.circle.fill").resizable().foregroundStyle(.gray)
                        }
                        
                    }
                    .scaledToFill()
                   .frame(width: 110, height: 110)
                   .clipShape(Circle())
                   .overlay(Circle().stroke(.secondary, lineWidth: 1))
                    
                    if avatarImage != nil {
                        Button("Remove avatar") {
                            avatarImage = Image(systemName: "person.crop.circle.fill").resizable().foregroundStyle(.gray) as? UIImage
                        }
                        .foregroundStyle(.red)
                    }
                    
                }
                .padding()
                
                VStack(alignment: .leading) {
                    VStack(spacing: 0) {
                        TextField("First name", text: $firstName)
                            .textContentType(.givenName)
                            .textInputAutocapitalization(.words)
                            .autocorrectionDisabled()
                            .submitLabel(.next)
                            .fontWeight(.bold)
                            .font(.title2)

                        TextField("Last name", text: $lastName)
                            .textContentType(.familyName)
                            .textInputAutocapitalization(.words)
                            .autocorrectionDisabled()
                            .submitLabel(.next)
                            .fontWeight(.bold)
                            .font(.title2)
                    }
                    HStack {
                        Image(systemName: "location.fill").foregroundStyle(.secondary)
                        Text("Location")
                    }
                    
                    
                }
                .padding()
                
                
            }
            VStack() {
                GroupBox {
                    Picker("", selection: $lang) {
                        Text("English").tag("en")
                        Text("Հայերեն").tag("hy")
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    
                }
                .padding(.horizontal)
                .foregroundStyle(.white)
                TextField("About me",   text: $bio, axis: .vertical)
                .frame(maxWidth: .infinity,
                       minHeight: 44)
            }
            .padding()
            Spacer()
        }
        
        .navigationTitle("Profile page")
        .task {
            if avatarImage == nil, FileManager.default.fileExists(atPath: avatarURL.path) {
                avatarImage = UIImage(contentsOfFile: avatarURL.path)
            }
        }
        .task(id: pickerItem) {
            guard let item = pickerItem,
                  let data = try? await item.loadTransferable(type: Data.self),
                  let image = UIImage(data: data) else { return }
            avatarImage = image
            
            try? data.write(to: avatarURL, options: .atomic)
                        avatarImage = image
        }
    }
}


#Preview {
    ProfileView()
}
