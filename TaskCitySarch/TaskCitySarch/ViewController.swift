//
//  ViewController.swift
//  TaskCitySarch
//
//  Created by Kishore on 13/08/20.
//  Copyright © 2020 Kishore. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var txtFldSearch: UITextField!
    @IBOutlet weak var txtVw: UITextView!
    @IBOutlet weak var btnSelectAll: UIButton!
    @IBOutlet weak var tblVw: UITableView!
    
    //MARK:- Constants and Variables
    var arrAll = [String]()
    var arrSelected = [String]()
    var arrSearch = [String]()
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 1...100 {
            arrAll.append("City \(i)")
            arrSearch.append("City \(i)")
        }
        tblVw.reloadData()
    }

    //MARK:- IBActions
    @IBAction func actionSelectAll(_ sender: UIButton) {
        if arrAll.count == arrSelected.count {
            arrSelected.removeAll()
        } else {
            arrSelected = arrAll
        }
        sender.isSelected = !sender.isSelected
        txtVw.text = arrSelected.isEmpty ? "" : "All selected"
        tblVw.reloadData()
    }
    
    @IBAction func actionEditChanged(_ sender: UITextField) {
        if sender.text!.isEmpty {
            arrSearch = arrAll
        } else {
            arrSearch.removeAll()
            arrSearch.append(contentsOf: arrAll.filter{$0.contains(sender.text ?? "")})
        }
        tblVw.reloadData()
    }
    
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTVC", for: indexPath) as? DetailTVC {
            cell.lbl.text = arrSearch[indexPath.row]
            cell.btn.isSelected = arrSelected.contains(arrSearch[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = arrSearch[indexPath.row]
        if arrSelected.contains(str) {
            arrSelected.removeAll{$0 == str}
        } else {
            arrSelected.append(str)
        }
        btnSelectAll.isSelected = arrAll.count == arrSelected.count
        txtVw.text = arrAll.count == arrSelected.count ?  "All selected" : arrSelected.joined(separator: ", ")
        tblVw.reloadData()
    }
}
