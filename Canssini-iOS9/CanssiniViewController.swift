//
//  CanssiniViewController.swift
//  Canssini-iOS9
//
//  Created by luojie on 16/5/16.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit

class CanssiniViewController: UIViewController, UISplitViewControllerDelegate {
    
    @IBAction func showImage(sender: UIButton) {
        if let ivc = splitViewController?.viewControllers.last?.contentViewController as? ImageViewController {
            let title = sender.currentTitle!
            ivc.imageURL = imageURLs[title]
            ivc.title = title
        } else {
            performSegueWithIdentifier("ShowImage", sender: sender)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitViewController?.delegate = self
    }
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
        print(#function)
        if primaryViewController.contentViewController == self {
            if let ivc = secondaryViewController.contentViewController as? ImageViewController
                where ivc.imageURL == nil {
                return true
            }
        }
        return false
    }
    
    private var imageURLs = [
        "Earth": DemoURL.NASA.Earth!,
        "Canssini": DemoURL.NASA.Cassini!,
        "Saturn": DemoURL.NASA.Saturn!
    ]

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowImage"{
            let ivc = segue.destinationViewController.contentViewController as! ImageViewController
            let title = (sender as! UIButton).currentTitle!
            ivc.imageURL = imageURLs[title]
            ivc.title = title
        }
    }
    
}

extension UIViewController {
    var contentViewController: UIViewController {
        if let nvc = self as? UINavigationController {
            return nvc.visibleViewController ?? self
        } else {
            return self
        }
    }
}