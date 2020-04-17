//
//  CollectionCellContainer.swift
//  Caturday
//
//  Created by Юрий Логинов on 17.04.2020.
//  Copyright © 2020 Юрий Логинов. All rights reserved.
//

import UIKit

protocol ReusableView {
    func prepareForReuse()
}

class CollectionCellContainer<View: UIView & ReusableView>: UICollectionViewCell {

    lazy private(set) public var containedView: View = View(frame: .zero)

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        contentView.addSubview(containedView)
        containedView.edgesToSuperview()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        containedView.prepareForReuse()
    }
}

extension UICollectionView {
    func registerCell(class: UICollectionViewCell.Type) {
        register(`class`, forCellWithReuseIdentifier: String(describing: `class`))
    }

    func dequeue<RegisteredCell: UICollectionViewCell>(indexPath: IndexPath) -> RegisteredCell? {
        return dequeueReusableCell(withReuseIdentifier: String(describing: RegisteredCell.self),
                                   for: indexPath) as? RegisteredCell
    }
}
