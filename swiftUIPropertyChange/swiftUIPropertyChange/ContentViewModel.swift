//
//  ContentViewModel.swift
//  swiftUIPropertyChange
//
//  Created by 김태성 on 10/2/24.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var unitClassModel: ClassModel { 
        willSet(newValue) {
            print("unitClassModel willSet");
        }
        didSet {
            print("unitClassModel didSet");
        }
    }
    
    @Published var unitStructModel: StructModel {
        willSet(newValue) {
            print("unitStructModel willSet");
        }
        didSet {
            print("unitStructModel didSet");
        }
    }
    
    @Published var unitClassModelArray: [ClassModel] {
        willSet(newValue) {
            print("unitClassModelArray willSet");
        }
        didSet {
            print("unitClassModelArray didSet");
        }
    }
    
    @Published var unitStructModelArray: [StructModel] {
        willSet(newValue) {
            print("unitStructModelArray willSet");
        }
        didSet {
            print("unitStructModelArray didSet");
        }
    }

    
    init(unitClassModel: ClassModel, 
         unitStructModel: StructModel,
         unitClassModelArray: [ClassModel],
         unitStructModelArray: [StructModel]) {
        self.unitClassModel = unitClassModel
        self.unitStructModel = unitStructModel
        self.unitClassModelArray = unitClassModelArray
        self.unitStructModelArray = unitStructModelArray
    }
    
    init() {
        self.unitClassModel = ClassModel(name: "class1", content: "class1Content")
        self.unitStructModel = StructModel(name: "struct1", content: "struct1Content")
        self.unitClassModelArray = [ClassModel(name: "classArray1", content: "classArray1Cotnent")]
        self.unitStructModelArray = [StructModel(name: "structArray1", content: "structArray1Content")]
    }
    
    func unitClassModelChange() {
        unitClassModel.content += "c"
    }
    
    func unitStructModelChange() {
        unitStructModel.content += "c"
    }
    
    func unitClassModelArrayRandomChange() {
        if var randomUnit = unitClassModelArray.randomElement() {
            randomUnit.content += "t"
        }
        unitClassModelArray.randomElement()?.content += "t"
    }
    
    func unitStructModelArrayRandomChange() {
//        if var randomUnit = unitStructModelArray.randomElement() {
//            randomUnit.content += "t"
//        }
        
        unitStructModelArray[0].content += "t"
    }
    
    func unitClassModelArrayAdd() {
        unitClassModelArray.append(ClassModel(name: "testClassModel", content: "classModel Content"))
    }
    
    func unitStructModelArrayAdd() {
        unitStructModelArray.append(StructModel(name: "testStructModel", content: "structModel Content"))
    }
}
