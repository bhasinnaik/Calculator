//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Apple on 03/02/1938 Saka.
//  Copyright © 1938 Saka Rang. All rights reserved.
//

import Foundation

class CalculatorBrain{
    private var accumulator = 0.0
    
    func setOperand(operand: Double){
        accumulator = operand
    }
    func addUnaryOperation(symbol: String, operation: (Double) -> Double)
    {
        operations[symbol]  = Operation.UnaryOperation(operation)
        
    }
    var operations: Dictionary<String,Operation> = [
        "π" : Operation.Constant(M_PI),
        "√" : Operation.UnaryOperation(sqrt),
        "cos": Operation.UnaryOperation(cos),
        "✕" : Operation.BinalryOperation({ $0 * $1 }),
        "÷" : Operation.BinalryOperation({ $0 / $1 }),
        "-" : Operation.BinalryOperation({ $0 - $1 }),
        "+" : Operation.BinalryOperation({ $0 + $1 }),
        "=" : Operation.Equals
        
    ]
    enum Operation{
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinalryOperation((Double,Double) -> Double)
        case Equals
    }
    
    struct PendingBinaryOperationInfo {
        var binaryFunction: ((Double,Double) -> Double)
        var firstOperand: Double
    }
    private var pending: PendingBinaryOperationInfo?
    
    func performOperation(symbol: String){
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value): accumulator = value
            case .UnaryOperation(let function): accumulator = function(accumulator)
            case .BinalryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals: executePendingBinaryOperation()
                
            }
        }
    }
    private func executePendingBinaryOperation(){
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand,accumulator)
            pending = nil
        }

    }
    var result: Double {
        get {
            return accumulator
        }
    }
}