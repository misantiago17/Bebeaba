//
//  TabBarVC.swift
//  Bebeaba
//
//  Created by Alline Pedreira on 13/02/17.
//  Copyright © 2017 Michelle Beadle. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // color of item
        self.tabBar.tintColor = UIColor(red: 255/255, green: 176/255, blue: 215/255, alpha: 1.0)
        
        // color of unselected item
        self.tabBar.unselectedItemTintColor = UIColor(red: 255/255, green: 176/255, blue: 215/255, alpha: 1.0)
        
        // color of background
        self.tabBar.barTintColor = UIColor.white
        
        // disable translucent
        self.tabBar.isTranslucent = false
        
        removeTabbarItemsText()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func removeTabbarItemsText() {
        if let items = tabBar.items {
            for item in items {
                item.title = ""
                //item.imageInsets = UIEdgeInsets(top: 14, left: 8, bottom: 2, right: 8)
            }
        }
    }
    


}
