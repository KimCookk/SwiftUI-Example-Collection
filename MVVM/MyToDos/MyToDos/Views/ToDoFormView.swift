//
//  ToDoFormView.swift
//  MyToDos
//
//  Created by 김태성 on 7/9/24.
//

import SwiftUI

struct ToDoFormView: View {
    @EnvironmentObject var dataStore: DataStore
    @ObservedObject var formVM: ToDoFormViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading) {
                    TextField("ToDo", text: $formVM.name)
                    Toggle("Completed", isOn: $formVM.completed)
                }
            }
            .navigationTitle("ToDo")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: cancleButton,
                                trailing: updateSaveButton)
        }
       
    }
}

extension ToDoFormView {
    func updateToDo() {
        if let id = formVM.id {
            let toDo = ToDo(id: id, name: formVM.name, completed: formVM.completed)
            dataStore.updateToDo(toDo)
        }
        
        presentationMode.wrappedValue.dismiss()
    }
    
    func addToDo() {
        let toDo = ToDo(name: formVM.name)
        dataStore.addToDo(toDo)
        
        presentationMode.wrappedValue.dismiss()
    }
    
    var cancleButton: some View {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    var updateSaveButton: some View {
        Button(formVM.updating ? "Update" : "Save",
               action: formVM.updating ? updateToDo : addToDo)
        .disabled(formVM.isDisabled)
    }
}

#Preview {
    ToDoFormView(formVM: ToDoFormViewModel())
        .environmentObject(DataStore())
}
