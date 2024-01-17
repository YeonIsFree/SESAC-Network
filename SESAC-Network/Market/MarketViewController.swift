//
//  MarketViewController.swift
//  SESAC-Network
//
//  Created by Seryun Chun on 2024/01/16.
//

import UIKit

struct Bit: Codable {
    let market: String
    let korean_name: String
    let english_name: String
}

class MarketViewController: UIViewController {
    
    var dataList: [Bit] = []
    
    @IBOutlet var marketTableView: UITableView!
    
    let manager = LottoAPIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        marketTableView.dataSource = self
        marketTableView.delegate = self

    }
}

extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = marketTableView.dequeueReusableCell(withIdentifier: "marketCell")!
        
        let data = dataList[indexPath.row]
        
        cell.textLabel?.text = data.korean_name
        cell.detailTextLabel?.text = data.market
        
        return cell
    }
    
    
}
