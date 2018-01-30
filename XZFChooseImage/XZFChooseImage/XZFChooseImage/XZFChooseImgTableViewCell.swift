//
//  XZFChooseImgTableViewCell.swift
//  XZFChooseImage
//
//  Created by brks on 2018/1/23.
//  Copyright © 2018年 borrow. All rights reserved.
//

import UIKit

class XZFChooseImgTableViewCell: UITableViewCell {
    let imgView = UIImageView()
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    let rightLabel = UILabel()
    let lineView = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imgView.layer.borderWidth = 1
        imgView.layer.borderColor = UIColor.colorRGB(red: 200, green: 200, blue: 200).cgColor
        
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = UIColor.colorRGB(red: 150, green: 150, blue: 150)
        titleLabel.textAlignment = .left
        
        rightLabel.font = UIFont.systemFont(ofSize: 18)
        rightLabel.textColor = UIColor.colorRGB(red: 150, green: 150, blue: 150)
        rightLabel.text = ">"
        rightLabel.textAlignment = .right
        
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.textColor = UIColor.colorRGB(red: 150, green: 150, blue: 150)
        contentLabel.textAlignment = .right
        
        lineView.backgroundColor = UIColor.colorRGB(red: 240, green: 240, blue: 240)
        
        self.contentView.addSubview(imgView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(contentLabel)
        self.contentView.addSubview(rightLabel)
        self.contentView.addSubview(lineView)
        
        self.selectionStyle = .none
        
    }
    
    //设置cell
    func customCell(image: UIImage?, title: String, count: Int) {
        imgView.frame = CGRect(x: 15, y: (self.kXZF_Height - 50) / 2.0, width: 50, height: 50)
        titleLabel.frame = CGRect(x: imgView.kXZF_X + imgView.kXZF_Width + 8, y: (self.kXZF_Height - 20) / 2.0, width: 100, height: 20)
        rightLabel.frame = CGRect(x: self.kXZF_Width - 20 - 15, y: (self.kXZF_Height - 20) / 2.0, width: 20, height: 20)
        contentLabel.frame = CGRect(x: rightLabel.kXZF_X - 100 - 8, y: (self.kXZF_Height - 20) / 2.0, width: 100, height: 20)
        lineView.frame = CGRect(x: 15, y: self.kXZF_Height - 1, width: self.kXZF_Width - 15, height: 1)
        
        if image != nil {
            imgView.image = image!
        }
        
        titleLabel.text = title
        contentLabel.text = String.init(format: "%d张", count)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
