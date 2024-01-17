//
//  LottoViewController.swift
//  SESAC-Network
//
//  Created by Seryun Chun on 2024/01/16.
//

import UIKit
import Alamofire

struct Lotto: Codable {
    let drwNo: Int          // 회차
    let drwNoDate: String   // 날짜
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
    
}

class LottoViewController: UIViewController {
    
    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    let manager = LottoAPIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.callRequest(number: "1102") { value in
            self.dateLabel.text = value
        }
        
    }
    
    @IBAction func textFieldReturnTapped(_ sender: UITextField) {
        // 만약 TextField 에 문자를 입력한 경우에는 통신이 잘 안될 수 있다. <-- 처리가 필요함!
        manager.callRequest(number: numberTextField.text!) { value in
            self.dateLabel.text = value
        }
    }
}
