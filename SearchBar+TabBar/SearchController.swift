//
//  SearchController.swift
//  SearchBar+TabBar
//
//  Created by Gazolla on 22/04/2018.
//  Copyright © 2018 Gazolla. All rights reserved.
//

import UIKit

class SearchController: UIViewController {
    var matchingItems:[String] = [] {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    lazy var searchController:UISearchController = UISearchController(searchResultsController: nil)
 
    lazy var tableView: UITableView = { [unowned self] in
        let tv = UITableView(frame: CGRect.zero, style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "id")
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "First"
        view.addSubview(self.tableView)
        self.navigationItem.searchController = searchController
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.perform(#selector(showKeyboard), with: nil, afterDelay: 0.1)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.searchBar.resignFirstResponder()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let layout = self.view.safeAreaLayoutGuide
        tableView.topAnchor.constraint(equalTo: layout.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: layout.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: layout.rightAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: layout.leftAnchor).isActive = true
    }
    
    @objc func showKeyboard() {
        self.searchController.searchBar.becomeFirstResponder()
        self.searchController.searchBar.text = ""
    }
}

extension SearchController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
            return self.matchingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath)
        let item = matchingItems[indexPath.item]
        cell.textLabel?.text = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print((indexPath as NSIndexPath).row)
            let item = matchingItems[indexPath.item]
            print(item)
    }
}
