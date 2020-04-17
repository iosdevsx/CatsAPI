//
//  CatView.swift
//  Caturday
//
//  Created by Юрий Логинов on 17.04.2020.
//  Copyright © 2020 Юрий Логинов. All rights reserved.
//

import UIKit

class CatView: UIView, ReusableView {
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.shadowOffset = CGSize(width: 2, height: 4)
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.5
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 16
        return view
    }()
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        containerView.addSubview(backgroundImageView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.edgesToSuperview(insets: .init(inset: 8))
        backgroundImageView.edgesToSuperview()
    }
    
    func prepareForReuse() {
        self.backgroundImageView.image = nil
    }

}
