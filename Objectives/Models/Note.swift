//
//  Note.swift
//  Objectives
//
//  Created by J. DeWeese on 2/10/24.
//

import Foundation
import SwiftData


@Model
class Note{
    var creationDate:  Date = Date.now
    var text:  String = ""
    var page:  String?
    
    init(text: String, page: String? = nil)  {
        
        self.text = text
        self.page = page
    }
    var objective: Objective?
}

