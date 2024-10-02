//
//  ContentModel.swift
//  swiftUIPropertyChange
//
//  Created by 김태성 on 10/2/24.
//

import Foundation

class ClassModel: Identifiable {
    
    var id = UUID()
    
    var name: String {
        willSet(newValue) {
            print("name : \(name) -> \(newValue) willSet");
        }
        didSet {
            print("name : \(name) didSet");
        }
    }
    
    var content: String {
        willSet(newValue) {
            print("content : \(content) -> \(newValue) willSet");
        }
        didSet {
            print("content : \(content) didSet");
        }
    }
    
    init(name: String, content: String) {
        self.name = name
        self.content = content
    }
}

struct StructModel: Identifiable {
    var id = UUID()
    
    var name: String {
        willSet(newValue) {
            print("name : \(name) -> \(newValue) willSet");
        }
        didSet {
            print("name : \(name) didSet");
        }
    }
    
    var content: String {
        willSet(newValue) {
            print("content : \(content) -> \(newValue) willSet");
        }
        didSet {
            print("content : \(content) didSet");
        }
    }
}
