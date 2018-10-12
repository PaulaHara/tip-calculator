//
//  ViewController.swift
//  TipCalculator
//
//  Created by paula on 2018-10-11.
//  Copyright © 2018 paula. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var calculateTipBtn: UIButton!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var tipPercentageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipPercentageTextField.text = "15"
    }

    @IBAction func calculateTip() {
        let tipPercentage = convertStringToFloat(textField: tipPercentageTextField)
        let billAmount = convertStringToFloat(textField: billAmountTextField)
        
        let tip = billAmount * (tipPercentage/100)
        
        tipAmount.text = "Tip amount: $\(tip)"
    }
    
    private func convertStringToFloat( textField: UITextField) -> Float {
        if let numberAsText = textField.text {
            if let numberAsFloat = Float(numberAsText) {
                return numberAsFloat
            }
        }
        return 0
    }

}

