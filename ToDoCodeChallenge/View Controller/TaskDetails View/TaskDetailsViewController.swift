//
//  TaskDetailsViewController.swift
//  ToDoCodeChallenge
//
//  Created by Vincent Villalta on 10/19/17.
//  Copyright © 2017 Vincent Villalta. All rights reserved.
//

import UIKit

class TaskDetailsViewController: UIViewController {
    @IBOutlet var markAsCompleteButton: UIButton!
    @IBOutlet var emoji: UILabel!
    @IBOutlet var completeAtLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    
    var task: Task!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    /// Configure the UI to show the view
    ///
    /// - Parameter task: reference task
    func configureView(_ task: Task){
        self.task = task
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        print(task)
        self.contentLabel.isHidden = false
        self.markAsCompleteButton.isHidden = self.task.completed
        self.emoji.isHidden = !self.task.completed
        self.completeAtLabel.isHidden = !self.task.completed
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        self.completeAtLabel.text = self.task.completedAt != nil ? "Great, you completed this tasks on \(dateFormatter.string(from: task.completedAt!))" : ""
        self.contentLabel.text = self.task.title
    }
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func markAsCompleteAction(_ sender: UIButton) {
        TaskService.update(self.task)
        configureView(self.task)
    }
}
