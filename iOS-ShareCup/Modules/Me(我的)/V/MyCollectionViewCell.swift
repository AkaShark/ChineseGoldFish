//
//   MyCollectionViewCell.swift
//  Trail
//
//  Created by kys-2 on 2018/10/5.
//  Copyright © 2018年 kys-2. All rights reserved.
//

import UIKit
class MyCollectionViewCell: UICollectionViewCell {
    
    //用于显示封面缩略
    var tableimage = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
//        //设置边框
//        if #available(iOS 10.0, *) {
//            tableimage.layer.backgroundColor = UIColor(displayP3Red: 0.61, green: 0.61, blue: 0.61, alpha: 0.61).cgColor
//        } else {
//            // Fallback on earlier versions
//        }
       
        
        
    }
    override init(frame: CGRect) {
        
        super.init(frame:frame)
        
        tableimage.frame = CGRect(x: 0, y: 0, width: 100, height: 165)
        tableimage.layer.cornerRadius = 4
        tableimage.layer.masksToBounds = true
        
        self.addSubview(tableimage)
        //tableimage.layer.borderWidth = 0.2
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
