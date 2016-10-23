//
//  ViewController.swift
//  Calculator
//
//  Created by Apple on 02/02/1938 Saka.
//  Copyright © 1938 Saka Rang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet fileprivate weak var display: UILabel!
      fileprivate var userIsInMiddleOfTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        brain.addUnaryOperation("Z") { [ weak weakSelf = self ] in
            weakSelf?.display.textColor = UIColor.red
            return sqrt($0)
            
        
        }
    }
    @IBAction fileprivate func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInMiddleOfTyping{
            let textCurrentlyDisplay = display.text!
            display.text = textCurrentlyDisplay + digit
        }
        else{
            display.text = digit
        }
        userIsInMiddleOfTyping = true
        //print("touched \(digit) Digit")
    }
    

    fileprivate var displayValue: Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    fileprivate var brain = CalculatorBrain()
    @IBAction fileprivate func performOperation(_ sender: UIButton) {
        if userIsInMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInMiddleOfTyping = false
        }
        
        if let maththematicalSymbol = sender.currentTitle{
            brain.performOperation(maththematicalSymbol)
        }
        displayValue = brain.result
        
    }
    
    @IBAction func touchFloatingPoint(_ sender: UIButton) {
        let searchCharacter: Character = "."
        if !(display.text!.characters.contains(searchCharacter)){
            touchDigit(sender)
        }
        
    }
}

