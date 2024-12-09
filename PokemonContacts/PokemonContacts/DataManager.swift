//
//  DataManager.swift
//  PokemonContacts
//
//  Created by 반성준 on 12/9/24.
//

import CoreData
import UIKit

class DataManager {
    static let shared = DataManager()

    private init() {}

    var context: NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Unable to get AppDelegate")
        }
        return appDelegate.persistentContainer.viewContext
    }

    func saveContact(name: String, phoneNumber: String, profileImageURL: String) {
        let contact = Contact(context: context)
        contact.name = name
        contact.phoneNumber = phoneNumber
        contact.profileImageURL = profileImageURL
        saveContext()
    }

    func updateContact(_ contact: Contact, name: String, phoneNumber: String, profileImageURL: String) {
        contact.name = name
        contact.phoneNumber = phoneNumber
        contact.profileImageURL = profileImageURL
        saveContext()
    }

    func deleteContact(_ contact: Contact) {
        context.delete(contact)
        saveContext()
    }

    func fetchAllContacts() -> [Contact] {
        return Contact.fetchAll(context: context)
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
        }
    }
}
