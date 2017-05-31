//
//  ViewController.swift
//  TinhTienTip
//
//  Created by THANH on 5/31/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    //Khai báo các biến tham chiếu đến các control
    @IBOutlet var txtBillAmount: UITextField!
    @IBOutlet var lblTipAmount: UILabel!
    @IBOutlet var lblTipResult: UILabel!
    @IBOutlet var lblTotal: UILabel!
    //
    var tipAmount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Ẩn label khi khởi động chương trình
        lblTipResult.isHidden = true
        lblTotal.isHidden = true
        //Set keyboard kiểu decimalPad
        txtBillAmount.keyboardType = UIKeyboardType.decimalPad
        //Lấy dữ liệu giữa các controller, dựa vào cặp key/value. Ở đây lấy value ứng với key   tipKey
        if let temp = UserDefaults.standard.object(forKey: "tipKey") as? Int {
            lblTipAmount.text = String(temp)
            tipAmount = temp
        }else {
            lblTipAmount.text = "5"
            tipAmount = 5
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let temp = UserDefaults.standard.object(forKey: "tipKey") as? Int {
            lblTipAmount.text = String(temp)
            tipAmount = temp
        }
        txtBillAmount.text?.removeAll()
        lblTipResult.isHidden = true
        lblTotal.isHidden = true
    }
    //Hàm lấy ngày hiện tại
    func getCurrentDate() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let date = formatter.string(from: currentDate)
        return date
    }
    //Hàm xử lí Khi click button btnTinhToan
    @IBAction func btnTinhToanClick(_ sender: Any) {
        if txtBillAmount.text!.isEmpty {
            // Hiện thông báo cần nhập thông tin đầy đủ
            let alert = UIAlertController(title: "Error", message: "You must input Bill Amount!", preferredStyle: UIAlertControllerStyle.alert);
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil));
            self.present(alert, animated: true, completion: nil);
        }
            //Trả về và hiển thị kết quả
        else {
            let result = calculate()
            lblTipResult.text = "\(result[0])"
            lblTipResult.isHidden = false
            lblTotal.text = "\(result[1])"
            lblTotal.isHidden = false
            view.endEditing(true)
            let date = getCurrentDate()
            // Lưu lại lịch sử
            // 1
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            
            // 2
            let entity = NSEntityDescription.entity(forEntityName: "LichSuThanhToan", in: managedContext)!
            
            let history = NSManagedObject(entity: entity, insertInto: managedContext)
            
            // 3
            history.setValue(date, forKeyPath: "date")
            history.setValue(result[0], forKeyPath: "tipResult")
            history.setValue(result[1], forKeyPath: "total")
            history.setValue(result[2], forKeyPath: "billAmount")
            history.setValue(result[3], forKeyPath: "tipAmount")
            
            // 4 Lưu lại Lịch sử
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
        }
    }
    //Hàm tính tiền tip
    
    func calculate() -> [Double] {
        let billAmount: Double = Double(txtBillAmount.text!)!
        let tipResult = billAmount * Double(tipAmount!) / 100
        let totalAmount = billAmount + tipResult
        return [tipResult, totalAmount, billAmount, Double(tipAmount!)]
    }
    
    //Hàm valid cho textField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
        
        let components = string.components(separatedBy: inverseSet)
        
        let filtered = components.joined(separator: "")
        
        if filtered == string {
            return true
        } else {
            if string == "." {
                let countdots = txtBillAmount.text!.components(separatedBy:".").count - 1
                if countdots == 0 {
                    return true
                }else{
                    if countdots > 0 && string == "." {
                        return false
                    } else {
                        return true
                    }
                }
            }else{
                if string == "-" {
                    if (txtBillAmount.text!.isEmpty == true){
                        return true
                    } else {
                        return false
                    }
                } else {
                    return false
                }
            }
        }
    }
}


