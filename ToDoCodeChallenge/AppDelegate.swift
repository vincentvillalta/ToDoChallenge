//
//  AppDelegate.swift
//  ToDoCodeChallenge
//
//  Created by Vincent Villalta on 10/17/17.
//  Copyright © 2017 Vincent Villalta. All rights reserved.
//

import UIKit
import GRDB
import RxSwift
var dbQueue: DatabaseQueue!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Try to open the database, in case of error the app will raise an assertion
        do {
            try setupDatabase(application)
        } catch {
            assertionFailure("Error on database creation")
        }
        return true
    }
    
    /// Determine the place and name for the SQLite database
    ///
    /// - Parameter application: App context
    /// - Throws: in case the database can not be created (i.e. not existing folder or outside the sandbox) should throw an exception
    private func setupDatabase(_ application: UIApplication) throws {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
        let databasePath = documentsPath.appendingPathComponent("tasks.sqlite")
        dbQueue = try DatabaseService.openDatabase(atPath: databasePath)
        dbQueue.setupMemoryManagement(in: application)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

