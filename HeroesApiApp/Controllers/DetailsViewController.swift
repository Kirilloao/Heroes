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
    
    @IBOutlet var powerstatsButton: UIButton!
    @IBOutlet var appearanceButton: UIButton!
    @IBOutlet var BiographyButton: UIButton!
    
    // MARK: - Public Properties
    var hero: Hero!

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI(from: hero)
        
        let dictionart = createDictionary(from: hero.connections)
        print(dictionart)
    }
    
    // MARK: - IB Actions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let infoVC = segue.destination as? InfoViewController else { return }
        
        
    }
    
    @IBAction func showInfoVC(_ sender: UIButton) {
        performSegue(withIdentifier: "showInfoVC", sender: nil)
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
    
    private func createDictionary<T>(from powerstats: T) -> [String: Any] {
          var dictionary: [String: Any] = [:]

          let mirror = Mirror(reflecting: powerstats)
          for child in mirror.children {
              if let propertyName = child.label {
                  dictionary[propertyName] = child.value
              }
          }

          return dictionary
      }
}













