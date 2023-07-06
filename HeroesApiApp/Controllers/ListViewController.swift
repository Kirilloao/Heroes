//
//  ListViewController.swift
//  HeroesApiApp
//
//  Created by Kirill Taraturin on 04.07.2023.
//

import UIKit

final class ListViewController: UICollectionViewController {
    
    // MARK: - Private Properties
    private var heroes: [Hero] = []
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchHeroes(from: Links.heroesApi.rawValue)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailsViewController else { return }
        
        detailVC.hero = sender as? Hero
        
    }
    
    // MARK: - Networking
    private func fetchHeroes(from url: String) {
        NetworkManager.shared.fetchHeroes(from: Links.heroesApi.rawValue) { [weak self] result in
            switch result {
                
            case .success(let heroes):
                self?.heroes = heroes
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ListViewController {
    
    // numberOfItemsInSection
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        heroes.count
    }
    
    // cellForItemAt
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "heroCell", for: indexPath) as? HeroViewCell else { return UICollectionViewCell() }
        
        let hero = heroes[indexPath.item]
        
        cell.configure(with: hero)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ListViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedHero = heroes[indexPath.row]
        
        performSegue(withIdentifier: "showDetailsVC", sender: selectedHero)
    }
}

