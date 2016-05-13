//
//  ImageViewController.swift
//  Canssini-iOS9
//
//  Created by luojie on 16/5/13.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    var imageURL: NSURL? { didSet { fetchImage() } }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.addSubview(imageView)
        }
    }
    
    let imageView = UIImageView()
    
    var image: UIImage? {
        get { return imageView.image }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView.contentSize = imageView.bounds.size
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageURL = DemoURL.Stanford
    }
    
    private func fetchImage() {
        print(#function)
        image = nil
        
        if let
            url = imageURL,
            data = NSData(contentsOfURL: url),
            image = UIImage(data: data) {
            self.image = image
            print("Image did get")

        }
    }
    
}

