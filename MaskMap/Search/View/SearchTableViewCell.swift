//
//  SearchTableViewCell.swift
//  MaskMap
//
//  Created by SeongHo.Hong on 2020/03/11.
//  Copyright © 2020 Cozzin. All rights reserved.
//

import UIKit

final class SearchTableViewCell: UITableViewCell {
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView?.image = nil
        textLabel?.text = nil
        detailTextLabel?.text = nil
    }
    
    // MARK: - Public Method
    
    func configure(_ viewModel: Entity.Search.StoresByAddress.ViewModel.Store?) {
        guard let viewModel = viewModel else {
            return
        }
        
        imageView?.clipsToBounds = true
        imageView?.layer.cornerRadius = 15
        imageView?.image = UIImage(color: convertToColor(viewModel), size: CGSize(width: 15, height: 15))
        textLabel?.text = viewModel.name
        detailTextLabel?.text = viewModel.address
    }
    
    /// 재고 상태[100개 이상(녹색): 'plenty' / 30개 이상 100개미만(노랑색): 'some' / 2개 이상 30개 미만(빨강색): 'few' / 1개 이하(회색): 'empty']
    private func convertToColor(_ viewModel: Entity.Search.StoresByAddress.ViewModel.Store) -> UIColor {
        switch viewModel.remainStatus {
        case .plenty:
            return .green
        case .some:
            return .yellow
        case .few:
            return .red
        case .empty:
            return .gray
        case .unknown:
            return .white
        }
    }
    
}
