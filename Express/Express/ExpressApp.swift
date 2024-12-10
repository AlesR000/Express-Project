//
//  ExpressApp.swift
//  Express
//
//  Created by Alessandro Rippa on 09/12/24.
//

import SwiftUI

@main
struct ExpressApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        
        WindowGroup {
            Home()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
    
}
