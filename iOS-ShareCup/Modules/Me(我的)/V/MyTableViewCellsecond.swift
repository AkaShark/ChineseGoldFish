//
//  MyTableViewCellsecond.swift
//  Trail
//
//  Created by kys-2 on 2018/10/5.
//  Copyright © 2018年 kys-2. All rights reserved.
//

import UIKit

class secondcell: UITableViewCell{
    var labelscrollview = UILabel()
    var  timeLab = UILabel()
    var timelbe = UILabel()
//    let subtitle = UIImageView()
    let subtitle = UIView()
    
    required  init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
        timeLab = UILabel(frame:CGRect(x:0,y:0,width:60,height:18))
        timeLab.backgroundColor = UIColor.white
        timeLab.textColor = UIColor.black
        timeLab.textAlignment = .right
        timeLab.font = UIFont.systemFont(ofSize: 18)
        
//        subtitle.frame = CGRect(x: 65, y: 30, width: 6, height: 23)
//        subtitle.backgroundColor = UIColor.init(displayP3Red: 47/255.0, green: 49/255.0, blue: 237/255.0, alpha: 1.0)
//        subtitle.layer.cornerRadius = 5
        
        
        timelbe = UILabel(frame:CGRect(x:0,y:18,width:60,height:12))
        timelbe.backgroundColor = UIColor.white
        timelbe.textColor = UIColor.gray
        timelbe.textAlignment = .right
        timelbe.font = UIFont.systemFont(ofSize: 12)
        
        
        labelscrollview.font = UIFont.systemFont(ofSize:18)
        labelscrollview.numberOfLines = 3
        labelscrollview.textColor = UIColor.black
        labelscrollview.textAlignment = .left
        
        
//        self.addSubview(subtitle)
        self.addSubview(timeLab)
        self.addSubview(timelbe)
        self.addSubview(labelscrollview)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

