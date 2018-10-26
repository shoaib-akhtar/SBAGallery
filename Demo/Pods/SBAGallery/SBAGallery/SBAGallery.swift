//
//  GalleryCoordinator.swift
//  MyStuff
//
//  Created by Zeeshan Anjum on 04/08/2018.
//  Copyright © 2018 QuantumCPH. All rights reserved.
//

import Foundation
import UIKit

public typealias imageLoaderClosure = (_ url: URL,_ placeHolder: String?,_ view:UIImageView) -> Void
public typealias imagePreloadClosure = (_ url: [URL]) -> Void

public struct GalleryImageModel {
    let imagesArray : [Any]
    let imagePlaceHolder : String?
    let startingIndex : Int
    let bgColor : UIColor
    let imageLoaderBlock: imageLoaderClosure?
    let imagePreloadBlock: imagePreloadClosure?
    
    public init(imagesArray: [Any],startingIndex : Int = 0,bgColor: UIColor = UIColor.black,placeHolder: String?=nil,imageLoaderBlock: imageLoaderClosure?,imagePreloadBlock: imagePreloadClosure?)
    {
        self.imagesArray = imagesArray
        self.startingIndex = startingIndex
        self.bgColor = bgColor
        self.imagePlaceHolder = placeHolder
        self.imageLoaderBlock = imageLoaderBlock
        self.imagePreloadBlock = imagePreloadBlock
    }
    
}

public class SBAGallery {
    public static func gallery(galleryModel: GalleryImageModel) -> UIViewController{
        let storyBoard = UIStoryboard.init(name: "SBAGallery", bundle: Bundle.init(for: self))
        let vc : GalleryViewController = storyBoard.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
        vc.viewModel =  GalleryViewModelImp(imagesArray: galleryModel.imagesArray, startingIndex: galleryModel.startingIndex, bgColor: galleryModel.bgColor,placeHolder: galleryModel.imagePlaceHolder ,imageLoaderBlock: galleryModel.imageLoaderBlock,imagePreloaderBlock: galleryModel.imagePreloadBlock)
        return vc
    }
}
extension String{
    func url() -> URL? {
        return URL(string: self)
    }
}
