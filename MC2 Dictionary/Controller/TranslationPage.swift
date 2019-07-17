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
    var filterText: String
    var model = WordsModel()
    var words = [Word]()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        translationView.delegate = self
        translationView.dataSource = self
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
        
        translationView.register(UINib(nibName: "TranslationTableViewCell", bundle: nil), forCellReuseIdentifier: "translationCustomCell")

        // Query CloudKit
        self.model.searchWord(text: filterText)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let img = UIImage()
        self.navigationController?.navigationBar.shadowImage = img
        self.navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
        
        let backColor = #colorLiteral(red: 0.1176470588, green: 0.1529411765, blue: 0.1803921569, alpha: 1)
        navigationController?.navigationBar.tintColor = backColor
        
    }
}

extension TranslationPage: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.Words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "translationCell", for: indexPath)
        
        let word = model.Words[indexPath.row]
        cell.textLabel?.text = word.text
        
        return cell
    }
}
