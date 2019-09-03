//
//  RepositoriesListViewModel.swift
//  DdotAssignment
//
//  Created by Hussien Gamal Mohammed on 9/2/19.
//  Copyright © 2019 Ddot. All rights reserved.
//

import Foundation
class ListViewModel {
    var repositoriesArray: [RepositoryPreviewViewModel] = []
    private let loader = RepositoriesDataLoader()
    public var nextPageID = 1
    let recordsCount: Int = 15
    let paginationMargin = 3
    var reachedEnd: Bool = false

    func load(completionBlock: @escaping ([RepositoryPreviewViewModel]?, DataLoaderErrors?) -> ()) {
        loader.pageID = nextPageID
        loader.recordsPerPage = recordsCount
        loader.loadRepositories {[weak self] (repos, error) in
            guard let self = self else {
                return
            }
            if error == nil {
                self.nextPageID = self.nextPageID + 1
                print("nextPageID: \(self.nextPageID)")
                guard let reposResponse = repos else {
                    return
                }
                let result = reposResponse.map({self.getViewModel(from: $0)})
                if result.count == 0 {
                    //reached end
                    self.reachedEnd = true
                }
                else {
                    self.repositoriesArray.append(contentsOf: result)
                }
                completionBlock(result, nil)
            }
            else {
                completionBlock(nil, error)
            }
        }
    }

    func shouldFetchNext(currentIndex: Int) -> Bool {
        return (currentIndex == repositoriesArray.count - paginationMargin) && !reachedEnd
    }

    private func getViewModel(from model: Repository) -> RepositoryPreviewViewModel {
        return RepositoryPreviewViewModel(repo: model)
    }
}
