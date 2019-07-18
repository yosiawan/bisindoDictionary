//
//  TranslationPage.swift
//  MC2 Dictionary
//
//  Created by wimba prasiddha on 16/07/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class TranslationPage: UIViewController {

    @IBOutlet weak var translationView: UITableView!
    var filterText: String?
    var model = WordsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        translationView.delegate = self
        translationView.dataSource = self
        translationView.register(UINib(nibName: "TranslationTableViewCell", bundle: nil), forCellReuseIdentifier: "translationCustomCell")

        setupNavbar()
        // Query CloudKit
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(filterText!)
        model.searchWord(text: filterText!)
    }
    func setupNavbar(){
        let img = UIImage()
        self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.shadowImage = img
        self.navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
        let backColor = #colorLiteral(red: 0.1176470588, green: 0.1529411765, blue: 0.1803921569, alpha: 1)
        navigationController?.navigationBar.tintColor = backColor
        navigationController?.isNavigationBarHidden = false

    }
}

extension TranslationPage: UITableViewDelegate, UITableViewDataSource
{
    
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "translationCell", for: indexPath) as! TranslationTableViewCell
//
////        cell.terjemahan.text = model.Words[indexPath.row].text
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.model.records.count
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "translationCustomCell", for: indexPath) as! TranslationTableViewCell
        
//        cell.terjemahan.text = model.Words[indexPath.row].text
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
