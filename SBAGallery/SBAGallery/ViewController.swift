//
//  ViewController.swift
//  SBAGallery
//
//  Created by Shoaib Akhtar on 01/10/2018.
//  Copyright © 2018 Shoaib Akhtar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func openGallery(_ sender: Any) {
        
        var imageArray : [String] = []
        
        for i in 1...3{
            imageArray.append("\(i).jpg")
        }
        
        let galleryModel = GalleryImageModel(imagesArray:imageArray) { (url, placeHolder, imageView) in
            
        }
        
        let viewController = SBAGallery.gallery(galleryModel: galleryModel)
        
        self.present(viewController, animated: true, completion: nil)
    }
    
}

