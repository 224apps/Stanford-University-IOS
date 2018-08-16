//
//  ImageViewController.swift
//  Cassini
//
//  Created by Abdoulaye Diallo on 8/15/18.
//  Copyright © 2018 Abdoulaye Diallo. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.addSubview(imageView)
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale =  1.0
            scrollView.delegate = self
        }
    }
    var imageURL: URL?
    {
        didSet{
            imageView.image = image
            if view.window != nil{
                fetchImage()
            }
        }
    }
    private var image : UIImage? {
        get
        {
            return imageView.image
        }
        set
        {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView.contentSize = imageView.frame.size
        }
    }
    
    private func fetchImage()
    {
        if let url = imageURL {
            let urlContents = try?  Data(contentsOf: url)
            if let imageData =  urlContents {
                imageView.image = UIImage(data: imageData)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if imageView.image == nil {
            fetchImage()
        }
    }
    
    
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageView.image == nil {
            imageURL = DemoURLs.stanford
        }
    }
}

extension  ImageViewController: UIScrollViewDelegate
{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
         return imageView
    }
    
    
    
}
