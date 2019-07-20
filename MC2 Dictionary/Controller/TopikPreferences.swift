//
//  TopikPreferences.swift
//  MC2 Dictionary
//
//  Created by wimba prasiddha on 17/07/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class topikPreferences: UIViewController {
    
    
    @IBOutlet weak var preferencesTopik: UITableView!
    var sentences: [[String]] = []
    public var selectedSentenceKeys: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
    

       preferencesTopik.delegate = self
       preferencesTopik.dataSource = self
        
       preferencesTopik.register(UINib(nibName: "TopikTableViewCell", bundle: nil), forCellReuseIdentifier: "topikTableViewCell")
      
        setupNavbar()
    }
    
    // Get cell data
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCell = tableView.cellForRow(at: indexPath) as! TopikTableViewCell
        selectedSentenceKeys = selectedCell.selectedSentenceKeys
        performSegue(withIdentifier: "topikToTranslation", sender: self)
    }
    
    // Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "topikToTranslation" {
            let controller = segue.destination as! TranslationPage
            controller.hardcodedResult = selectedSentenceKeys
        }
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

extension topikPreferences: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sentences.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topikTableViewCell", for: indexPath) as! TopikTableViewCell
        cell.selectedSentenceKeys = sentences[indexPath.row]
        cell.sentenceLabel.text = sentences[indexPath.row].joined(separator: " ")
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1.0)
        
        UIView.animate(withDuration: 0.4, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
        }, completion: nil)
    }
    
    
}
