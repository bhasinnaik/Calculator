//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Apple on 03/02/1938 Saka.
//  Copyright © 1938 Saka Rang. All rights reserved.
//

import Foundation

class CalculatorBrain{
    fileprivate var accumulator = 0.0
    
    func setOperand(_ operand: Double){
        accumulator = operand
    }
    func addUnaryOperation(_ symbol: String, operation: @escaping (Double) -> Double)
    {
        operations[symbol]  = Operation.unaryOperation(operation)
        
    }
    var operations: Dictionary<String,Operation> = [
        "π" : Operation.constant(M_PI),
        "√" : Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "✕" : Operation.binalryOperation({ $0 * $1 }),
        "÷" : Operation.binalryOperation({ $0 / $1 }),
        "-" : Operation.binalryOperation({ $0 - $1 }),
        "+" : Operation.binalryOperation({ $0 + $1 }),
        "=" : Operation.equals
        
    ]
    enum Operation{
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binalryOperation((Double,Double) -> Double)
        case equals
    }
    
    struct PendingBinaryOperationInfo {
        var binaryFunction: ((Double,Double) -> Double)
        var firstOperand: Double
    }
    fileprivate var pending: PendingBinaryOperationInfo?
    
    func performOperation(_ symbol: String){
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value): accumulator = value
            case .unaryOperation(let function): accumulator = function(accumulator)
            case .binalryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .equals: executePendingBinaryOperation()
                
            }
        }
    }
    fileprivate func executePendingBinaryOperation(){
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
