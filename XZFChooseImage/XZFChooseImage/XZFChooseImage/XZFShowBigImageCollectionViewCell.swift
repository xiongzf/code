//
//  XZFShowBigImageCollectionViewCell.swift
//  XZFChooseImage
//
//  Created by brks on 2018/1/23.
//  Copyright © 2018年 borrow. All rights reserved.
//

import UIKit
import Photos

protocol XZFShowBigImageCollectionViewDelegate: NSObjectProtocol {
    //weak: 返回按钮点击事件代理
    func showBigImageCollectionViewCell(cell: XZFShowBigImageCollectionViewCell, backBtnClicked backBtn: UIButton)
    
    //weak: 选择按钮的点击事件代理
    func showBigImageCollectionViewCell(cell: XZFShowBigImageCollectionViewCell, chooseBtnClicked chooseBtn: UIButton)
    
    //weak: 确定按钮的点击事件代理
    func showBigImageCollectionViewCell(cell: XZFShowBigImageCollectionViewCell, certainBtnClicked certainBtn: UIButton)
    
}

class XZFShowBigImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var chooseBtn: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var certainBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var label: UILabel!
    
    var kXZFIndexPath: IndexPath?
    var kXZFImage: UIImage?
    
    weak var delegate: XZFShowBigImageCollectionViewDelegate?
    
    //weak: 返回按钮点击事件
    @IBAction func backBtnClicked(_ sender: UIButton) {
        if delegate != nil {
            delegate?.showBigImageCollectionViewCell(cell: self, backBtnClicked: sender)
        }
    }
    
    //weak: 选择按钮点击事件
    @IBAction func chooseBtnClicked(_ sender: UIButton) {
        if delegate != nil {
            delegate?.showBigImageCollectionViewCell(cell: self, chooseBtnClicked: sender)
        }
    }
    
    //weak: 确定按钮点击事件
    @IBAction func certainBtnClicked(_ sender: UIButton) {
        if delegate != nil {
            delegate?.showBigImageCollectionViewCell(cell: self, certainBtnClicked: sender)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    //weak: 定制cell
    func customCell(asset: PHAsset, indexPath: IndexPath) {
        chooseBtn.isSelected = false
        imgView.image = nil
        self.kXZFIndexPath = indexPath
        
        DispatchQueue.global().async {
            let requestOptions = PHImageRequestOptions()
            requestOptions.deliveryMode = .highQualityFormat
            requestOptions.isSynchronous = true
            requestOptions.isNetworkAccessAllowed = true
            //        requestOptions.resizeMode = .fast
            
            weak var weakSelf = self
            let manager = PHImageManager.default()
            manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: requestOptions, resultHandler: { (image, dic) in
                DispatchQueue.main.async {
                    if image != nil {
                        weakSelf?.imgView.image = image
                        weakSelf?.kXZFImage = image
                    }
                }
            })
        }
        
    }
    
    //weak: 获取显示的尺寸
    func getTargetSize() -> CGSize {
        let scale = UIScreen.main.scale
        let targetSize = CGSize(width: kScreenWidth * scale, height: kScreenHeight * scale)
//        let targetSize = UIScreen.main.bounds.size
        return targetSize
    }
}
