//
//  TabBarController.swift
//  Podcast
//
//  Created by Zachary Auten on 2/16/16.
//  Copyright © 2016 Zach Auten. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    let myColor = UIColor(red: 50/255, green: 90/255, blue: 190/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tabBar.barTintColor = myColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}