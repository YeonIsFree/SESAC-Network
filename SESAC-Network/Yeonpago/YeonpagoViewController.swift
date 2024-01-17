//
//  ViewController.swift
//  SESAC-Network
//
//  Created by Seryun Chun on 2024/01/16.
//

import UIKit
import Alamofire

struct Papago: Codable {
    let message: PapagoResult
}

struct PapagoResult: Codable {
    let result: PapageMessage
}

struct PapageMessage: Codable {
    let srcLangType: String
    let tarLangType: String
    let translatedText: String
}

class YeonpagoViewController: UIViewController {

    var selectedLanguage: String = ""
    
    @IBOutlet var headerView: UIView!
    @IBOutlet var sourceLanguageButton: UIButton!
    @IBOutlet var targetLanguagebutton: UIButton!
    @IBOutlet var sourceTextView: UITextView!
    @IBOutlet var translateButton: UIButton!
    @IBOutlet var targetLabel: UILabel!
    @IBOutlet var changeButton: UIButton!
    
    // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UI configuration
        configureTextView(sourceTextView)
        configureTextView(targetLabel)
        headerViewShadow()
        configureTranslateButton()
        
        // Button Action configuration
        sourceLanguageButton.addTarget(self, action: #selector(languageButtonTapped), for: .touchUpInside)
        targetLanguagebutton.addTarget(self, action: #selector(languageButtonTapped), for: .touchUpInside)
        changeButton.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
        translateButton.addTarget(self, action: #selector(translateButtonTapped), for: .touchUpInside)
    }
    
     // MARK: - API Call Method
    
    func callRequest(text: String, source: String, target: String) {
        let url: String = "https://openapi.naver.com/v1/papago/n2mt"
        
        let parameters: Parameters = ["text": sourceTextView.text!,
                                      "source": languageData[source] ?? "",
                                      "target": languageData[target] ?? ""]
        
        let headers: HTTPHeaders = ["X-Naver-Client-Id": APIKey.clientID,
                                    "X-Naver-Client-Secret": APIKey.clientSecret]
        
        AF
            .request(url,
                     method: .post,
                     parameters: parameters,
                     headers: headers
            )
            .responseDecodable(of: Papago.self) { response in
                switch response.result {
                case .success(let success):
                    self.targetLabel.text = success.message.result.translatedText
                case .failure(let failure):
                    print(failure)
                }
            }
    }
}

 // MARK: - Button Action Medthods

extension YeonpagoViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? LanguageTableViewController {
            vc.selectedLanguage = selectedLanguage
        }
    }
    
    @objc func languageButtonTapped(sender: UIButton) {
        selectedLanguage = sender.titleLabel?.text ?? ""
    }
    
    @objc func translateButtonTapped(sender: UIButton) {
        let sourceLanguage = sourceLanguageButton.titleLabel?.text ?? ""
        let targetLanguage = targetLanguagebutton.titleLabel?.text ?? ""
        callRequest(text: sourceTextView.text!, source: sourceLanguage, target: targetLanguage)
    }
    
    @objc func changeButtonTapped() {
        // Button title swap
        let temp = sourceLanguageButton.titleLabel?.text
        sourceLanguageButton.titleLabel?.text = targetLanguagebutton.titleLabel?.text
        targetLanguagebutton.titleLabel?.text = temp
    }
}

 // MARK: - UI configure Method

extension YeonpagoViewController {
    func headerViewShadow() {
        headerView.layer.masksToBounds = false
        headerView.layer.shadowColor = UIColor.gray.cgColor
        headerView.layer.shadowOpacity = 0.1
        headerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        headerView.layer.shadowRadius = 0.1
    }
    
    func configureTranslateButton() {
        translateButton.tintColor = .white
        translateButton.backgroundColor = .systemGreen
        translateButton.clipsToBounds = true
        translateButton.layer.cornerRadius = 10
    }
    
    func configureTextView(_ textview: UIView) {
        textview.layer.borderWidth = 1
        textview.layer.borderColor = UIColor.lightGray.cgColor
        textview.layer.cornerRadius = 5
    }
}
