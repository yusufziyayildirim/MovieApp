//
//  UIHelper.swift
//  MovieApp
//
//  Created by Yusuf Ziya YILDIRIM on 8.05.2023.
//

import UIKit

enum UIHelper {
    static func createHomeFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: .deviceWidth, height: .deviceWidth * 1.5)
        layout.minimumLineSpacing = 40
        
        return layout
    }
}
