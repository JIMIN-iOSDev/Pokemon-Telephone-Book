//
//  PhoneNumberData.swift
//  Pokemon Telephone Book
//
//  Created by Jimin on 12/11/24.
//

import Foundation

class PhoneNumberData {
    
    var contacts: [PhoneBook] = []
    
    func loadContacts() {
        if let data = UserDefaults.standard.data(forKey: "contacts") {
            let decoder = JSONDecoder()
            if let decodedContacts = try? decoder.decode([PhoneBook].self, from: data) {
                self.contacts = decodedContacts
            }
        }
    }
    
    func addContact(_ contact: PhoneBook) {
        contacts.append(contact)
        saveContacts()
    }
    
    private func saveContacts() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(contacts) {
            UserDefaults.standard.set(encoded, forKey: "contacts")
        }
    }
    
    func allContacts() -> [PhoneBook] {
        return contacts
    }
}
