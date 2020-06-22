//
//  TableViewCell.swift
//  APIRequest
//
//  Created by admin on 6/22/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    
    
    
    let SCREEN_WIDTH   =   UIScreen.main.bounds.size.width
    let SCREEN_HEIGHT  =   UIScreen.main.bounds.size.height
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func setView(){
        
       
        
        userID.frame.origin = CGPoint(x: 10, y: 10)
        userID.frame.size = CGSize(width: SCREEN_WIDTH - 20, height: 9999)
        userID.sizeToFit()
        userID.numberOfLines = 0
       
        
    
        id.frame.origin = CGPoint(x: 10 , y: 10 + userID.bounds.height)
        id.sizeToFit()
        id.numberOfLines = 0
        id.frame.size = CGSize(width: SCREEN_WIDTH - 20, height: id.bounds.height)
        
        title.frame.origin = CGPoint(x: 10 , y: 10 + id.bounds.height + userID.bounds.height)
        title.sizeToFit()
        title.numberOfLines = 0
        title.frame.size = CGSize(width: SCREEN_WIDTH - 20, height: title.bounds.height)
        
        body.frame.origin = CGPoint(x: 10 , y: 20 + userID.bounds.height + id.bounds.height + title.bounds.height)
         body.frame.size = CGSize(width: SCREEN_WIDTH - 20, height: 9999)
        body.numberOfLines = 0
        body.sizeToFit()
        
//        body.frame.size = CGSize(width: SCREEN_WIDTH - 20, height: body.frame.height)
        
        let height = userID.bounds.height + id.bounds.height + title.bounds.height + body.bounds.height + 65
        self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 147)
        
        print(self.bounds.height)
        
    }
    
}
