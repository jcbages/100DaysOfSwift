//
//  ViewController.swift
//  Project3
//
//  Created by Juan Camilo Bages Prada on 5/20/20.
//  Copyright © 2020 Juan Camilo Bages Prada. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    let CELL_IDENTIFIER = "FlagCell"
    let DETAIL_IDENTIFIER = "FlagDetail"

    let countries: [String] = [
        "estonia", "france", "germany", "ireland", "italy", "monaco",
        "nigeria", "poland", "russia", "spain", "uk", "us"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let country = countries[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath)
        cell.textLabel?.text = country.uppercased()
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: DETAIL_IDENTIFIER) as? DetailViewController {
            let country = countries[indexPath.row]

            vc.countryName = country.uppercased()
            vc.selectedImage = country

            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

