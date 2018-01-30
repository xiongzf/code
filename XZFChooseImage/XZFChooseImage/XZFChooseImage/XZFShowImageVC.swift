//
//  XZFShowImageVC.swift
//  XZFChooseImage
//
//  Created by brks on 2018/1/23.
//  Copyright © 2018年 borrow. All rights reserved.
//

import UIKit
import Photos

protocol XZFShowImageDelegate: NSObjectProtocol {
    //MARK: 确定按钮点击事件代理
    func xzfShowImage(showImageVC: XZFShowImageVC, certainBtnClicked certainBtn: UIButton?)
}
class XZFShowImageVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, XZFShowBigImageCollectionViewDelegate, XZFShowImageCollectionViewDelegate {
    var showLittleImageCollection: UICollectionView?
    var showBigImageCollection: UICollectionView?
    
    let kXZFLittleReuseIdentifier = "XZFShowImageCollectionViewCell"
    let kXZFBigReuseIdentifier = "XZFShowBigImageCollectionViewCell"
    
    var phCollection: PHAssetCollection?
    
    var dataSource: [PHAsset] = []
    var chooseImgs: [UIImage] = []
    var choosedIndexPath: [IndexPath] = []
    var maxCount = 0
    
    weak var delegate: XZFShowImageDelegate?
    
    let infoLabel = UILabel()
}

//MARK: - 生命周期、私人定制
extension XZFShowImageVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择照片"
        customView()
        fetchAllImage()
    }
    
    //定制view
    func customView() {
        //showBigImageCollection
        let layout1 = UICollectionViewFlowLayout()
        layout1.itemSize = CGSize(width: kScreenWidth, height: kScreenHeight)
        layout1.minimumInteritemSpacing = 0
        layout1.minimumLineSpacing = 0
        layout1.scrollDirection = .horizontal
        
        showBigImageCollection = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), collectionViewLayout: layout1)
        showBigImageCollection?.isHidden = true
        showBigImageCollection?.register(UINib.init(nibName: "XZFShowBigImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kXZFBigReuseIdentifier)
        showBigImageCollection?.delegate = self
        showBigImageCollection?.dataSource = self
        showBigImageCollection?.isPagingEnabled = true
        
        //showLittleImageCollection
        let layout2 = UICollectionViewFlowLayout()
        layout2.itemSize = CGSize(width: 80, height: 80)
        layout2.minimumInteritemSpacing = 5
        layout2.minimumLineSpacing = 10
        layout2.scrollDirection = .vertical
        
        showLittleImageCollection = UICollectionView(frame: CGRect.init(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64 - 44), collectionViewLayout: layout2)
        showLittleImageCollection?.register(UINib.init(nibName: "XZFShowImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kXZFLittleReuseIdentifier)
        showLittleImageCollection?.delegate = self
        showLittleImageCollection?.dataSource = self
        
        //bottomView
        let bottomView = UIView(frame: CGRect(x: 0, y: kScreenHeight - 44, width: kScreenWidth, height: 44))
        bottomView.backgroundColor = .white
        
        let certainBtn = UIButton(type: .custom)
        certainBtn.frame = CGRect(x: 15, y: 0, width: 60, height: bottomView.kXZF_Height)
        certainBtn.setTitle("确定", for: .normal)
        certainBtn.setTitleColor(.blue, for: .normal)
        certainBtn.addTarget(self, action: #selector(certainBtnClicked(button:)), for: .touchUpInside)
        certainBtn.titleLabel?.textAlignment = .left
        
        infoLabel.frame = CGRect(x: kScreenWidth - 100 - 15, y: (bottomView.kXZF_Height - 20) / 2.0, width: 100, height: 20)
        infoLabel.textAlignment = .right
        infoLabel.font = UIFont.systemFont(ofSize: 15)
        infoLabel.textColor = UIColor.blue
        infoLabel.text = String.init(format: "0/%d", maxCount)
        
        bottomView.addSubview(certainBtn)
        bottomView.addSubview(infoLabel)
        
        self.view.backgroundColor = .white
        self.view.addSubview(showLittleImageCollection!)
        self.view.addSubview(bottomView)
        UIApplication.shared.keyWindow?.addSubview(showBigImageCollection!)
    }
    
    //获取相册的所有图片
    func fetchAllImage() {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor.init(key: "creationDate", ascending: true)]
        options.predicate = NSPredicate.init(format: "mediaType == %ld", PHAssetMediaType.image.rawValue)
        let fetchResult = PHAsset.fetchAssets(in: phCollection!, options: options)
        
        weak var weakSelf = self
        DispatchQueue.global().async {
            fetchResult.enumerateObjects { (asset, index, stop) in
                weakSelf?.dataSource.append(asset)
            }
            
            DispatchQueue.main.async {
                weakSelf?.showLittleImageCollection?.reloadData()
                weakSelf?.showBigImageCollection?.reloadData()
            }
        }
        
    }
    
    //确定按钮点击事件
    @objc func certainBtnClicked(button: UIButton) {
        self.navigationController?.popViewController(animated: true)
        if delegate != nil {
            delegate?.xzfShowImage(showImageVC: self, certainBtnClicked: button)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        showBigImageCollection?.removeFromSuperview()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension XZFShowImageVC {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let asset = dataSource[indexPath.row]
        
        if collectionView == showLittleImageCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kXZFLittleReuseIdentifier, for: indexPath) as! XZFShowImageCollectionViewCell
            cell.delegate = self
            cell.customCell(asset: asset, indexPath: indexPath)
            
            for indexP in choosedIndexPath {
                if indexPath.row == indexP.row {
                    cell.chooseBtn.isSelected = true
                    break
                }
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kXZFBigReuseIdentifier, for: indexPath) as! XZFShowBigImageCollectionViewCell
            cell.delegate = self
            cell.customCell(asset: asset, indexPath: indexPath)
            cell.label.text = String.init(format: "%d/%d张", choosedIndexPath.count, maxCount)
            
            for indexP in choosedIndexPath {
                if indexPath.row == indexP.row {
                    cell.chooseBtn.isSelected = true
                    break
                }
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == showLittleImageCollection {
            showBigImageCollection?.reloadData()
            showBigImageCollection?.contentOffset = CGPoint(x: kScreenWidth * CGFloat(indexPath.row), y: 0)
            showBigImageCollection?.isHidden = false
            self.view.bringSubview(toFront: showBigImageCollection!)
        }
    }
}

//MARK: - XZFShowBigImageCollectionViewDelegate
extension XZFShowImageVC {
    func showBigImageCollectionViewCell(cell: XZFShowBigImageCollectionViewCell, backBtnClicked backBtn: UIButton) {
        showBigImageCollection?.isHidden = true
        self.showLittleImageCollection?.reloadData()
        infoLabel.text = String.init(format: "%d/%d张", choosedIndexPath.count, maxCount)
    }
    
    func showBigImageCollectionViewCell(cell: XZFShowBigImageCollectionViewCell, chooseBtnClicked chooseBtn: UIButton) {
        if !chooseBtn.isSelected && choosedIndexPath.count == maxCount {
            showAlert(message: String.init(format: "最多可以选择%d张", maxCount), vc: self)
            return
        }
        
        chooseBtn.isSelected = !chooseBtn.isSelected
        
        if chooseBtn.isSelected {
            choosedIndexPath.append(cell.kXZFIndexPath!)
            chooseImgs.append(cell.kXZFImage!)
        } else {
            for (index, indexPath) in choosedIndexPath.enumerated() {
                if indexPath.row == cell.kXZFIndexPath?.row {
                    choosedIndexPath.remove(at: index)
                    chooseImgs.remove(at: index)
                    break
                }
            }
        }
        
        cell.label.text = String.init(format: "%d/%d张", choosedIndexPath.count, maxCount)
    }
    
    func showBigImageCollectionViewCell(cell: XZFShowBigImageCollectionViewCell, certainBtnClicked certainBtn: UIButton) {
        self.navigationController?.popViewController(animated: true)
        if delegate != nil {
            delegate?.xzfShowImage(showImageVC: self, certainBtnClicked: nil)
        }
    }
}

//MARK: - XZFShowImageCollectionViewDelegate
extension XZFShowImageVC {
    func showImageCollectionView(cell: XZFShowImageCollectionViewCell, chooseBtnClicked chooseBtn: UIButton) {
        if !chooseBtn.isSelected && choosedIndexPath.count == maxCount {
            showAlert(message: String.init(format: "最多可以选择%d张", maxCount), vc: self)
            return
        }
        
        chooseBtn.isSelected = !chooseBtn.isSelected
        if chooseBtn.isSelected {
            choosedIndexPath.append(cell.kXZFIndexPath!)
            chooseImgs.append(cell.kXZFImage!)
        } else {
            for (index, indexPath) in choosedIndexPath.enumerated() {
                if indexPath.row == cell.kXZFIndexPath?.row {
                    choosedIndexPath.remove(at: index)
                    chooseImgs.remove(at: index)
                    break
                }
            }
        }
        
        infoLabel.text = String.init(format: "%d/%d张", choosedIndexPath.count, maxCount)
    }
}
