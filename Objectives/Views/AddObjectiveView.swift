//
//  AddObjectiveView.swift
//  Objectives
//
//  Created by J. DeWeese on 2/10/24.
//

import SwiftUI
import SwiftData



struct AddObjectiveView: View {
    ///Environment
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    ///Presenting Toast
   
    ///Properties
    @State private var title = ""
    @State private var remark = ""
    
    var body: some View {
        NavigationStack  {
            Form {
                TextField("Objective Title", text: $title)
                TextField("Summary of Objective", text: $remark)
                Button("Add"){
                    HapticManager.notification(type: .success)
                    let newObjective = Objective(title: title, remark: remark)
                    context.insert(newObjective)
                    dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .buttonStyle(.borderedProminent)
                .padding(.vertical)
                .disabled(title.isEmpty || remark.isEmpty)
                .navigationTitle( "Add Objective")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            HapticManager.notification(type: .success)
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AddObjectiveView()
}
