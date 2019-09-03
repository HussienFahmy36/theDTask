//
//  RepositoryPreviewCell.swift
//  DdotAssignment
//
//  Created by Hussien Gamal Mohammed on 9/2/19.
//  Copyright © 2019 Ddot. All rights reserved.
//

import UIKit

class RepositoryPreviewCell: UITableViewCell {

    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var repoLinkLabel: UILabel!
    @IBOutlet weak var progLangLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func config(viewModel: RepositoryPreviewViewModel) {
        ownerLabel?.text = viewModel.full_name
        repoLinkLabel.text = viewModel.repoLink
        progLangLabel.text = viewModel.progLanguage
        setupLinkLabelFormat()
    }

    private func setupLinkLabelFormat() {
        let fontSize = ownerLabel.font.pointSize
        let attributedString = NSMutableAttributedString(string: repoLinkLabel.text ?? "")
        let range = NSRange(location: 0,
                            length: repoLinkLabel.text?.count ?? 0)
        attributedString.addAttribute(.link,
                                      value: repoLinkLabel.text ?? "",
                                      range: range)
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: fontSize), range: range)
        repoLinkLabel.attributedText = attributedString
    }


}
