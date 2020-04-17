//
//  ViewController.swift
//  Caturday
//
//  Created by Юрий Логинов on 17.04.2020.
//  Copyright © 2020 Юрий Логинов. All rights reserved.
//

import UIKit

class CatsController: UICollectionViewController {
    typealias CatCell = CollectionCellContainer<CatView>
    private var viewModel: ICatsViewModel
    
    private var previewLayout: VerticalFlowLayout
    
    init(viewModel: ICatsViewModel) {
        self.viewModel = viewModel
        
        let numberOfColumns: CGFloat = 2
        let previewLayoutWidth = (UIScreen.main.bounds.width - numberOfColumns - 1) / numberOfColumns
        previewLayout = VerticalFlowLayout(width: Double(previewLayoutWidth), height: Double(previewLayoutWidth))
        
        super.init(collectionViewLayout: previewLayout)
        setupBindables()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.registerCell(class: CatCell.self)
        collectionView.showsVerticalScrollIndicator = false
        
        viewModel.fetchRandomCat()
    }
    
    private func setupBindables() {
        viewModel.reloadAction = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension CatsController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.catsCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: CatCell = collectionView.dequeue(indexPath: indexPath) else {
            return UICollectionViewCell()
        }
        
        if indexPath.row == viewModel.catsCount - 1 {
            viewModel.fetchRandomCat()
        }
        
        let cat = viewModel.cat(at: indexPath.row)
        
        if let url = URL(string: cat.url) {
            if let cachedImage = ImageCacher.shared.getImage(for: url) {
                cell.containedView.backgroundImageView.image = cachedImage
            } else {
                cell.containedView.backgroundImageView.downloaded(from: url)
            }
        }
        
        return cell
    }
    
    
}
