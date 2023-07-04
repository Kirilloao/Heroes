//
//  HeroViewCell.swift
//  HeroesApiApp
//
//  Created by Kirill Taraturin on 04.07.2023.
//

import UIKit

final class HeroViewCell: UICollectionViewCell {
    
    // MARK: - IB Outlets
    @IBOutlet var heroImageView: UIImageView! {
        didSet {
            heroImageView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet var heroNameLabel: UILabel!
    
    // MARK: - Private Properties
    private var activityIndicator: UIActivityIndicatorView?
    private var imageURL: URL? {
        didSet {
            heroImageView.image = nil
            updateImage()
        }
    }
    
    // MARK: - Override Methods
    override func awakeFromNib() {
        activityIndicator = showSpinner(in: heroImageView)
    }
    
    
    // MARK: - Public Methods
    func configure(with hero: Hero) {
        heroNameLabel.text = hero.name
        imageURL = URL(string: hero.images.lg)
        
    }
    
    // MARK: - Private Methods
    private func updateImage() {
        guard let imageURL = imageURL else { return }
        
        getImage(from: imageURL) { [weak self] result in
            switch result {
                
            case .success(let image):
                if imageURL == self?.imageURL {
                    self?.heroImageView.image = image
                    self?.activityIndicator?.stopAnimating()
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    private func getImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        // Get image from cache
        if let cachedImage = ImageCacheManager.shared.object(forKey: url.lastPathComponent as NSString) {
            completion(.success(cachedImage))
            return
        }
        
        // Download image from url
        NetworkManager.shared.fetchImage(from: url) { result in
            switch result {
            case .success(let imageData):
                guard let uiImage = UIImage(data: imageData) else { return }
                ImageCacheManager.shared.setObject(uiImage, forKey: url.lastPathComponent as NSString)
                
                completion(.success(uiImage))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
    
}
