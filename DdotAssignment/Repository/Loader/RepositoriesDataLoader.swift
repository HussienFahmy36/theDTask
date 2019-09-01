//
//  RepositoriesDataLoader.swift
//  DdotAssignment
//
//  Created by Hussien Gamal Mohammed on 9/1/19.
//  Copyright © 2019 Ddot. All rights reserved.
//

import Foundation
import Disk

struct RepositoriesDataLoader {

    var pagination: Pagination?
    var pageID = 1 {
        didSet(newValue) {
            pagination?.pageID = newValue
        }
    }

    var recordsPerPage = 15 {
        didSet(newValue) {
            pagination?.recordsPerPage = newValue
        }
    }

    var requestURLString: String {
        return "https://api.github.com/users/JakeWharton/repos?page=\(pageID)&per_page=\(recordsPerPage)"
    }

    func loadRepositories(completionBlock: @escaping ([Repository]?, Error?) -> ()) {
        let manager = NetworkManager()
        manager.reachability = Reachability()
        guard let url = URL(string: requestURLString) else {return}
        manager.getRequestAsync(from: url) { (data, error) in
            if error == nil {
                let dataParser = JsonParserCodable()
                guard let result = dataParser.parse(data: data, to: [Repository].self) else {
                    return
                }
                completionBlock(result, nil)
            } else {
                completionBlock(nil, error)
            }
        }
    }
}
