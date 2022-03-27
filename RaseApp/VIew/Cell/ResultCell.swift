//
//  ResultCell.swift
//  RaseApp
//
//  Created by Evgeny Trifonov on 25.03.2022.
//

import UIKit

class ResultCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel?
    @IBOutlet weak var expLabel: UILabel?
    
    func set(model: Result) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = " HH:mm (dd.MM.yy)"
        
        self.expLabel?.text = String(model.exp)
        self.dateLabel?.text = formatter.string(from: model.date)
    }

}
