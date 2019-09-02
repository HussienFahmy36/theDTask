//
//  RepositoriesDataLoader.swift
//  DdotAssignment
//
//  Created by Hussien Gamal Mohammed on 9/1/19.
//  Copyright © 2019 Ddot. All rights reserved.
//

import Foundation
import Disk

class RepositoriesDataLoader {

    var pageID = 1
    var recordsPerPage = 15
    var requestURLString: String {
        return "https://api.github.com/users/JakeWharton/repos?page=\(pageID)&per_page=\(recordsPerPage)"
    }
    var storageFileName: String {
        return "patch_\(pageID)_\(recordsPerPage).json"
    }

    func remoteLoadRepositories(completionBlock: @escaping ([Repository]?, DataLoaderErrors?) -> ()) {
        let manager = NetworkManager()
        manager.reachability = Reachability()
        guard let url = URL(string: requestURLString) else {return}
        manager.getRequestAsync(from: url) { [weak self] (data, error) in
            guard let `self` = self else {
                return
            }
            if error == nil {
                let dataParser = JsonParserCodable()
                guard let result = dataParser.parse(data: data, to: [Repository].self) else {
                    return
                }
                try! Disk.save(result, to: .caches, as: self.storageFileName)
                completionBlock(result, nil)
            } else {
                completionBlock(nil, error)
            }
        }
    }

    func localLoadRepositories(completionBlock: @escaping ([Repository]?, DataLoaderErrors?) -> ()) {
        do {
            let result = try Disk.retrieve(storageFileName, from: .caches, as: [Repository].self)
            completionBlock(result, nil)
        } catch {
            completionBlock(nil, .loadFromCacheFails)
        }
    }

    func loadRepositories(completionBlock: @escaping ([Repository]?, DataLoaderErrors?) -> ()) {
        localLoadRepositories { [weak self](repos, error) in
            if repos == nil && error == .loadFromCacheFails {
                guard let `self` = self else {
                    return
                }
                //not cached url request new one
                self.remoteLoadRepositories(completionBlock: completionBlock)
            }
            else {
                completionBlock(repos, error)
            }
        }
    }
}
