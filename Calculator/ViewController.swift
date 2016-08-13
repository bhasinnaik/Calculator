//
//  ViewController.swift
//  Calculator
//
//  Created by Apple on 02/02/1938 Saka.
//  Copyright © 1938 Saka Rang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet private weak var display: UILabel!
      private var userIsInMiddleOfTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        brain.addUnaryOperation("Z") { [ weak weakSelf = self ] in
            weakSelf?.display.textColor = UIColor.redColor()
            return sqrt($0)
            
        
        }
    }
    @IBAction private func touchDigit(sender: UIButton) {
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
    

    private var displayValue: Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    @IBAction private func performOperation(sender: UIButton) {
        if userIsInMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInMiddleOfTyping = false
        }
        
        if let maththematicalSymbol = sender.currentTitle{
            brain.performOperation(maththematicalSymbol)
        }
        displayValue = brain.result
        
    }
    
    @IBAction func touchFloatingPoint(sender: UIButton) {
        let searchCharacter: Character = "."
        if !(display.text!.characters.contains(searchCharacter)){
            touchDigit(sender)
        }
        
    }
}

