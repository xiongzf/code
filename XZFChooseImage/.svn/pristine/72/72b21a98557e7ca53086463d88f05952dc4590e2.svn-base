//
//  ViewController.swift
//  XZFChooseImage
//
//  Created by brks on 2018/1/22.
//  Copyright © 2018年 borrow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func clicked(_ sender: Any) {
        self.present(XZFChooseImagesVC.init(maxCount: 20, completeBlock: {(array) in
            print(array)
        }), animated: true, completion: nil)
    }
    
}

