//
//  ViewController.swift
//  SESAC-Network
//
//  Created by Seryun Chun on 2024/01/16.
//

import UIKit
import Alamofire


class ViewController: UIViewController {
    
    @IBOutlet var sourceTextView: UITextView!
    @IBOutlet var translateButton: UIButton!
    @IBOutlet var targetLabel: UILabel!
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 스토리보드로 안하고 addTarget 으로 하는 경우도 많다.
        translateButton.addTarget(self, action: #selector(translateButtonTapped), for: .touchUpInside)
    }
    
    @objc func translateButtonTapped() {
        
        let url: String = "https://openapi.naver.com/v1/papago/n2mt"
        
        let parameters: Parameters = ["text": sourceTextView.text!,
                                      "source": "ko",
                                      "target": "en"]
        
        let headers: HTTPHeaders = ["X-Naver-Client-Id": "_DYSgV_bOxzNA4rYIsch",
                                    "X-Naver-Client-Secret": "fMMZxP6Sb6"]
        
        AF
            .request(url,
                     method: .post,
                     parameters: parameters,
                     headers: headers
            )
            .responseDecodable(of: [Bit].self) { response in
                switch response.result {
                case .success(let success):
                    print(success[0].korean_name)
                case .failure(let failure):
                    print(failure)
                }
            }
    }
    
    
}

