//
//  ViewController.swift
//  Demo
//
//  Created by Shoaib Akhtar on 15/10/2018.
//  Copyright © 2018 Shoaib Akhtar. All rights reserved.
//

import UIKit
import SBAGallery
import Kingfisher
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func openGallery(_ sender: Any) {
    
        let mixImageArray = ["https://placehold.it/300x300&text=image1","https://placehold.it/500x1500&text=Demo","1.jpg","2.jpg","3.jpg"]
        let galleryModel =  GalleryImageModel(imagesArray: mixImageArray,placeHolder: "placeholder.jpg", imageLoaderBlock: {(url, placeHolderImage, imageView) in
        
            // Try loading with your image cahced library
            imageView.kf.setImage(with: url)
            
        }) { (urlArray) in
            // Try pre loading for better performance
            let prefetcher = ImagePrefetcher(urls: urlArray, completionHandler: { (skippedResources, failedResources, completedResources) in
                
            })
            prefetcher.start()
        }
        
        let viewController = SBAGallery.gallery(galleryModel: galleryModel)
        self.present(viewController, animated: true, completion: nil)
    }

}

