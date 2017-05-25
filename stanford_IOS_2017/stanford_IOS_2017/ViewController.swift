//
//  ViewController.swift
//  stanford_IOS_2017
//
//  Created by Emmet Susslin on 5/22/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var userInInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        
        if userInInTheMiddleOfTyping {
            
            let textCurrentlyInDisplay = label!.text!
            label!.text = textCurrentlyInDisplay + digit
        } else {
            label!.text = digit
            userInInTheMiddleOfTyping = true
        }
    }
    
    var displayValue: Double {
        
        get {
            return Double(label.text!)!
        }
        set {
            label.text = String(newValue)
            
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        
        if userInInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userInInTheMiddleOfTyping = false
            
        }
        
        
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
            
        }
        
        if let result = brain.result {
            displayValue = result
        }
        
        
    }
    
    
}

