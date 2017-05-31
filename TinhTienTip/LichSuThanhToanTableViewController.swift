//
//  LichSuThanhToanTableViewController.swift
//  TinhTienTip
//
//  Created by THANH on 5/31/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit
import CoreData
class LichSuThanhToanTableViewController: UITableViewController {
    
    var historyList: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LichSuThanhToan")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            for result in results{
                historyList.append(result as! NSManagedObject)
            }
        } catch {
            print("Error")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return historyList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LichSu_Cell", for: indexPath) as! LichSuThanhToanTableViewCell
        let history = historyList[indexPath.row]
        cell.lblDate.text = history.value(forKeyPath: "date") as? String
        if let billAmount = history.value(forKeyPath: "billAmount") {
            cell.lblBillAmount.text = "Tiền Hoá đơn: \(billAmount)"
        }
        if let tipAmount = history.value(forKeyPath: "tipAmount") {
            cell.lblTipAmount.text =  "% Tip: \(tipAmount)"
        }
        if let tipResult = history.value(forKeyPath: "tipResult") {
            cell.lblTipResult.text = "Tiền TIP: \(tipResult)"
        }
        if let totalAmount = history.value(forKeyPath: "total") {
            cell.lblTotalAmount.text = "Tổng Tiền: \(totalAmount)"
        }
        return cell
    }

    
}
