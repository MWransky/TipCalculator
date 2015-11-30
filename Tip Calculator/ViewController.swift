//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Michael Wransky on 9/5/15.
//  Copyright (c) 2015 Michael Wransky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var billAmountLabel: UILabel!
    @IBOutlet weak var customTipPercentLabel1: UILabel!
    @IBOutlet weak var customTipSlider: UISlider!
    @IBOutlet weak var customTipPercentLabel2: UILabel!
    @IBOutlet weak var tip15Label: UILabel!
    @IBOutlet weak var total15Label: UILabel!
    @IBOutlet weak var tipCustomLabel: UILabel!
    @IBOutlet weak var totalCustomLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    //NSDecimalNumber constants to use in calculations
    let decimal100=NSDecimalNumber(string:"100.0")
    let decimal15Percent = NSDecimalNumber(string: "0.15")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        inputTextField.becomeFirstResponder()
    }

    
    @IBAction func calculateTips(sender: AnyObject) {
        let inputString = inputTextField.text
        let sliderValue = NSDecimalNumber(integer:Int(customTipSlider.value))
        let customPercent = sliderValue / decimal100
        
        if sender is UISlider {
            customTipPercentLabel1.text=NSNumberFormatter.localizedStringFromNumber(customPercent, numberStyle: NSNumberFormatterStyle.PercentStyle)
            customTipPercentLabel2.text = customTipPercentLabel1.text
        }
        
        if !inputString.isEmpty {
            let billAmount = NSDecimalNumber(string: inputString) / decimal100
            
            if sender is UITextField {
                billAmountLabel.text = " " + formatAsCurrency(billAmount)
                
                let fifteenTip = billAmount * decimal15Percent
                tip15Label.text = formatAsCurrency(fifteenTip)
                total15Label.text = formatAsCurrency(billAmount + fifteenTip)
            }
            
            let customTip = billAmount * customPercent
            tipCustomLabel.text = formatAsCurrency(customTip)
            totalCustomLabel.text = formatAsCurrency(billAmount + customTip)
        }
        else {
            billAmountLabel.text = ""
            tip15Label.text = ""
            total15Label.text = ""
            tipCustomLabel.text = ""
            totalCustomLabel.text = ""
        }
    }
}


func formatAsCurrency(number: NSNumber) ->String {
    return NSNumberFormatter.localizedStringFromNumber(number, numberStyle: NSNumberFormatterStyle.CurrencyStyle)
}

func +(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByAdding(right)
}

func *(left: NSDecimalNumber, right: NSDecimalNumber) ->NSDecimalNumber {
    return left.decimalNumberByMultiplyingBy(right)
}

func /(left: NSDecimalNumber, right: NSDecimalNumber) ->NSDecimalNumber {
    return left.decimalNumberByDividingBy(right)
}
