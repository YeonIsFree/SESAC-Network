//
//  BookViewController.swift
//  SESAC-Network
//
//  Created by Seryun Chun on 2024/01/17.
//

import UIKit
import Alamofire

class BookViewController: UIViewController {
    
    var bookList: [Document] = []
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    
    // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchBar()
        configureCollectionView()
        configureFlowLayout()
    }
    
    func callRequest(text: String) {
        
        // 만약 한글 검색이 안된다면 '인코딩' 처리가 선행되어야 한다. (인코딩 : URL에서 인식할 수 있는 단어로 변환)
        //        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url: String = "https://dapi.kakao.com/v3/search/book?query=\(text)"
        
        let headers: HTTPHeaders = ["Authorization": APIKey.kakao]
        
        AF
            .request(url, method: .post, headers: headers)
            .responseDecodable(of: Book.self) { response in
                switch response.result {
                case .success(let success):
                    self.bookList = success.documents
                case .failure(let failure):
                    print(failure)
                }
            }
    }
}

// MARK: - UICollectionView Delegate

extension BookViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else { print("ERROR")
            return UICollectionViewCell() }
        
        cell.backgroundColor = .orange
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 20
        cell.configureCollectionViewCell(book: bookList[indexPath.item])
        
        return cell
    }
    
    func configureFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width
        let spacing: CGFloat = 10
        let cellWidth = (deviceWidth - spacing * 3 ) / 2
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
    }
}

// MARK: - UISearchBar Delegate

extension BookViewController: UISearchBarDelegate {
    func configureSearchBar() {
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        callRequest(text: searchBar.text!)
        collectionView.reloadData()
    }
}
