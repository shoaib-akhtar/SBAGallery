//
//  GalleryImageCollectionViewCellViewModel.swift
//  MyStuff
//
//  Created by Zeeshan Anjum on 04/08/2018.
//  Copyright © 2018 QuantumCPH. All rights reserved.
//

import Foundation
import UIKit

typealias imageLoaderClosue = (_ url: URL,_ placeHolder: String?,_ view:UIImageView) -> Void

protocol GalleryImageCollectionViewCellViewModel {
    func image() -> Any
    func getImagePlaceHolder() -> String?
    func isZoomEnable() -> Bool
    func loadImage(url: URL,placeHolder: String?,in view:UIImageView)
    func prefetch()
}

class GalleryImageCollectionViewCellViewModelImp: GalleryImageCollectionViewCellViewModel {

    var galleryImage: Any
    let placeHolder : String?
    let imageLoaderBlock: imageLoaderClosue?

    init(imageName: Any,placeHolder: String?,imageLoaderBlock: imageLoaderClosue?) {
        self.galleryImage = imageName
        self.placeHolder = placeHolder
        self.imageLoaderBlock = imageLoaderBlock
    }
    
    func image() -> Any {
        return self.galleryImage
    }
    
    func getImagePlaceHolder() -> String? {
        return self.placeHolder
    }

    func isZoomEnable() -> Bool {
        return true
    }
    
    
    func loadImage(url: URL, placeHolder: String?, in view: UIImageView) {
        if let block = self.imageLoaderBlock{
            block(url,placeHolder,view)
        }
    }
    func prefetch() {
        DispatchQueue.global().async {
            if let image = self.galleryImage as? String{
                // UIImage will be cached and UI wont stuck
                _ = UIImage(named: image)
            }
        }
    }
}
