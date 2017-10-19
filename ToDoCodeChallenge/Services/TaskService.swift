//
//  TaskService.swift
//  ToDoCodeChallenge
//
//  Created by Vincent Villalta on 10/17/17.
//  Copyright © 2017 Vincent Villalta. All rights reserved.
//

import UIKit
import GRDB
import RxGRDB


/// Task service is in charge of the hole CRUD interaction for the model
struct TaskService {
    
    /// Update a task
    ///
    /// - Parameter task: Reference task
    static func update(_ task: Task){
        try! dbQueue.inDatabase { db in
            task.completed = true
            task.completedAt = Date()
            try task.update(db)
        }
    }
    
    
    /// Delete a task
    ///
    /// - Parameter task: Reference task
    static func delete(task: Task){
        try! dbQueue.inDatabase { db in
            try task.delete(db)
        }
    }
    
    
    /// Create a new task, the id will increment by itself
    ///
    /// - Parameter task: New task to insert
    static func insert(task: Task) {
        try! dbQueue.inDatabase { db in
            try task.insert(db)
            print("Inserted")
        }
    }
    
    
    /// Load tasks
    ///
    /// - Returns: Array of Tasks objects
    static func loadTasks() -> [Task]{
        var T:[Task] = []
        try! dbQueue.inDatabase { db in
            T = try Task.fetchAll(db, "SELECT * FROM Tasks")
        }
        return T
    }
    
}
