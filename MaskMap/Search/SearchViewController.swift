//
//  SearchViewController.swift
//  MaskMap
//
//  Created by SeongHo.Hong on 2020/03/11.
//  Copyright © 2020 Cozzin. All rights reserved.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
        
    var scrollView: UIScrollView {
        tableView
    }
    
    private var viewModel: Entity.Search.ViewModel?
    
    private var textDidBeginHandler: VoidHandler?
    private var storeTapHandler: SenderToVoidHandler<(Entity.Search.ViewModel, Entity.Search.ViewModel.Store)>?
    
    private lazy var interactor: SearchInteractor = {
        let presenter = SearchPresenter(self)
        let interactor = SearchInteractor(presenter: presenter)
        return interactor
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar: UISearchBar = UISearchBar()
        searchBar.placeholder = "주소를 입력해주세요"
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.keyboardDismissMode = .onDrag
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemBackground
        return tableView
    }()
        
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SearchTableViewCell.self)
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15.0)
            $0.leading.trailing.equalToSuperview()
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        
        return searchBar.resignFirstResponder()
    }
    
    func textDidBegin(_ textDidBeginHandler: @escaping VoidHandler) {
        self.textDidBeginHandler = textDidBeginHandler
    }
    
    func didTapStore(_ storeTapHandler: @escaping SenderToVoidHandler<(Entity.Search.ViewModel, Entity.Search.ViewModel.Store)>) {
        self.storeTapHandler = storeTapHandler
    }
    
    func updateUI(_ viewModel: Entity.Search.ViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
    
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        textDidBeginHandler?()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        interactor.searchStores(address: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            interactor.searchStores(address: text)
        }
    }
    
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.stores.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(for: indexPath) as SearchTableViewCell
        
        cell.configure(viewModel?.stores[indexPath.row])
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let viewModel = viewModel {
            storeTapHandler?((viewModel, viewModel.stores[indexPath.row]))
            searchBar.resignFirstResponder()
        }
    }

}
