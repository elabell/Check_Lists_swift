//
//  ChecklistItemCell.swift
//  Check_Lists_swift
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class ChecklistItemCell: UITableViewCell {

    
    @IBOutlet weak var LabelItem: UILabel!
    
    @IBOutlet weak var CheckLabel: UILabel!
    
  /*
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(LabelItem)
        addSubview(CheckLabel)
        
    }
    */
/*
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  */
 
    func isVissible(){
        
      LabelItem.isHidden = false
      CheckLabel.isHidden = false
        
    }
    
    func isInVissible(){
        
        LabelItem.isHidden = true
        CheckLabel.isHidden = true
        
    }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
