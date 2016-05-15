//
//  ImageViewController.swift
//  Canssini-iOS9
//
//  Created by luojie on 16/5/13.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    var imageURL: NSURL? { didSet { fetchImage() } }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.addSubview(imageView)
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1
            scrollView.contentSize = imageView.bounds.size
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    let imageView = UIImageView()
    
    var image: UIImage? {
        get { return imageView.image }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.bounds.size
        }
    }
    
    private func fetchImage() {
        print(#function)
        image = nil
        spinner?.startAnimating()
        Queue.UserInitiated.execute { 
            if let
                url = self.imageURL,
                data = NSData(contentsOfURL: url) {
                Queue.Main.execute {
                    self.spinner.stopAnimating()
                    if url == self.imageURL {
                        self.image = UIImage(data: data)
                        print("Image did get")
                    }
                }
            } else {
                Queue.Main.execute { self.spinner.stopAnimating() }
            }
        }
        
    }
    
}

