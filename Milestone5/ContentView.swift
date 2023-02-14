//
//  ContentView.swift
//  Milestone5
//
//  Created by admin on 20.09.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var userVM = ViewModel()
    @State private var showingAddView = false
    @State private var pickedImage: UIImage?
    var body: some View {
        VStack {
            ZStack {
                Color(red: 0.35, green: 0.4, blue: 0.5)
                    
                    
                if userVM.users.isEmpty {
                    VStack {
                      Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 90)
                            .background(Color(red: 0.35, green: 0.6, blue: 0.7, opacity: 0.7))
                            .clipShape(Circle())
                            .onTapGesture {
                                showingAddView = true
                            }
                        Text("Add new contact")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                    }
                    .padding()
                    .frame(width: 200, height: 250)
                    .background(.regularMaterial)
                    .cornerRadius(15)
                    .sheet(isPresented: $showingAddView) {
                        AddContactView(userVM: userVM)
                    }
                    
                } else {
                    List {
                        ForEach(userVM.users) { user in
                            HStack {
                                VStack {
                                    Text(user.firstName)
                                        .font(.headline)
                                    Text(user.lastName)
                                        .font(.subheadline)
                                    
                                }
                                Text(String(user.age))
                                    .font(.headline)
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
