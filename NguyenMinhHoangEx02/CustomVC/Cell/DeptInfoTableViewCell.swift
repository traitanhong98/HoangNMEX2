//
//  DeptInfoTableViewCell.swift
//  NguyenMinhHoangEx02
//
//  Created by Hoang on 11/14/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class DeptInfoTableViewCell: UITableViewCell {
    static let identifier = "DeptInfoTableViewCell"
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var deptLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var minimizeDeptLabel: UILabel!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var detailView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(person: Person) {
        nameLabel.text = person.name
        descriptionLabel.text = person.content
        deptLabel.text = person.money
        minimizeDeptLabel.text = person.money
        dateLabel.text = person.time
    }
    func changeMode(seeMode: SeeMode) {
        switch seeMode {
        case .maximize:
            descriptionView.isHidden = false
            detailView.isHidden = false
            minimizeDeptLabel.isHidden = true
        case .minimize:
            descriptionView.isHidden = true
            detailView.isHidden = true
            minimizeDeptLabel.isHidden = false
        }
    }
}
