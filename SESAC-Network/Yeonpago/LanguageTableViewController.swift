//
//  LanguageViewController.swift
//  SESAC-Network
//
//  Created by Seryun Chun on 2024/01/17.
//

import UIKit
import Alamofire

class LanguageTableViewController: UIViewController {

    var selectedLanguage: String = ""
    let languageList: [String] = Array(languageData.keys)
    
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
    }
}

// MARK: - UITableView Deleage

extension LanguageTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LanguageTableViewCell.identifier, for: indexPath) as? LanguageTableViewCell else { print("ERROR")
            return UITableViewCell() }
        
        cell.languageLabel.text = languageList[indexPath.row]
        
        if cell.languageLabel.text == selectedLanguage {
            cell.languageLabel.textColor = .systemGreen
            cell.languageLabel.font = .boldSystemFont(ofSize: 12)
        }
        
        return cell
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}
