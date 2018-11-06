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
    @IBOutlet weak var outerStackView: UIStackView!
    @IBOutlet weak var textFieldStackView: UIStackView!
    @IBOutlet weak var outerStackViewTopConstraint: NSLayoutConstraint!
    var outerStackViewTopConstraintConstant:CGFloat = 32
    
    var tipPercentage = Float(15)
    
    override func viewDidLoad() {
        super.viewDidLoad()
                  
        tipPercentageSlider.value = tipPercentage
        tipPercentageLabel.text = "\(tipPercentage)%"
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.billAmountTextField.resignFirstResponder()
        
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.25, animations: {
            self.outerStackViewTopConstraint.constant = self.outerStackViewTopConstraintConstant
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let info = notification.userInfo {
            let rect:CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            
            let targetY = view.frame.size.height - rect.height - 20 - billAmountTextField.frame.size.height
            let textFieldY = outerStackView.frame.origin.y + textFieldStackView.frame.origin.y + billAmountTextField.frame.origin.y
            
            let difference = targetY - textFieldY
            
            let targetOffsetForTopConstraint = outerStackViewTopConstraint.constant + difference
            
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.25, animations: {
                self.outerStackViewTopConstraint.constant = targetOffsetForTopConstraint
                self.view.layoutIfNeeded()
            })
        }
    }
}

extension FloatingPoint {
    
    public func rounded(toPlaces places: Int) -> Self {
        guard places >= 0 else { return self }
        let divisor = Self(Int(pow(10.0, Float(places))))
        return (self * divisor).rounded() / divisor
    }
}

