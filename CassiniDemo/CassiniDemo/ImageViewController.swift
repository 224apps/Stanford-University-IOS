//
//  ImageViewController.swift
//  CassiniDemo
//
//  Created by Abdoulaye Diallo on 6/21/17.
//  Copyright © 2017 Diaryconnect. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    var imageURL: URL? {
        didSet{
            image = nil
            if view.window != nil {
            fetchImage()
                
            }
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView! {
        didSet{
            
        }
    }
    
    func fetchImage(){
        if let url = imageURL {
            spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async{ [weak self] in
                let urlComponents =  try?  Data(contentsOf: url )
                if let  imageData = urlComponents , url == self?.imageURL {
                    DispatchQueue.main.async {
                        self?.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(imageView)
    }
    
    private var imageView = UIImageView()
    private var image: UIImage? {
        get{
            return  imageView.image
        }
        set{
            imageView.image = newValue
            imageView.sizeToFit()
             spinner.stopAnimating()
        }
    }
    
    
    
    
}
