//
//  ObjectiveScreen.swift
//  Objectives
//
//  Created by J. DeWeese on 2/10/24.
//

import SwiftUI
import SwiftData


enum SortOrder: LocalizedStringResource, Identifiable, CaseIterable {
    case status, title, remarks
    
    var id: Self {
        self
    }
}
struct ObjectiveScreen: View {
    @AppStorage ("isFirstTime") private var isFirstTime: Bool = false
    @State private var addObjective: Bool = false
    @State private var showSideMenu: Bool = false
    @State private var showEditObjectiveView: Bool = false
    @Environment(\.modelContext) private var context
    @State private var sortOrder = SortOrder.status
    @State private var filter = ""
    
    
    var body: some View {
        NavigationStack {
            Picker("", selection: $sortOrder) {
                ForEach(SortOrder.allCases) { sortOrder in
                    Text(" \(sortOrder.rawValue)").tag(sortOrder)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            ///ObjectiveListView
            ObjectiveListView(sortOrder: sortOrder, filterString: filter )
                .searchable(text: $filter, prompt: Text("Search with Title or Author "))
        }
            }
        }
#Preview {
    ObjectiveScreen()
}

struct ObjectiveListView: View {
    @State private var sortOrder = SortOrder.status
    @Query private var objectives: [Objective]
    @State private var filter = ""
    @State private var addObjective: Bool = false
    init(sortOrder: SortOrder, filterString: String) {
        let sortDescriptors: [SortDescriptor<Objective>] = switch sortOrder {
        case .status:
            [SortDescriptor(\Objective.status), SortDescriptor(\Objective.title)]
        case .title:
            [SortDescriptor(\Objective.title)]
        case .remarks:
            [SortDescriptor(\Objective.remark)]
        }
        let predicate = #Predicate<Objective> { objective in
            objective.title.localizedStandardContains(filterString)  ||  objective.remark.localizedStandardContains(filterString)  ||  filterString.isEmpty
        }
        _objectives = Query(filter: predicate, sort: sortDescriptors)
    }
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(objectives) { objective in
                    NavigationLink{
                        EditObjectiveView()
                    }label: {
                        VStack {
                            ZStack {
                                VStack{
                                    HStack {
                                        Image(systemName: "scope")
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                            .fontWeight(.heavy)
                                            .foregroundStyle(.colorBlue)
                                        
                                        Text(objective.title)
                                            .font(.title2)
                                            .fontDesign(.serif)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.blue)
                                        Spacer()
                                        Text(objective.remark)
                                            .padding(4)
                                            .foregroundStyle(.gray)
                                            .font(.caption)
                                        Spacer()
                                    }
                                    }
                                    .padding()
                                }
                            }
                            .background(.titanium)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
                        .padding(.horizontal,3)
                        .frame(maxHeight: 200)
                    }
                    }
                }//lazy stack
                .navigationDestination(for: Objective.self) { objective in
                }
            }//list
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .toolbar{
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        HapticManager.notification(type: .success)
                    } label: {
                        Image(systemName: "line.3.horizontal.circle.fill")
                            .font(.title3)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Button {
                        HapticManager.notification(type: .success)
                    } label: {
                        HStack{
                            Image(systemName: "scope")
                                .resizable()
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text("bjectives")
                                .fontDesign(.serif)
                                .font(.title)
                                .fontWeight(.bold)
                                .offset(x: -8.0)
                        }.foregroundStyle(.colorBlue)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        HapticManager.notification(type: .success)
                        addObjective = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                    }
                }
                }
            .sheet(isPresented: $addObjective){
                AddObjectiveView()
                    .presentationDetents([.medium])
            }
        }
    }

