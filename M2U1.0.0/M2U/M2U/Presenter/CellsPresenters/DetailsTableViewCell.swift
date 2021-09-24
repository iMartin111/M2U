//
//  DetailsTableViewCell.swift
//  M2U
//
//  Created by Yan Akhrameev on 21/09/21.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    
    // MARK: - Properties:
    
    private var showImage: Bool = false
    private var apiManager = APIManager()
    private var favoriteStatusTracker: Bool = false
    
    // MARK: - IBOutlets:

    @IBOutlet weak var animateImage: UIImageView!
    @IBOutlet weak var detailsImage: UIImageView!
    @IBOutlet weak var animateView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var likedStatusButton: UIButton!
    @IBOutlet weak var heightConstrain: NSLayoutConstraint!
    
    // MARK: - View LifeCycle:
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - IBActions:
    
    @IBAction func likedButtonPressed(_ sender: UIButton) {
        favoriteStatusTracker.toggle()
        if favoriteStatusTracker {
            likedStatusButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }  else {
            likedStatusButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    // MARK: - Methods:
    
    func setup(with movie: Movie) {
        self.heightConstrain.constant = 0
        self.animateView.isHidden = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        self.detailsImage.isUserInteractionEnabled = true
        detailsImage.addGestureRecognizer(tapGestureRecognizer)
        
        self.apiManager.fetchMovieImage(for: movie.image) { (result) in
            switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.detailsImage.image = image
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        
        nameLabel.text = movie.name
        likesLabel.text = "❤️ \(movie.likes) Likes"
        viewsLabel.text = "🏆 \(movie.views) Rating"
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        showImage.toggle()
        animatedView()
    }
    
    func selectMode() {
        if animateView.traitCollection.userInterfaceStyle == .dark {
            self.animateImage.image = UIImage(named: "dark")
        } else {
            self.animateImage.image = UIImage(named: "light")
        }
    }
    
    // MARK: - Animation:
    
    func animatedView() {
        selectMode()
        if showImage {
            UIView.animate(withDuration: 0.3) {
                self.heightConstrain.constant = 100
                self.animateView.isHidden = false
                self.animateView.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.animateView.isHidden = true
                self.heightConstrain.constant = 0
                self.animateView.layoutIfNeeded()
            }
        }
    }
    
   
}
