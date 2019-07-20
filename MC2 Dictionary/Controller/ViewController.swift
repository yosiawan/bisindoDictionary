//
//  ViewController.swift
//  scrollView
//
//  Created by wimba prasiddha on 15/07/19.
//  Copyright © 2019 wimba prasiddha. All rights reserved.
//

import UIKit

extension UITextField{
    func setBottomBorder(){
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}


class ViewController: UIViewController {

    @IBOutlet weak var tableVie: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var selectedTopic: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
        scrollView.showsVerticalScrollIndicator = false
        textField.setBottomBorder()
        
        tableVie.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "cellViewCustom")
        
        navigationController?.navigationBar.prefersLargeTitles = true        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
   
        let img = UIImage()
        self.navigationController?.navigationBar.shadowImage = img
        self.navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
    }
    
    // Get cell data
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
        selectedTopic = selectedCell.topikLabel?.text ?? "Kucing"
        performSegue(withIdentifier: "topikSegue", sender: self)
    }
    
    // Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Terjemahan" {
            let controller = segue.destination as! TranslationPage
            controller.filterText = textField.text ?? "Kucing"
        }
        if segue.identifier == "topikSegue" {
            let controller = segue.destination as! topikPreferences
            controller.sentences = topikSentences[selectedTopic] ?? [[""]]
        }    
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TopikName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellViewCustom", for: indexPath) as! CustomTableViewCell
        cell.topikLabel?.text = TopikName[indexPath.row]
        cell.topikImage.image = UIImage(named: TopikName[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1.0)
        
        UIView.animate(withDuration: 0.4, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
        }, completion: nil)
    
    }
}
