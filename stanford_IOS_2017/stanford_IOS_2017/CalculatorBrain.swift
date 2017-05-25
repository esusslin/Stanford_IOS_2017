//
//  CalculatorBrain.swift
//  stanford_IOS_2017
//
//  Created by Emmet Susslin on 5/24/17.
//  Copyright © 2017 Emmet Susslin. All rights reserved.
//

import Foundation

func changeSign(operand: Double) -> Double {
    return -operand
}


struct CalculatorBrain {
    
    private var accumulator: Double?
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double,Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String,Operation> = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos" : Operation.unaryOperation(cos),
        "*" : Operation.unaryOperation(changeSign),
        "x" : Operation.binaryOperation({ (op1, op2) in op1 * op2}),
        "/" : Operation.binaryOperation({ (op1, op2) in op1 / op2}),
        "+" : Operation.binaryOperation({ (op1, op2) in return op1 - op2}),
        "-" : Operation.binaryOperation({ (op1, op2) in return op1 + op2}),
        "=" : Operation.equals,
        
        // OR USE CLOSURES:
        
//        "x" : Operation.binaryOperation({ $0 * $1}),
//        "/" : Operation.binaryOperation({ $0 / $1}),
//        "+" : Operation.binaryOperation({ $0 + $1}),
//        "-" : Operation.binaryOperation({ $0 - $1}),
        
    ]
    
    mutating func performOperation(_ symbol: String) {
        
        if let operation = operations[symbol] {
            
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
                
            case .binaryOperation(let function):
                
                pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
            case .equals:
                performPendingBinaryOperation()
                
            }

        }

    }
    
    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double,Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
        
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {
        
        get {
            return accumulator
        }
    }
    
}
