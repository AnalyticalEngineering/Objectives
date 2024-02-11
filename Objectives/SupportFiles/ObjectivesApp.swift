//
//  ObjectivesApp.swift
//  Objectives
//
//  Created by J. DeWeese on 2/9/24.
//

import SwiftUI
import SwiftData


import SwiftUI
import SwiftData

@main
struct ObjectivesApp: App {
    let container: ModelContainer
    
    
    var body: some Scene {
        WindowGroup {
            TabBarHomeScreen()
        }
        .modelContainer(container)
    }
    init() {
     
        let schema = Schema([Objective.self])
        let config = ModelConfiguration("LegacyBooksApp", schema: schema)
        do{
            container = try ModelContainer(for: schema, configurations: config)
        }catch{
            fatalError("Could not configure container")
        }
        
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
               
        }
    }

