//
//  PostTableViewCell.swift
//  Reddit36
//
//  Created by Shean Bjoralt on 9/23/20.
//  Copyright © 2020 Shean Bjoralt. All rights reserved.
//

import UIKit

//MARK: - Protocol

protocol PresentErrorToUserDelegate: AnyObject {
    func presentError(error: LocalizedError)
}

class PostTableViewCell: UITableViewCell {
    
    //MARK: - Outlets

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var upvoteLabel: UILabel!
    
    //MARK: - Properties
    
    var post: Post? {
        didSet {
            UpdateViews()
        }
    }
    
    weak var delegate: PresentErrorToUserDelegate?
    
    //MARK: - Helper Methods
    
    func UpdateViews() {
        guard let post = post else { return }
        titleLabel.text = post.title
        upvoteLabel.text = "Upvotes⬆: \(post.ups)"
        thumbnailImageView.image = nil
        
        PostController.fetchThumbnailFor(post: post) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.thumbnailImageView.image = image
                case .failure(let error):
                    self.delegate?.presentError(error: error)
                    print(error.localizedDescription)
                }
            }
        }
    }
}
