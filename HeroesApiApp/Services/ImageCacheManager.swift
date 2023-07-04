//
//  ImageCacheManager.swift
//  HeroesApiApp
//
//  Created by Kirill Taraturin on 04.07.2023.
//

import UIKit

final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
