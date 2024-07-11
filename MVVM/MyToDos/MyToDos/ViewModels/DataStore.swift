//
//  DataStore.swift
//  MyToDos
//
//  Created by 김태성 on 7/9/24.
//

import Foundation
import Combine

class DataStore: ObservableObject {
//    @Published var toDos: [ToDo] = []
    var toDos = CurrentValueSubject<[ToDo], Never>([])
//    @Published var appError: ErrorType? = nil
    var appError = CurrentValueSubject<ErrorType?, Never>(nil)
    var addToDo = PassthroughSubject<ToDo, Never>()
    var updateToDo = PassthroughSubject<ToDo, Never>()
    var deleteToDo = PassthroughSubject<IndexSet, Never>()
    var loadToDos = Just(FileManager.docDirURL.appendingPathComponent(fileName))
    
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        print(FileManager.docDirURL.path)
        addSubscriptions()
    }
    
    func addSubscriptions() {
        appError
            .sink { _ in
                self.objectWillChange.send()
            }
            .store(in: &subscriptions)
        
        loadToDos
            .filter { FileManager.default.fileExists(atPath: $0.path)}
            .tryMap { url in
                try Data(contentsOf: url)
            }
            .decode(type: [ToDo].self, decoder: JSONDecoder())
            .subscribe(on: DispatchQueue(label: "background queue"))
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] completion in
                switch completion {
                case .finished:
                    print("Loading")
                    todosSubscriptions()
                case .failure(let error):
                    if error is ToDoError {
                        appError.send(ErrorType(error: error as! ToDoError))
                    } else {
                        appError.send(ErrorType(error: ToDoError.decodingError))
                        todosSubscriptions()
                    }
                }
            } receiveValue: { (toDos) in
                self.objectWillChange.send()
                self.toDos.value = toDos
            }
            .store(in: &subscriptions)

        
        addToDo.sink { [unowned self] toDo in
            self.objectWillChange.send()
            toDos.value.append(toDo)
            //saveToDos()
        }
        .store(in: &subscriptions)
        
        updateToDo.sink { [unowned self] toDo in
            guard let index = toDos.value.firstIndex(where: {$0.id == toDo.id}) else {
                return
            }
            self.objectWillChange.send()
            toDos.value[index] = toDo
        }
        .store(in: &subscriptions)
        
        deleteToDo.sink { [unowned self] indexSet in
            self.objectWillChange.send()
            toDos.value.remove(atOffsets: indexSet)
            //saveToDos()
        }
        .store(in: &subscriptions)
    }
    
    func todosSubscriptions() {
        toDos
            .subscribe(on: DispatchQueue(label: "background queue"))
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .encode(encoder: JSONEncoder())
            .tryMap { data in
                try data.write(to: FileManager.docDirURL.appendingPathComponent(fileName))
            }
            .sink { [unowned self] (completion) in
                switch completion {
                case .finished:
                    print("Saving Completed")
                case .failure(let error):
                    if error is ToDoError {
                        appError.send(ErrorType(error: error as! ToDoError))
                    } else {
                        appError.send(ErrorType(error: ToDoError.encodingError))
                    }
                }
            } receiveValue: { _ in
                print("Saving file was successful")
            }
            .store(in: &subscriptions)
    }
    
    func addToDo(_ toDo: ToDo) {
        toDos.value.append(toDo)
        //saveToDos()
    }
    
    func updateToDo(_ toDo: ToDo) {
        guard let index = toDos.value.firstIndex(where: {$0.id == toDo.id}) else {
            return
        }
        
        toDos.value[index] = toDo
        //saveToDos()
    }
    
    func deleteToDo(at indexSet: IndexSet) {
        toDos.value.remove(atOffsets: indexSet)
        //saveToDos()
    }
    
    
//    func saveToDos() {
//        print("Saving toDos to file system eventually")
//        let encoder = JSONEncoder()
//        do {
//            let data = try encoder.encode(toDos)
//            let jsonString = String(decoding: data, as: UTF8.self)
//            
//            FileManager().saveDocument(contents: jsonString, docName: fileName) { error in
//                if let error = error {
////                    print(error.localizedDescription)
//                    appError = ErrorType(error: error)
//                }
//            }
//        } catch {
////            print(ToDoError.encodingError.localizedDescription)
//            appError = ErrorType(error: .encodingError)
//        }
//    }
}
