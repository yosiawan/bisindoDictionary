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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollView.showsVerticalScrollIndicator = false
        textField.setBottomBorder()
        
        tableVie.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "cellViewCustom")
        
    }
    
}

extension UIViewController: UITableViewDelegate, UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellViewCustom", for: indexPath) as! CustomTableViewCell
        return cell
    }
    
    
    
}

