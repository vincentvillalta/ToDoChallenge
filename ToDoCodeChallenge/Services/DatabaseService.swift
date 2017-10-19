//
//  DatabaseService.swift
//  ToDoCodeChallenge
//
//  Created by Vincent Villalta on 10/18/17.
//  Copyright © 2017 Vincent Villalta. All rights reserved.
//

import GRDB


/// Wrapper to interact with the database initialization
struct DatabaseService {
    
    /// Open the database
    ///
    /// - Parameter path: Database location
    /// - Returns: Database reference
    /// - Throws: In case the database can not be opened should throw an exception
    static func openDatabase(atPath path: String) throws -> DatabaseQueue {
        dbQueue = try DatabaseQueue(path: path)
        try migrator.migrate(dbQueue)
        return dbQueue
    }
        
    /// Migrator is in charge of database migration, in case of schema alteration
    static var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        migrator.registerMigration("createTasks") { db in
            try db.create(table: "Tasks") { t in
                t.column("id", .integer).primaryKey()
                t.column("title", .text).notNull().collate(.localizedCaseInsensitiveCompare)
                t.column("createdAt", .integer).notNull()
                t.column("completedAt", .integer)
                t.column("completed", .integer).notNull()
            }
        }
        
        return migrator
    }
}

