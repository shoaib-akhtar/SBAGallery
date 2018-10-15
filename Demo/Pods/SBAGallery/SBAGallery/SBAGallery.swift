//
//  GalleryCoordinator.swift
//  MyStuff
//
//  Created by Zeeshan Anjum on 04/08/2018.
//  Copyright © 2018 QuantumCPH. All rights reserved.
//

import Foundation
import UIKit


public struct GalleryImageModel {
    let imagesArray : [Any]
    let imagePlaceHolder : String?
    let startingIndex : Int
    let bgColor : UIColor
    let imageLoaderBlock: imageLoaderClosue?
    
    public init(imagesArray: [Any],startingIndex : Int = 0,bgColor: UIColor = UIColor.black,placeHolder: String?=nil,imageLoaderBlock: imageLoaderClosue?)
    {
        self.imagesArray = imagesArray
        self.startingIndex = startingIndex
        self.bgColor = bgColor
        self.imagePlaceHolder = placeHolder
        self.imageLoaderBlock = imageLoaderBlock
    }
    
}

public class SBAGallery {
    public static func gallery(with galleryModel: GalleryImageModel) -> UIViewController{
        let storyBoard = UIStoryboard.init(name: "SBAGallery", bundle: nil)
        let vc : GalleryViewController = storyBoard.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
        vc.viewModel =  GalleryViewModelImp(imagesArray: galleryModel.imagesArray, startingIndex: galleryModel.startingIndex, bgColor: galleryModel.bgColor,placeHolder: galleryModel.imagePlaceHolder ,imageLoaderBlock: galleryModel.imageLoaderBlock)
        return vc
    }
}
extension String{
    func url() -> URL? {
        return URL(string: self)
    }
}
