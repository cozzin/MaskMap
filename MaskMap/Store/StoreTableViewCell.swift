//
//  StoreTableViewCell.swift
//  MaskMap
//
//  Created by SeongHo.Hong on 2020/03/12.
//  Copyright © 2020 Cozzin. All rights reserved.
//

import UIKit

final class StoreTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        textLabel?.text = nil
        detailTextLabel?.text = nil
        selectionStyle = .none
        accessoryType = .none
    }
    
    func configure(_ viewModel: Entity.Store.ViewModel.Row) {
        textLabel?.text = viewModel.title
        detailTextLabel?.text = viewModel.content
        switch viewModel.rowType {
        case .normal:
            selectionStyle = .none
            accessoryType = .none
        case .copy,
             .navigaiton:
            selectionStyle = .default
            accessoryType = .disclosureIndicator
        }
    }
    
}
