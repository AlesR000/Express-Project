//
//  CollectionController.swift
//  Express
//
//  Created by Alessandro Rippa on 06/12/24.
//

import CoreData
import Foundation

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "Collection")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading Core Data: \(error.localizedDescription)")
            }
        }
    }
}
