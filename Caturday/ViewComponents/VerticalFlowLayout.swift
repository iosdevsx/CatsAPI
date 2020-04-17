//
//  VerticalFlowLayout.swift
//  Caturday
//
//  Created by Юрий Логинов on 17.04.2020.
//  Copyright © 2020 Юрий Логинов. All rights reserved.
//

import UIKit

public class VerticalFlowLayout: UICollectionViewFlowLayout {
    public init(width: Double, height: Double, margin: CGFloat = 0.0) {
        super.init()
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        itemSize = CGSize(width: width, height: height)
        sectionInset = UIEdgeInsets(top: margin, left: margin,
                                    bottom: margin, right: margin)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
