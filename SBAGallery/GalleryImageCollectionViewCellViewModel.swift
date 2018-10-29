//
//  GalleryImageCollectionViewCellViewModel.swift
//  MyStuff
//
//  Created by Zeeshan Anjum on 04/08/2018.
//  Copyright © 2018 QuantumCPH. All rights reserved.
//

import Foundation
import UIKit

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
    let imageLoaderBlock: imageLoaderClosure?
    let imagePreloadBlock: imagePreloadClosure?

    init(imageName: Any,placeHolder: String?,imageLoaderBlock: imageLoaderClosure?,imagePreloadBlock: imagePreloadClosure?) {
        self.galleryImage = imageName
        self.placeHolder = placeHolder
        self.imageLoaderBlock = imageLoaderBlock
        self.imagePreloadBlock = imagePreloadBlock
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
                if let _ = UIImage(named: image){
                    //
                }else if let imageURL = image.url(){
                    if let block = self.imagePreloadBlock{
                        block([imageURL])
                    }
                }
            } else if let image =  self.galleryImage as? URL {
                if let block = self.imagePreloadBlock{
                    block([image])
                }
            }
        }
    }
}
