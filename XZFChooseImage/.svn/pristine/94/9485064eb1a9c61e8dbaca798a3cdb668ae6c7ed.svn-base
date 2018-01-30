//
//  XZFShowImageCollectionViewCell.swift
//  XZFChooseImage
//
//  Created by brks on 2018/1/23.
//  Copyright © 2018年 borrow. All rights reserved.
//

import UIKit
import Photos

protocol XZFShowImageCollectionViewDelegate: NSObjectProtocol {
    //weak: 选中按钮点击事件代理
    func showImageCollectionView(cell: XZFShowImageCollectionViewCell, chooseBtnClicked chooseBtn: UIButton)
}

class XZFShowImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var chooseBtn: UIButton!
    
    weak var delegate: XZFShowImageCollectionViewDelegate?
    var kXZFImage: UIImage?
    var kXZFIndexPath: IndexPath?
    
    @IBAction func chooseBtnClicked(_ sender: UIButton) {
        if delegate != nil {
            delegate?.showImageCollectionView(cell: self, chooseBtnClicked: sender)
        }
    }
    
    //weak: 定制cell
    func customCell(asset: PHAsset, indexPath: IndexPath) {
        chooseBtn.isSelected = false
        kXZFIndexPath = indexPath
        
        DispatchQueue.global().async {
            let requestOptions = PHImageRequestOptions()
            requestOptions.resizeMode = .fast
            
            weak var weakSelf = self
            let manager = PHImageManager.default()
            manager.requestImage(for: asset, targetSize: self.getTargetSize(), contentMode: .aspectFit, options: requestOptions, resultHandler: { (image, dic) in
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
