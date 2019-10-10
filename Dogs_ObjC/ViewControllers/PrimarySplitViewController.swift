//
//  PrimarySplitViewController.swift
//  Dogs_ObjC
//
//  Created by Landon Epps on 10/10/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit

class PrimarySplitViewController: UISplitViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.preferredDisplayMode = .allVisible
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
