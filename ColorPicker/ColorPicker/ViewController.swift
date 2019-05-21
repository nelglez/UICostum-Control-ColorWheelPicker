//
//  ViewController.swift
//  ColorPicker
//
//  Created by Nelson Gonzalez on 5/21/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func changeColor(_ sender: ColorWheel) {
        view.backgroundColor = sender.color
    }
    
}

