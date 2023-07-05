//
//  DetailsViewController.swift
//  HeroesApiApp
//
//  Created by Kirill Taraturin on 05.07.2023.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var heroImageView: UIImageView! {
        didSet {
            heroImageView.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet var heroNameLabel: UILabel!
    
    // MARK: - Public Properties
    var hero: Hero!

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI(from: hero)
    }
    
    // MARK: - Private Methods
    private func setupUI(from hero: Hero) {
        heroNameLabel.text = hero.name
        
        guard let heroURL = URL(string: hero.images.lg) else { return }
        
        NetworkManager.shared.fetchImage(from: heroURL) { [weak self] result in
            switch result {
                
            case .success(let heroImage):
                self?.heroImageView.image = UIImage(data: heroImage)
            case .failure(let error):
                print(error)
            }
        }
    }
    


}
