//
//  CreateTaskViewController.swift
//  ToDoCodeChallenge
//
//  Created by Vincent Villalta on 10/19/17.
//  Copyright © 2017 Vincent Villalta. All rights reserved.
//

import UIKit

class CreateTaskViewController: UIViewController {

    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.configureUI()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /// Stylish the TextView
    func configureUI(){
        self.contentTextView.layer.borderWidth = 2
        self.contentTextView.layer.cornerRadius = 5
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    
    
    
    /// Save a new task
    @IBAction func saveTask(_ sender: UIButton) {
        let task = Task(id: nil, title: self.contentTextView.text, createdAt: Date(), completedAt: nil, completed: false)
        TaskService.insert(task: task)
        self.navigationController?.popViewController(animated: true)
    }
    
}
