//
//  User-ViewModel.swift
//  Milestone5
//
//  Created by admin on 20.09.2022.
//

import Foundation
import UIKit

@MainActor class ViewModel: ObservableObject {
    @Published var users: [User] = [User]()
   
    func save(pickedImage: UIImage?) {
        guard let pickedImage = pickedImage else { return }
        let imageSaver = ImageSaver()
        imageSaver.successHandler = {
            print("Saved to gallery")
        }
    }
}

struct User: Identifiable {
    var id: UUID = UUID()
    var firstName: String
    var lastName: String
    var age: Int
    var about: String
    var isActive: Bool
}
