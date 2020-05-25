//
//  URLPickerTableViewController.swift
//  Project4
//
//  Created by Juan Camilo Bages Prada on 5/24/20.
//  Copyright © 2020 Juan Camilo Bages Prada. All rights reserved.
//

import UIKit

class URLPickerTableViewController: UITableViewController {
    
    let CELL_IDENTIFIER = "URLCell"
    let BROWSER_INDENTIFIER = "WebBrowser"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pick a URL"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WEBSITES.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath)
        cell.textLabel?.text = WEBSITES[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: BROWSER_INDENTIFIER) as? ViewController else {
            return
        }

        vc.loadUrl = WEBSITES[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}
