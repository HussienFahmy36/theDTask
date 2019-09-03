//
//  RepositoryPreviewViewModel.swift
//  DdotAssignment
//
//  Created by Hussien Gamal Mohammed on 9/2/19.
//  Copyright © 2019 Ddot. All rights reserved.
//

import Foundation
struct RepositoryPreviewViewModel {
    var full_name: String = ""
    var repoLink: String = ""
    var progLanguage: String = ""


    init(repo: Repository) {
        full_name = repo.name
        repoLink = repo.gitURL
        progLanguage = repo.language ?? ""
    }
}
