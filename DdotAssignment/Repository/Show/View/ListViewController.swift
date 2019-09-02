//
//  ViewController.swift
//  DdotAssignment
//
//  Created by Hussien Gamal Mohammed on 9/1/19.
//  Copyright © 2019 Ddot. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    let viewModel = ListViewModel()
    let cellHeight = 200
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadAndView()
    }

    func loadAndView() {
        viewModel.load { (repos, error) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                self.tableView.reloadData()
            }
        }
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositoriesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryPreviewCell", for: indexPath) as? RepositoryPreviewCell else {
            return UITableViewCell()
        }
        cell.config(viewModel: viewModel.repositoriesArray[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.shouldFetchNext(currentIndex: indexPath.row) {
            loadAndView()
        }
    }

}

