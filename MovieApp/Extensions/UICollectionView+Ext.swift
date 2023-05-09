//
//  UICollectionView+Ext.swift
//  MovieApp
//
//  Created by Yusuf Ziya YILDIRIM on 9.05.2023.
//

import UIKit

extension UICollectionView {
    func reloadOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
