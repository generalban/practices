//
//  Contact+Extensions.swift
//  PokemonContacts
//
//  Created by 반성준 on 12/9/24.
//

import CoreData

extension Contact {
    /// Fetch all contacts from Core Data
    static func fetchAll(context: NSManagedObjectContext) -> [Contact] {
        let request = NSFetchRequest<Contact>(entityName: "Contact")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        do {
            let contacts = try context.fetch(request)
            print("Fetched contacts: \(contacts.count)") // 디버깅용 로그
            return contacts
        } catch let error {
            print("Failed to fetch contacts: \(error)")
            return []
        }
    }
}
