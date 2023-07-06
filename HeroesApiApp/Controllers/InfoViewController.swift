//
//  InfoViewController.swift
//  HeroesApiApp
//
//  Created by Kirill Taraturin on 05.07.2023.
//

import UIKit

final class InfoViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet var infoLabel: UILabel!
    
    // MARK: - Public Properties
    var info: String!
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        infoLabel.text = info
    }
}
