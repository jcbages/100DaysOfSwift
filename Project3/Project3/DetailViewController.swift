//
//  DetailViewController.swift
//  Project3
//
//  Created by Juan Camilo Bages Prada on 5/20/20.
//  Copyright © 2020 Juan Camilo Bages Prada. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var flagImage: UIImageView!

    var countryName: String?
    var selectedImage: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = countryName

        if let imageToLoad = selectedImage {
            flagImage.image = UIImage(named: imageToLoad)
            flagImage.layer.borderWidth = 1
            flagImage.layer.borderColor = UIColor.gray.cgColor
        }

        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareCountry))
    }
    
    @objc func shareCountry() {
        guard let image = flagImage.image?.jpegData(compressionQuality: 1.0) else {
            return
        }
        
        guard let name = countryName else {
            return
        }
        
        let vc = UIActivityViewController(activityItems: [name, image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

}
