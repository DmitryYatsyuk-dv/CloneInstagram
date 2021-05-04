//
//  SearchController.swift
//  CloneInstagram
//
//  Created by Lucky on 10.04.2021.
//

import UIKit

private let reuseIdentifier = "UserCell"

class SearchController: UITableViewController {
    
    //MARK: - Properties
    
    private var users = [User]()
    private var filteredUsers = [User]()
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var inSearchModel: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureTableView()
        fetchUsers()
    }
    
    //MARK: - API
    
    func fetchUsers() {
        UserService.fetchUsers { users in
            //            print("DEBUG: Users in search controller: \(users)")
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Helpers
    
    func configureTableView() {
        view.backgroundColor = .white
        
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 64
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = false
        
    }
}

//MARK: - UITableViewDataSource

extension SearchController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchModel
            ? filteredUsers.count
            : users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        
        let user = inSearchModel ? filteredUsers[indexPath.row] : users[indexPath.row]
        cell.viewModel = UserCellViewModel(user: user)
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension SearchController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        print("DEBUG: User is \(users[indexPath.row].username)")
        
        let user = inSearchModel ? filteredUsers[indexPath.row] : users[indexPath.row]
        
        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
        
    }
}

//MARK: -  UISearchResultsUpdating

extension SearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        
        filteredUsers = users.filter({
            $0.username.contains(searchText) ||
                $0.fullname.lowercased().contains(searchText)
        })
//        print("DEBUG: Filtered Users \(filteredUsers)")
        self.tableView.reloadData()
    }
}
