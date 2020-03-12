//
//  InfoView.swift
//  MaskMap
//
//  Created by SeongHo.Hong on 2020/03/11.
//  Copyright © 2020 Cozzin. All rights reserved.
//

import UIKit

final class InfoView: UIView {
    
    private lazy var guides: [Entity.Store.RemainStatus] = [.plenty, .some, .few]
    
    private lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .clear
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .clear
        tableView.backgroundColor = .clear
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension InfoView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guides.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: .value1, reuseIdentifier: "reuseIdentifier")
        let guide = guides[indexPath.row]
        cell.selectionStyle = .none
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 13.0)
        cell.textLabel?.text = guide.description
        cell.imageView?.clipsToBounds = true
        cell.imageView?.layer.cornerRadius = 7.5
        cell.imageView?.image = UIImage(color: guide.tintColor, size: CGSize(width: 7.5, height: 7.5))
        cell.backgroundColor = .clear
        return cell
    }
    
}

extension InfoView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        30.0
    }

}
