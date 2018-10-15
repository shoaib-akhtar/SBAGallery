//
//  DequeueInitializable.swift
//  MyStuff
//
//  Created by MHS on 21/05/2018.
//  Copyright © 2018 QuantumCPH. All rights reserved.
//

import Foundation
import UIKit

protocol DequeueInitializable {
    static var reuseableIdentifier: String { get }
}

extension DequeueInitializable where Self: UITableViewCell {
    
    static var reuseableIdentifier: String {
        return String(describing: Self.self)
    }
    
    static func dequeue(tableView: UITableView) -> Self {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseableIdentifier) else {
            return UITableViewCell() as! Self
        }
        return cell as! Self
    }
}

extension DequeueInitializable where Self: UICollectionViewCell {
    
    static var reuseableIdentifier: String {
        return String(describing: Self.self)
    }
    
    static func dequeue(collectionView: UICollectionView,indexPath: IndexPath) -> Self {
        
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseableIdentifier, for: indexPath)
        
        return cell as! Self
    }
}
