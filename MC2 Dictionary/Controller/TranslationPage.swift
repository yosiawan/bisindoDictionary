//
//  TranslationPage.swift
//  MC2 Dictionary
//
//  Created by wimba prasiddha on 16/07/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit
import CloudKit

class TranslationPage: UIViewController {

    @IBOutlet weak var translationView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorMessage: UILabel!
    
    var filterText: String?
    var model = DictionaryModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        translationView.delegate = self
        translationView.dataSource = self
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
        translationView.register(UINib(nibName: "TranslationTableViewCell", bundle: nil), forCellReuseIdentifier: "translationCustomCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("filter", filterText!)
        errorMessage.alpha = 0
        model.searchDictionary(text: filterText!, refreshFunc: self.refreshFunction, errorFunc: errorFunction)
        loadingIndicator?.startAnimating()
    }
    
    func setupNavbar(){
        let img = UIImage()
        self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.shadowImage = img
        self.navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
        let backColor = #colorLiteral(red: 0.1176470588, green: 0.1529411765, blue: 0.1803921569, alpha: 1)
        navigationController?.navigationBar.tintColor = backColor
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1176470588, green: 0.1529411765, blue: 0.1803921569, alpha: 1)
    }
    
    func errorFunction() {
        DispatchQueue.main.async {
            self.errorMessage.alpha = 1
        }
    }
    
    func refreshFunction() {
        DispatchQueue.main.async {
            self.translationView.reloadData()
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.alpha = 0
        }
    }
}

extension TranslationPage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.Words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "translationCustomCell", for: indexPath) as! TranslationTableViewCell
        
        cell.selectionStyle = .none
        let word = model.Words[indexPath.row]
        cell.terjemahan.text = word.text
        cell.videoTerjemahan.image = UIImage.gifImageWithURL(word.video.fileURL?.absoluteString ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

let defaultUrl = URL(fileReferenceLiteralResourceName: "Group 3")

extension CKAsset {
    func toUIImage() -> UIImage? {
        if let data = NSData(contentsOf: self.fileURL ?? defaultUrl) {
            return UIImage(data: data as Data)
        }
        return nil
    }
}

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

