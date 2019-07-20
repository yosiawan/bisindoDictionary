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
    var hardcodedResult: [String]?
    
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
        errorMessage.alpha = 0
        if filterText != nil {
            model.searchDictionary(text: filterText!, refreshFunc: self.refreshFunction, errorFunc: errorFunction)
        }
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
        if filterText != nil {
            return model.Words.count
        }
        
        if hardcodedResult != nil {
            return hardcodedResult?.count ?? 0
        }

        else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "translationCustomCell", for: indexPath) as! TranslationTableViewCell
        
        cell.selectionStyle = .none
        if filterText != nil {
            print("ke filtertext", filterText ?? "tapi kosong")
            let word = model.Words[indexPath.row]
            cell.terjemahan.text = word.text
            cell.videoTerjemahan.image = UIImage.gifImageWithURL(word.video.fileURL?.absoluteString ?? "")
        }
        
        if hardcodedResult != nil {
            let gif = UIImage.gifImageWithName(hardcodedResult?[indexPath.row] ?? "")
            if gif != nil {
                cell.videoTerjemahan.image = gif
            } else {
                cell.videoTerjemahan.image = UIImage(named: "Group 3")
            }
            cell.terjemahan.text = hardcodedResult?[indexPath.row]
            loadingIndicator?.stopAnimating()
            self.loadingIndicator.alpha = 0
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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

