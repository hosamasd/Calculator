//
//  Enums.swift
//  Calculator
//
//  Created by hosam on 1/8/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit


enum CalculatorButton: String , CaseIterable{
    
    case zero, one, two, three, four, five, six, seven, eight, nine
    case equals, plus, minus, multiply, divide
    case decimal
    case ac, plusMinus, percent
    
    var title: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "X"
        case .divide: return "/"
        case .plusMinus: return "+/-"
        case .percent: return "%"
        case .equals: return "="
        case .decimal: return "."
            
        default:
            return "AC"
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal:
            return .darkGray
        case .ac, .plusMinus, .percent:
            return .lightGray
        default:
            return .orange
        }
    }
    
}


enum operatorType {
    case plus
    case subtract
    case multiply
    case divide
    case none
}
