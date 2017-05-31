//
//  CaiDatViewController.swift
//  TinhTienTip
//
//  Created by THANH on 5/31/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit

class CaiDatViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var tipAmount = [5, 10, 15]
    var temp: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "CaiDat"
        pickerView.dataSource = self
        pickerView.delegate = self
        temp = 5
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Lấy giá trị từ picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tipAmount.count
    }
    //
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //Trả về
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(tipAmount[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        temp = tipAmount[row]
    }
    //gửi dữ liệu theo key/value đến các controller khác
    @IBAction func btnSave(_ sender: Any) {
        UserDefaults.standard.set(temp, forKey: "tipKey")
        self.navigationController?.popViewController(animated: true)
    }
    
}
