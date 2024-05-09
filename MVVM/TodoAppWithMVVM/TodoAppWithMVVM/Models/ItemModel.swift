//
//  ItemModel.swift
//  TodoAppWithMVVM
//
//  Created by 김태성 on 5/9/24.
//

import Foundation

struct ItemModel: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let isCompleted: Bool
}
