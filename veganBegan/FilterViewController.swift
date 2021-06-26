//
//  FilterViewController.swift
//  veganBegan
//
//  Created by RelMac User Exercise3 on 2021/06/13.
//  Copyright © 2021 Release. All rights reserved.
//

import Foundation
import UIKit

class FilterViewController: UIViewController {
    
    @IBOutlet var western: UIButton!
    
    var buttonTag = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func buttonAction(_ sender: UIButton) {
        buttonTag = sender.titleLabel!.text!
        print(buttonTag)
    }
    @IBAction func testHandler(_ sender: UIButton) {
        print("test")
    }
    @IBAction func testHandler2() {
        print("Hello world")
    }
}
