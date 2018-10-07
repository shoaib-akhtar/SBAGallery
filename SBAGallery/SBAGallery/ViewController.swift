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
        
        let galleryModel = GalleryImageModel(imagesArray:["1.jpg","2.jpg","3.jpg","1.jpg","2.jpg","3.jpg","1.jpg","2.jpg","3.jpg","1.jpg","2.jpg","3.jpg","1.jpg","2.jpg","3.jpg","1.jpg","2.jpg","3.jpg","1.jpg","2.jpg","3.jpg","1.jpg","2.jpg","3.jpg","1.jpg","2.jpg","3.jpg","1.jpg","2.jpg","3.jpg","1.jpg","2.jpg","3.jpg","1.jpg","2.jpg","3.jpg","1.jpg","2.jpg","3.jpg","1.jpg","2.jpg","3.jpg","1.jpg","2.jpg","3.jpg","1.jpg","2.jpg","3.jpg"]) { (url, placeHolder, imageView) in
            
        }
        
        let viewController = SBAGallery.gallery(galleryModel: galleryModel)
        
        self.present(viewController, animated: true, completion: nil)
    }
    
}

