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

    func load(pageID: Int = 1, recordsCount: Int = 15, completionBlock: @escaping ([RepositoryPreviewViewModel]?, DataLoaderErrors?) -> ()) {
        loader.pageID = pageID
        loader.recordsPerPage = recordsCount
        loader.loadRepositories {[weak self] (repos, error) in
            guard let self = self else {
                return
            }
            if error == nil {
                self.repositoriesArray = repos?.map({self.getViewModel(from: $0)}) ?? []
                completionBlock(self.repositoriesArray, nil)
            }
            else {
                completionBlock(nil, error)
            }
        }
    }

    private func getViewModel(from model: Repository) -> RepositoryPreviewViewModel {
        return RepositoryPreviewViewModel(repo: model)
    }
}
