//
//  TabBarController.swift
//  WeGoLoco iOS
//
//  Created by Dirk Hornung on 13/10/17.
//  Copyright © 2017 Dirk Hornung. All rights reserved.
//

import UIKit
import AWSS3
import PromiseKit

// Hides Manager Tab-item if user is not retailer
class TabBarController: UITabBarController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // remove Manager Tab if user is not a retailer
        firstly {
            User.isRetailer()
        }.then { isRetailer -> Void in
            if !isRetailer {
                self.viewControllers?.remove(at: (self.viewControllers?.count)!-1)
            } else {
                if self.viewControllers!.count < 3 {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let managerViewController = storyboard.instantiateViewController(withIdentifier: "managerViewController")
                    self.viewControllers?.insert(managerViewController, at: 0)
                }
            }
        }.catch { error in
            print(error)
        }
    }
}
