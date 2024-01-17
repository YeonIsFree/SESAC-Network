//
//  BookCollectionViewCell.swift
//  SESAC-Network
//
//  Created by Seryun Chun on 2024/01/17.
//

import UIKit
import Kingfisher

class BookCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    func configureCollectionViewCell(book: Document) {
        titleLabel.text = book.title
        titleLabel.textColor = .white
        
        rateLabel.text = book.authors[0]
        rateLabel.textColor = .white
        
        if let imageUrl = URL(string: book.thumbnail) {
            imageView.kf.setImage(with: imageUrl)
        } else { return }
    }
    
}
