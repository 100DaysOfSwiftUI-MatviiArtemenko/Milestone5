//
//  SubscribeUserView.swift
//  TestingApp
//
//  Created by admin on 01/03/2023.
//

import SwiftUI

struct SubscribeUserView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @ObservedObject var dataController = DataController()
    
    let currentEvent: EventEntity
    
    @State private var userName = "Unknown"
    @State private var userAge = 18
    @State private var userRole = "Visitor"
    private let roles = ["Visitor", "Host", "Organiser", "Volunteer"]
    
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var saveImage: Data?
    @State private var showingImagePicker = false
    var body: some View {
        
        NavigationView {
            ZStack {
                AngularGradient(colors: [.yellow, .brown.opacity(0.7), .red], center: .trailing)
                    .grayscale(0.45) // can play with colors later
                    .ignoresSafeArea()
                    .scaleEffect(1.4)
                    .blur(radius: 10)
                    .overlay {
                        Color(.orange).opacity(0.125)
                            .ignoresSafeArea()
                    }
                
                VStack {
                    // MARK: image adding section ->
                    image?
                        .resizable()
                        .frame(width: 320, height: 300)
                        .scaledToFill()
                        .padding()
                        .padding(.top)
                        .onAppear {savedImage()}
                        .cornerRadius(16)

                    Button {
                        showingImagePicker = true
                    } label: {
                        Image(systemName: "photo.fill")
                    }
                    .foregroundColor(.secondary)
                    .padding()
                    .background(.thinMaterial)
                    .cornerRadius(14)
                    .padding(.vertical)
                    //MARK: <-
                    
                    Group {
                        TextField("Enter your name", text: $userName)
                        
                        Picker("Select your age...", selection: $userAge) {
                            ForEach(1..<100, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        
                        Picker("What is your role...", selection: $userRole) {
                            ForEach(roles, id: \.self) { role in
                                Text(role)
                            }
                        }
                    }
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .padding(.leading)
                    .background(.regularMaterial)
                    .cornerRadius(13)
                    .padding(.top)
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Button {
                        let newUser = UserEntity(context: moc)
                        newUser.image = saveImage
                        newUser.role = userRole
                        newUser.age = Int16(userAge)
                        newUser.name = userName
                        newUser.userId = UUID()
                        newUser.addToEvents(currentEvent)
                        try? moc.save()
                        dismiss()
                        
                    } label: {
                        Text("Save")
                            .foregroundColor(.secondary)
                    }
                    .padding(15)
                    .padding(.horizontal)
                    .background(.regularMaterial)
                    .cornerRadius(14)
                    .disabled(isValid())
                    
                }
            }
            
        }
        .sheet(isPresented: $showingImagePicker) { ImagePicker(image: $inputImage) }
        .onChange(of: inputImage) { _ in loadImage() }
        
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    func savedImage() {
        guard let inputImage = inputImage else { return }
        saveImage = inputImage.jpegData(compressionQuality: 1.0)
    }
    
    func isValid() -> Bool {
        if userName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            userRole.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return true
        } else {
            return false
        }
    }
}


