//
//  AddContactView.swift
//  Milestone5
//
//  Created by admin on 20.09.2022.
//

import SwiftUI

struct AddContactView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var userVM: ViewModel
    
    @State private var name = ""
    @State private var lastName = ""
    @State private var age = 5
    
    @State private var pickedImage: UIImage?
    @State private var showingImagePicker = false
    
    var body: some View {
        ZStack {
            VStack {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .padding(35)
                    .background(.regularMaterial)
                    .clipShape(Circle())
                    .onTapGesture {
                        withAnimation {
                            showingImagePicker = true
                        }
                    }
                
                Spacer()
                
                Form {
                    Section {
                        TextField("Enter name", text: $name)
                        TextField("Enter last name", text: $lastName)
                            
                    }
                    Section {
                        Stepper(age == 1 ? "1 year" : "\(age) years", value: $age, in: 1...100, step: 1)
                    } header: {
                        Text("pick age")
                    }
                }
                
                HStack {
                    Spacer()
                    ZStack(alignment: .center) {
                        Capsule(style: .circular)
                            .frame(width: 100, height: 50)
                            .padding([.top, .trailing])
                            .foregroundColor(.teal)
                        Text("save.")
                            .font(.system(size: 24))
                            .padding([.top, .trailing])
                        
                    }
                    .onTapGesture {
                        userVM.save(pickedImage: pickedImage)
                        saveChanges()
                        dismiss()
                    }
                    
                }
                
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $pickedImage)
        }
    }
    func saveChanges() {
        var newContact = User(firstName: name, lastName: lastName, age: age, about: "", isActive: false)
        userVM.users.append(newContact)
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView(userVM: ViewModel())
    }
}
