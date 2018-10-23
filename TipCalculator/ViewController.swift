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
    @IBOutlet weak var tipPercentageSlider: UISlider!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    
    var tipPercentage = Float(15)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipPercentageSlider.value = tipPercentage
        tipPercentageLabel.text = "\(tipPercentage)%"
    }

    @IBAction func billAmountChange(_ sender: Any) {
        calculateTip()
    }
    
    @IBAction func calculateTip() {
        let billAmount = convertStringToFloat(textField: billAmountTextField)
        
        let tip = billAmount * (tipPercentage/100)
        
        tipAmount.text = "Tip amount: $\(tip.rounded(toPlaces: 3))"
    }
    
    @IBAction func sliderChange(_ sender: Any) {
        tipPercentage = tipPercentageSlider.value.rounded()
        tipPercentageLabel.text = "\(Int(tipPercentage))%"
        
        calculateTip()
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

extension FloatingPoint {
    
    public func rounded(toPlaces places: Int) -> Self {
        guard places >= 0 else { return self }
        let divisor = Self(Int(pow(10.0, Float(places))))
        return (self * divisor).rounded() / divisor
    }
}

