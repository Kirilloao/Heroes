//
//  InfoViewController.swift
//  HeroesApiApp
//
//  Created by Kirill Taraturin on 05.07.2023.
//

import UIKit

final class InfoViewController: UITableViewController {
    
    
     
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

// MARK: - UITableViewDataSource
extension InfoViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
        
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension InfoViewController {
    
}
