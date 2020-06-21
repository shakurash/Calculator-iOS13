//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Robert on 30/04/2020.
//  Copyright © 2020 London App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    private var number: Double?
    
    mutating func setNumber(_ number: Double){
        self.number = number
    }
    
    private var summary:(value: Double, operation: String)?
    
    mutating func calcButtonPressed(sender: String) -> Double?{
        if let nmb = number {
            if sender == "+/-" {
                return nmb * -1
            } else if sender == "AC" {
                return 0
            } else if sender == "%" {
                return nmb / 100
            } else if sender == "=" {
                return performCalculation(n2: nmb)
            } else {
                summary = (value: nmb, operation: sender)
            }
        }
        return nil
    }
    
    private func performCalculation(n2: Double) -> Double? {
        if let n1 = summary?.value, let op = summary?.operation {
            switch op {
            case "+": return n1 + n2
            case "-": return n1 - n2
            case "×": return n1 * n2
            case "÷": return n1 / n2
            default: fatalError("summary cannot be done due to no ivalid case")
            }
        }
        return nil
    }
}
