//
//  ViewController.swift
//  simpleCalc
//
//  Created by 古屋 郷 on 2016/12/29.
//  Copyright © 2016年 古屋 郷. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
// class ViewController: UIViewController {
    enum DivisionError: Error {

        case ByZero
    }

    let pickerDataSource = ["+", "-", "*", "/"]
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var calcResultLabel: UILabel!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        picker.dataSource = self
        picker.delegate = self

        textField1.text = "0"
        textField2.text = "0"

        calcResultLabel.textAlignment = NSTextAlignment.right

        updateCalcResult()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateCalcResult()
    }

    @IBAction func textField1(_ sender: UITextField) {
        if textField1.text?.characters.count == 0 {
            textField1.text = "0"
        }
        updateCalcResult()
    }

    @IBAction func textField2(_ sender: UITextField) {
        if textField2.text?.characters.count == 0 {
            textField2.text = "0"
        }
        updateCalcResult()
    }


    func updateCalcResult() {
        let a = Double(textField1.text!)!
        let b = Double(textField2.text!)!
        let op = pickerDataSource[picker.selectedRow(inComponent: 0)]
        var result = ""

        switch op {
            case "+":
                result = String(a + b)
            case "-":
                result = String(a - b)
            case "*":
                result = String(a * b)
            case "/":
                do {
                    if b == 0.0 { throw DivisionError.ByZero }
                    result = String(a / b)
                } catch {
                    result = "0"
                }
            default:
                result = "0"
        }

        calcResultLabel.text = result
    }
}

