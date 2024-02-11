//
//  ObjectiveModel.swift
//  Objectives
//
//  Created by J. DeWeese on 2/9/24.
//



import SwiftUI
import SwiftData

@Model
class Objective {
    var title: String = ""
    var remark: String = ""
    var dateAdded: Date = Date.now
    var dateStarted: Date = Date.distantPast
    var dateCompleted: Date = Date.distantPast
    var summary: String = ""
    var status: Status.RawValue = Status.onShelf.rawValue
    @Relationship(deleteRule: .cascade)
    var notes: [Note]?
    @Relationship(inverse: \Target.objectives)
    var target: [Target]?
    
    
    init(
        title: String,
        remark: String,
        dateAdded: Date = Date.now,
        dateStarted: Date = Date.distantPast,
        dateCompleted: Date = Date.distantPast,
        status: Status = .onShelf
   
    ) {
        self.title = title
        self.remark = remark
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.status = status.rawValue
    }
    
    var icon: Image {
        switch Status(rawValue: status)! {
        case .design:
            Image(systemName: "books.vertical.fill")
        case .planning:
            Image(systemName: "checkmark.diamond.fill")
        case .inProcess:
            Image(systemName: "book.fill")
        case .validating:
            Image(systemName: "books.vertical.fill")
        case .completed:
            Image(systemName: "books.vertical.fill")
        case .onHold:
            Image(systemName: "books.vertical.fill")
        case .AAR:
            Image(systemName: "books.vertical.fill")
        case .onShelf:
            Image(systemName: "books.vertical.fill")
        }
    }
}


enum Status: Int, Codable, Identifiable, CaseIterable {
    case onShelf, inProcess, completed, design, planning, validating, onHold, AAR
    var id: Self {
        self
    }
    var descr: LocalizedStringResource {
        switch self {
        case .onShelf:
            "On Shelf"
        case .inProcess:
            "In Process"
        case .completed:
            "Completed"
        case .design:
            "Design"
        case .validating:
            "Validating"
        case .AAR:
            "After Action Review"
        case .onHold:
            "Objective on Hold"
        case .planning:
            "Planning"
        }
    }
}


