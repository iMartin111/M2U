//
//  RelatedTableViewCell.swift
//  M2U
//
//  Created by Yan Akhrameev on 22/09/21.
//

import UIKit

class RelatedTableViewCell: UITableViewCell {
    // MARK: - Properties:
    
    private var apiManager = APIManager()
    
    // MARK: - IBOutlets:
    
    @IBOutlet weak var relatedImage: UIImageView!
    @IBOutlet weak var relatedNameLabel: UILabel!
    @IBOutlet weak var relatedInfoLabel: UILabel!
    
    // MARK: - View LifeCycle:
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Methods:
    
    func setup(with movie: Movie) {
        self.apiManager.fetchMovieImage(for: movie.image) { (result) in
            switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.relatedImage.image = image
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        relatedNameLabel.text = movie.name
        relatedInfoLabel.text = "Released: \(movie.year), \(movie.views) Rating"
    }
    
}
