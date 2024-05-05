//
//  HomeView.swift
//  DragAndDropSection
//
//  Created by 김태성 on 5/5/24.
//

import SwiftUI

struct HomeView: View {
    
    // Sample Task
    @State private var todo: [Task] = [
        .init(title: "Edit Video!", status: .todo)
    ]
    @State private var working: [Task] = [
        .init(title: "Record Video", status: .working)
    ]
    @State private var completed: [Task] = [
        .init(title: "Implement Drag & Drop", status: .completed),
        .init(title: "Update MockView App!", status: .completed)
    ]
    
    //View Properties
    @State private var currentlyDragging: Task?
    
    var body: some View {
        HStack(spacing: 2) {
            TodoView()
               
            WorkingView()
               
            CompletedView()
        }
    }
    
    // Todo View
    @ViewBuilder
    func TodoView() -> some View {
        NavigationStack {
            ScrollView(.vertical) {
                TaskListView(todo)
            }
            .navigationTitle("Todo")
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
        }
        .contentShape(.rect)
        .dropDestination(for: String.self) { items, location in
            withAnimation(.snappy) {
                appendTask(.todo)
            }
            return true
        } isTargeted: { _ in
            
        }
    }
    
    @ViewBuilder
    func WorkingView() -> some View {
        NavigationStack {
            ScrollView(.vertical) {
                TaskListView(working)
            }
            .navigationTitle("Working")
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
        }
        .contentShape(.rect)
        .dropDestination(for: String.self) { items, location in
            withAnimation(.snappy) {
                appendTask(.working)
            }
            return true
        } isTargeted: { _ in
            
        }
    }
    
    @ViewBuilder
    func CompletedView() -> some View {
        NavigationStack {
            ScrollView(.vertical) {
                TaskListView(completed)
            }
            .navigationTitle("Completed")
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
        }
        .contentShape(.rect)
        .dropDestination(for: String.self) { items, location in
            withAnimation(.snappy) {
                appendTask(.completed)
            }
            return true
        } isTargeted: { _ in
            
        }
    }
    
    @ViewBuilder
    func TaskListView(_ tasks: [Task]) -> some View {
        VStack(alignment: .leading, spacing: 10, content: {
            ForEach(tasks) { task in
                GeometryReader {
                    TaskView(task, $0.size)
                }
                .frame(height: 45)
            }
        })
    }
    
    @ViewBuilder
    func TaskView(_ task: Task, _ size: CGSize) -> some View {
        Text(task.title)
            .font(.callout)
            .padding(.horizontal, 15)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: size.height)
            .background(.white, in: .rect(cornerRadius: 10))
            .contentShape(.dragPreview, .rect(cornerRadius: 10))
            .draggable(task.id.uuidString) {
                Text(task.title)
                    .font(.callout)
                    .padding(.horizontal, 15)
                    .frame(width: size.width, height: size.height, alignment: .leading)
                    .background(.white)
                    .contentShape(.dragPreview, .rect(cornerRadius: 10))
                    .onAppear(perform: {
                        currentlyDragging = task
                    })
            }
            .dropDestination(for: String.self) { items, location in
                currentlyDragging = nil
                return false
            } isTargeted: { status in
                if let currentlyDragging, status, currentlyDragging.id != task.id {
                    withAnimation(.snappy) {
                        appendTask(task.status)

                        switch task.status {
                        case .todo:
                            replaceItem(tasks: &todo, droppingTask: task, status: .todo)
                        case .working:
                            replaceItem(tasks: &working, droppingTask: task, status: .working)
                        case .completed:
                            replaceItem(tasks: &completed, droppingTask: task, status: .completed)
                            
                        }
                    }
                }
            }
    }
    
    // Appending And Removing task from one List to another List
    func appendTask(_ status: Status) {
        if let currentlyDragging {
            switch status {
            case .todo:
                if !todo.contains(where: { $0.id == currentlyDragging.id}) {
                    var updatedTask = currentlyDragging
                    updatedTask.status = .todo
                    todo.append(updatedTask)
                    working.removeAll(where: { $0.id == currentlyDragging.id})
                    completed.removeAll(where: { $0.id == currentlyDragging.id})
                }
            case .working:
                if !working.contains(where: { $0.id == currentlyDragging.id}) {
                    var updatedTask = currentlyDragging
                    updatedTask.status = .working
                    working.append(updatedTask)
                    todo.removeAll(where: { $0.id == currentlyDragging.id})
                    completed.removeAll(where: { $0.id == currentlyDragging.id})
                }
            case .completed:
                if !completed.contains(where: { $0.id == currentlyDragging.id}) {
                    var updatedTask = currentlyDragging
                    updatedTask.status = .completed
                    completed.append(updatedTask)
                    working.removeAll(where: { $0.id == currentlyDragging.id})
                    todo.removeAll(where: { $0.id == currentlyDragging.id})
                }
            }
        }
    }
    
    // Replacing Items Within the List
    func replaceItem(tasks: inout [Task], droppingTask: Task, status: Status) {
        if let currentlyDragging {
            if let sourceIndex = tasks.firstIndex(where: {$0.id == currentlyDragging.id}),
               let destinationIndex = tasks.firstIndex(where: {$0.id == droppingTask.id}) {
                // Swapping Item's on the List
                var sourceItem = tasks.remove(at: sourceIndex)
                sourceItem.status = status
                tasks.insert(sourceItem, at: destinationIndex)
            }
            
        }
    }
    
}

#Preview {
    HomeView()
}
