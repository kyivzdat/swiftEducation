//
//  AboutTVC.swift
//  tableViewProject
//
//  Created by Vladyslav PALAMARCHUK on 12/3/19.
//  Copyright © 2019 Vladyslav PALAMARCHUK. All rights reserved.
//

import UIKit

class AboutTVC: UITableViewController {
    
    let sectionHeader = ["Social network", "Links"]
    let sectionContent = [["facebook", "instagram", "youtube"], ["apple.com", "com.apple"]]
    let firstSectionLinks = ["https://www.facebook.com/apple/", "https://www.instagram.com/apple/", "https://www.youtube.com/user/Apple/"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: .zero)
        
//        let button = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
//        let button2 = UIBarButtonItem(barButtonSystemItem: .camera, target: nil, action: nil)
//        let flexibleSpacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//
//        toolbarItems = [button, flexibleSpacer, button2]
//        navigationController?.isToolbarHidden = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isToolbarHidden = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionHeader.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sectionContent[section].count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeader[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = sectionContent[indexPath.section][indexPath.row]
        return cell
    }
    
    // MARK: - PerformSegue

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            performSegue(withIdentifier: "showWebViewSegue", sender: self)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWebViewSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let dvc = segue.destination as! WebViewVC
            dvc.url = URL(string: firstSectionLinks[indexPath.row])
        }
    }

}
