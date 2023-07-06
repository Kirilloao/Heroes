//
//  DetailsViewController.swift
//  HeroesApiApp
//
//  Created by Kirill Taraturin on 05.07.2023.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var heroNameLabel: UILabel!
    @IBOutlet var powerstatsButton: UIButton!
    @IBOutlet var appearanceButton: UIButton!
    @IBOutlet var BiographyButton: UIButton!
    
    @IBOutlet var heroImageView: UIImageView! {
        didSet {
            heroImageView.layer.cornerRadius = 10
        }
    }
    
    // MARK: - Public Properties
    var hero: Hero!
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI(from: hero)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let infoVC =  segue.destination as? InfoViewController else { return }
        
        infoVC.info = sender as? String

    }
    
    // MARK: - IB Actions
    @IBAction func showInfoVC(_ sender: UIButton) {
        if sender.tag == 0 {
            performSegue(withIdentifier: "showInfoVC", sender: hero.powerstats.description)
            
        } else if sender.tag == 1 {
            performSegue(withIdentifier: "showInfoVC", sender: hero.appearance.description)
            
        } else {
            performSegue(withIdentifier: "showInfoVC", sender: hero.biography.description)
            
        }
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













