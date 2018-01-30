//
//  XZFExtension.swift
//  XZFChooseImage
//
//  Created by brks on 2018/1/22.
//  Copyright © 2018年 borrow. All rights reserved.
//

import UIKit
import Foundation

/// 屏幕大小
let kScreenBounds = UIScreen.main.bounds

/// 屏幕宽度
let kScreenWidth: CGFloat = UIScreen.main.bounds.width

/// 屏幕高度
let kScreenHeight: CGFloat = UIScreen.main.bounds.height

let kXZFTableViewCell_Image = UIImage(named: "place_icon")
let kXZFTableViewCell_ImageSize = CGSize(width: 500, height: 500)

//MARK: - UIColor
extension UIColor {
    class func colorRGBA(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    
    class func colorRGB(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return colorRGBA(red: red, green: green, blue: blue, alpha: 1)
    }
}

//MARK: - 为UIView添加扩展
extension UIView {
    //MARK: x坐标
    var kXZF_X: CGFloat {
        set {
            var kFrame = self.frame
            kFrame.origin.x = kXZF_X
            self.frame = kFrame
        }
        
        get {
            return self.frame.origin.x
        }
    }
    
    //MARK: y坐标
    var kXZF_Y: CGFloat {
        set {
            var kFrame = self.frame
            kFrame.origin.y = kXZF_Y
            self.frame = kFrame
        }
        
        get {
            return self.frame.origin.y
        }
    }
    
    //MARK: width
    var kXZF_Width: CGFloat {
        set {
            var kFrame = self.frame
            kFrame.size.width = kXZF_Width
            self.frame = kFrame
        }
        
        get {
            return self.frame.size.width
        }
    }
    
    //MARK: height
    var kXZF_Height: CGFloat {
        set {
            var kFrame = self.frame
            kFrame.size.height = kXZF_Height
            self.frame = kFrame
        }
        
        get {
            return self.frame.size.height
        }
    }
}

//MARK: - 给String添加扩展
extension String {
    /// 相册英文名称对应的中文
    ///
    /// - Returns: String
    func chinese() -> String {
        var name: String = ""
        
        switch self {
        case "Slo-mo":
            name = "慢动作"
        case "Recently Added":
            name = "最近添加"
        case "Favorites":
            name = "个人收藏"
        case "Recently Deleted":
            name = "最近删除"
        case "Videos":
            name = "视频"
        case "All Photos":
            name = "所有照片"
        case "Selfies":
            name = "自拍"
        case "Screenshots":
            name = "屏幕快照"
        case "Camera Roll":
            name = "相机胶卷"
        case "Panoramas":
            name = "全景照片"
        case "Hidden":
            name = "已隐藏"
        case "Time-lapse":
            name = "延时拍摄"
        case "Bursts":
            name = "连拍快照"
        case "Depth Effect":
            name = "景深效果"
        default:
            name = self
        }
        return name
    }
}

//MARK: - 为NSObject添加扩展
extension NSObject {
    //显示弹框提示
    func showAlert(message: String, vc: UIViewController) {
        let alertVC = UIAlertController(title: "温馨提示", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertVC.addAction(cancelAction)
        vc.present(alertVC, animated: true, completion: nil)
    }
}












