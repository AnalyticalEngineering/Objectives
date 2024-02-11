//
//  Tab.swift
//  Regimen
//
//  Created by J. DeWeese on 2/8/24.
//

import SwiftUI

enum Tab: String, CaseIterable {
   
    case objectives = "Objectives"
    case dailyReview = "Daily Review"
    case vision = "Vision"
   
    
    var systemImage: String {
        switch self {
      
        case .objectives:
            return "scope"
        case .dailyReview:
            return"shoeprints.fill"
        case .vision:
        return "doc.richtext"
        
            
        }
    }
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}

