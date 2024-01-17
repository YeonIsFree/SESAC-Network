//
//  LottoAPIManager.swift
//  SESAC-Network
//
//  Created by Seryun Chun on 2024/01/16.
//

import UIKit
import Alamofire

struct LottoAPIManager {
    
    func callRequest(number: String, copletionHandler: @escaping (String) -> Void) {
        let url: String = " https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        
        AF
            .request(url, method: .get)
            .responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let success):
                    print(success)
//                    self.dateLabel.text = success.drwNoDate
                    copletionHandler(success.drwNoDate)
                case .failure(let failure):
                    print("오류 발생")
                }
            }
    }
    
}
