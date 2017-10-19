//
//  Task.swift
//  ToDoCodeChallenge
//
//  Created by Vincent Villalta on 10/17/17.
//  Copyright © 2017 Vincent Villalta. All rights reserved.
//

import Foundation
import GRDB


/// Tasks model
class Task: Record {
    
    // MARK:  Properties
    var id: Int64?
    var title: String
    var createdAt: Date
    var completedAt: Date?
    var completed: Bool
    
    // MARK:  Init methods
    init(id: Int64?, title: String, createdAt: Date, completedAt: Date?, completed: Bool) {
        self.id = id
        self.title = title
        self.createdAt = createdAt
        self.completedAt = completedAt
        self.completed = completed
        super.init()
    }
    
    required init(row: Row) {
        id = row["id"]
        title = row["title"]
        createdAt = row["createdAt"]
        completedAt = row["completedAt"]
        completed = row["completed"]
        super.init(row: row)
    }
    
    ///Necesary to encode current data from the database to the Task model
    override func encode(to container: inout PersistenceContainer) {
        container["id"] = id
        container["title"] = title
        container["createdAt"] = createdAt
        container["completedAt"] = completedAt
        container["completed"] = completed
    }
    
    // Table that will be use to store the model
    override class var databaseTableName: String {
        return "Tasks"
    }
    
    
    
}
