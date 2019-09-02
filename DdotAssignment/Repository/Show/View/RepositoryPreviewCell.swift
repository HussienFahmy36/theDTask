//
//  RepositoryPreviewCell.swift
//  DdotAssignment
//
//  Created by Hussien Gamal Mohammed on 9/2/19.
//  Copyright © 2019 Ddot. All rights reserved.
//

import UIKit

class RepositoryPreviewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func config(viewModel: RepositoryPreviewViewModel) {
        textLabel?.text = viewModel.full_name
    }

}
