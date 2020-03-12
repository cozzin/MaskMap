//
//  StoreViewController.swift
//  MaskMap
//
//  Created by SeongHo.Hong on 2020/03/12.
//  Copyright © 2020 Cozzin. All rights reserved.
//

import UIKit
import GoogleMobileAds

final class StoreViewController: UIViewController {
    
    var scrollView: UIScrollView {
        tableView
    }
        
    private let store: Entity.Search.ViewModel.Store
    
    private lazy var viewModel: Entity.Store.ViewModel = {
        presenter.valueConvert(store)
    }()
    
    private lazy var presenter: StorePresenter = StorePresenter()
    
    private lazy var router: StoreRouter = StoreRouter(self)
    
    private lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.register(StoreTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var bannerView: GADBannerView = {
        let bannerView: GADBannerView = GADBannerView(adSize: kGADAdSizeBanner)
        return bannerView
    }()
    
    init(_ store: Entity.Search.ViewModel.Store) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20.0)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        bannerView.adUnitID = Entity.AD.unitID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
}

extension StoreViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(for: indexPath) as StoreTableViewCell
        let row = viewModel.rows[indexPath.row]
        
        cell.configure(row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        bannerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        kGADAdSizeBanner.size.height
    }
    
}

extension StoreViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = viewModel.rows[indexPath.row]
        
        switch row.rowType {
        case .normal:
            break
        case .copy(let content):
            router.presentActivity(content)
        case .navigaiton(let navigationType):
            router.routeNavigation(navigationType, store: row.store)
        }
    }
    
}
