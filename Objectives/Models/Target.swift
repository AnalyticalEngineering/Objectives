//
//  Target.swift
//  Objectives
//
//  Created by J. DeWeese on 2/10/24.
//

import SwiftUI
import SwiftData


@Model
class Target {
    var name: String = ""
    var color: String = "FF0000"
    var objectives: [Objective]?
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    var hexColor: Color {
        Color(hex: self.color) ?? .red
    }
}

