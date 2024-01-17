//
//  BookViewController.swift
//  SESAC-Network
//
//  Created by Seryun Chun on 2024/01/17.
//

import UIKit
import Alamofire

// MARK: - Welcome
struct Book: Codable {
    let documents: [Document]
    let meta: Meta
}

// MARK: - Document
struct Document: Codable {
    let authors: [String]
    let contents, datetime, isbn: String
    let price: Int
    let publisher: String
    let salePrice: Int
    let status: String
    let thumbnail: String
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case authors, contents, datetime, isbn, price, publisher
        case salePrice = "sale_price"
        case status, thumbnail, title, url
    }
}

// MARK: - Meta
struct Meta: Codable {
    let isEnd: Bool
    let pageableCount, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}

class BookViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
    }
    
    func callRequest(text: String) {
        
        // 만약 한글 검색이 안된다면 '인코딩' 처리가 선행되어야 한다. URL에서 인식할 수 있는 단어로 변환
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url: String = "https://dapi.kakao.com/v3/search/book?query=\(text)"
        
        let headers: HTTPHeaders = ["Authorization": APIKey.kakao]
        
        AF
            .request(url, method: .post, headers: headers)
            .responseDecodable(of: Book.self) { response in
                switch response.result {
                case .success(let success):
                    dump(success.documents)
                case .failure(let failure):
                    print(failure)
                }
            }
    }
}

extension BookViewController: UISearchBarDelegate {
    func configureSearchBar() {
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        callRequest(text: searchBar.text!)
    }
}
