//
//  Task.swift
//  DragAndDropSection
//
//  Created by 김태성 on 5/5/24.
//

import Foundation

struct Task: Identifiable, Hashable {
    var id: UUID = .init()
    var title: String
    var status: Status
}

enum Status {
    case todo
    case working
    case completed
}
