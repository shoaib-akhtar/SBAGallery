//
//  GalleryViewModel.swift
//  MyStuff
//
//  Created by Zeeshan Anjum on 04/08/2018.
//  Copyright © 2018 QuantumCPH. All rights reserved.
//

import Foundation
import UIKit
protocol GalleryViewModel {
    func numberOfImages() -> Int
    func getStartingIndex() -> Int
    func viewModel(for indexPath: IndexPath) -> GalleryImageCollectionViewCellViewModel?
    func getBackgorundColor() -> UIColor
}

class GalleryViewModelImp: GalleryViewModel {

    var imagesArray = [Any]()
    var startingIndex: Int
    private var galleryViewModelsArray: Array <GalleryImageCollectionViewCellViewModel> = []
    var bgColor : UIColor
    let placeHolder: String?
    let imageLoaderBlock: imageLoaderClosue?

    init(imagesArray: [Any], startingIndex: Int,bgColor: UIColor,placeHolder: String?,imageLoaderBlock: imageLoaderClosue?) {
        self.imagesArray = imagesArray
        self.startingIndex = startingIndex
        self.bgColor = bgColor
        self.imageLoaderBlock = imageLoaderBlock
        self.placeHolder = placeHolder
        generateViewModels()
    }
    
    func generateViewModels() {
        for image in imagesArray {
            let vm = GalleryImageCollectionViewCellViewModelImp(imageName: image,placeHolder: self.placeHolder ,imageLoaderBlock: self.imageLoaderBlock)
            galleryViewModelsArray.append(vm)
        }
    }
    
    func numberOfImages() -> Int {
        return imagesArray.count
    }
    
    func viewModel(for indexPath: IndexPath) -> GalleryImageCollectionViewCellViewModel? {
        return galleryViewModelsArray[indexPath.row]
    }
    
    func getStartingIndex() -> Int {
        return self.startingIndex
    }
    func getBackgorundColor() -> UIColor {
        return self.bgColor
    }
}
