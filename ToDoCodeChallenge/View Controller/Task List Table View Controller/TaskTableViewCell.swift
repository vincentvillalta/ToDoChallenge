//
//  TaskTableViewCell.swift
//  ToDoCodeChallenge
//
//  Created by Vincent Villalta on 10/19/17.
//  Copyright © 2017 Vincent Villalta. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var completedCheckMark: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    /// Prepare UI for reuse
    override func prepareForReuse() {
        self.createdAtLabel.text = ""
        self.contentLabel.text = ""
        self.completedCheckMark.isHidden = true
    }
    
    
    /// Configure individual cell
    ///
    /// - Parameter task: Reference task for cel
    func configure(_ task: Task) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        self.createdAtLabel.text = "Created at \(dateFormatter.string(from: task.createdAt))"
        self.contentLabel.text = task.title
        self.completedCheckMark.isHidden = !task.completed 
    }
}
