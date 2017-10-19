//
//  TasksTableViewController.swift
//  ToDoCodeChallenge
//
//  Created by Vincent Villalta on 10/19/17.
//  Copyright © 2017 Vincent Villalta. All rights reserved.
//

import UIKit
import RxSwift
import RxGRDB
import GRDB

class TasksTableViewController: UITableViewController {
    var tasks: [Task] = []
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 140
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.disposeBag = DisposeBag()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupUI()
        /// Subscribe to events in database to update the UI
        let request = Task.all()
        request.rx.changes(in: dbQueue).subscribe(onNext: { Database in
            print("Task table has changed.")
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        self.tasks = TaskService.loadTasks()
        self.tableView.reloadData()
    }

    func setupUI(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "BG"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TaskTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TaskTableViewCell
        cell.configure(self.tasks[indexPath.row])
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            TaskService.delete(task: self.tasks[indexPath.row])
            self.tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)

           
        }
    }
    
    // MARK: - Table view delegate
    /// Size for rows
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    /// Manage the split view interaction
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            let detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController
                as? TaskDetailsViewController
            detailViewController?.configureView(self.tasks[(self.tableView.indexPathForSelectedRow?.row)!])
        }
    }
    
    /// Manage segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail"{
            let detailNavigationController = segue.destination as? UINavigationController
            let detailViewController = detailNavigationController?.topViewController as! TaskDetailsViewController
            let _ = detailViewController.view
            detailViewController.configureView(self.tasks[(self.tableView.indexPathForSelectedRow?.row)!])
            detailViewController.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
            detailViewController.navigationItem.leftItemsSupplementBackButton = true
            
        }
    }
    
    // Present new task composer
    @IBAction func showTaskComposer(_ sender: UIBarButtonItem) {
        let taskComposer = self.storyboard?.instantiateViewController(withIdentifier: "CreateTaskViewController") as! CreateTaskViewController
        self.navigationController?.pushViewController(taskComposer, animated: true)
    }
}
