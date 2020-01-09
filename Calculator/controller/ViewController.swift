//
//  ViewController.swift
//  Calculator
//
//  Created by hosam on 1/8/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    let labelText = UILabel(text: "0", font: .systemFont(ofSize: 25), textColor: .white, textAlignment: .right, numberOfLines: 0)
    
    
    lazy var acButton = createButtons(text: "AC", backgroundColor: #colorLiteral(red: 0.5988357663, green: 0.598936975, blue: 0.5988141894, alpha: 1), action: #selector(handleClear))
    lazy var plusMinsButton = createButtons(text: "+-", backgroundColor: #colorLiteral(red: 0.5988357663, green: 0.598936975, blue: 0.5988141894, alpha: 1), action: #selector(handlePlusMinus))
    lazy var percentButton = createButtons(text: "%", backgroundColor: #colorLiteral(red: 0.5988357663, green: 0.598936975, blue: 0.5988141894, alpha: 1), action: #selector(handlePercent))
    
    lazy var divideButton = createButtons(text: "/", backgroundColor: #colorLiteral(red: 0.9752290845, green: 0.641053319, blue: 0.02241232432, alpha: 1), action: #selector(pressDivide))
    lazy var multiButton = createButtons(text: "*", backgroundColor: #colorLiteral(red: 0.9752290845, green: 0.641053319, blue: 0.02241232432, alpha: 1), action: #selector(pressMultiply))
    lazy var minusButton = createButtons(text: "-", backgroundColor: #colorLiteral(red: 0.9752290845, green: 0.641053319, blue: 0.02241232432, alpha: 1), action: #selector(pressMinus))
    lazy var plusButton = createButtons(text: "+", backgroundColor: #colorLiteral(red: 0.9752290845, green: 0.641053319, blue: 0.02241232432, alpha: 1), action: #selector(pressPlus))
    lazy var dotButton = createButtons(text: ".", backgroundColor: #colorLiteral(red: 0.3995377123, green: 0.3996080756, blue: 0.3995227218, alpha: 1), action: #selector(handleTyped))
    lazy var zeroButton = createButtons(isZero:true,text: "0", backgroundColor: #colorLiteral(red: 0.3995377123, green: 0.3996080756, blue: 0.3995227218, alpha: 1), action: #selector(handleTyped))
    lazy var equalButton = createButtons(text: "=", backgroundColor: #colorLiteral(red: 0.9752290845, green: 0.641053319, blue: 0.02241232432, alpha: 1), action: #selector(handleEqual))
    lazy var numberButtons:[UIButton] = {
        var bt = [UIButton]()
        for x in 1...9 {
            bt.append(createButtons(text: "\(x)", backgroundColor: #colorLiteral(red: 0.3995377123, green: 0.3996080756, blue: 0.3995227218, alpha: 1), action: #selector(handleTyped)))
        }
        return bt
    }()
    
    var firstValue = true
    var subTotal: Double?
    var lastOperator: operatorType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    func setupViews()  {
        labelText.constrainHeight(constant: 200)
        view.backgroundColor = .black
        let subOperation = view.getStack(views: acButton,plusMinsButton,percentButton, spacing: 8, distribution: .fillEqually, axis: .horizontal)
        let operation = view.getStack(views: divideButton,multiButton,minusButton,plusButton, spacing: 16, distribution: .fillEqually, axis: .vertical)
        
        let numberStack = view.getStack(views: numberButtons[0],numberButtons[1],numberButtons[2], spacing: 8, distribution: .fillEqually, axis: .horizontal)
        let numberStack2 = view.getStack(views: numberButtons[3],numberButtons[4],numberButtons[5], spacing: 8, distribution: .fillEqually, axis: .horizontal)
        let numberStack3 = view.getStack(views: numberButtons[6],numberButtons[7],numberButtons[8], spacing: 8, distribution: .fillEqually, axis: .horizontal)
        
        let numberStack4 = view.getStack(views: zeroButton,dotButton,equalButton, spacing: 8, distribution: .fill, axis: .horizontal)
        
        view.addSubViews(views: numberStack4,numberStack,operation,numberStack2,numberStack3,subOperation,labelText)
        
        
        labelText.anchor(top: nil, leading: view.leadingAnchor, bottom: operation.topAnchor, trailing: operation.leadingAnchor,padding: .init(top: 0, left: 8, bottom: 0, right:-64))
        subOperation.anchor(top: nil, leading: view.leadingAnchor, bottom: numberStack3.topAnchor, trailing: operation.leadingAnchor,padding: .init(top: 0, left: 8, bottom: 16, right: 8))
        numberStack3.anchor(top: nil, leading: view.leadingAnchor, bottom: numberStack2.topAnchor, trailing: operation.leadingAnchor,padding: .init(top: 0, left: 8, bottom: 16, right: 8))
        numberStack2.anchor(top: nil, leading: view.leadingAnchor, bottom: numberStack.topAnchor, trailing: operation.leadingAnchor,padding: .init(top: 0, left: 8, bottom: 16, right: 8))
        numberStack.anchor(top: nil, leading: view.leadingAnchor, bottom: numberStack4.topAnchor, trailing: operation.leadingAnchor,padding: .init(top: 0, left: 8, bottom: 16, right: 8))
        
        operation.anchor(top: nil, leading: nil, bottom: numberStack4.topAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 8, bottom: 16, right: 8))
        numberStack4.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 8, bottom: 16, right: 8))
        
        
        
    }
    
    func createButtons(isZero:Bool? = false,text:String,backgroundColor:UIColor,action:Selector) -> UIButton {
        let bt  = UIButton(title: text, titleColor: .white, font: .systemFont(ofSize: 25), backgroundColor: backgroundColor, target: self, action: action)
        let width = ( view.frame.width - 5 * 8) / 4
        //        let widthZero = (view.frame.width - 4 * 5 ) / 4 * 2  for zero constraint
        if isZero ?? false {
            //            bt.constrainHeight(constant: width)
            //            bt.constrainWidth(constant: widthZero)
        }else {
            bt.constrainHeight(constant: width)
            bt.constrainWidth(constant: width)
        }
        bt.layer.cornerRadius = width / 2
        bt.clipsToBounds = true
        return bt
    }
    
    
    
    @objc func handleClear()  {
        labelText.text = "0"
        firstValue = true
        subTotal = 0
    }
    
    
    
    @objc  func handleTyped (sender:UIButton) {
        let tt = labelText.text ?? "0"
        
        let number = sender.titleLabel?.text ?? "0"
        
        switch number {
        case "0":
            typeNumber(isFirst:number,number: tt, num: "0")
        case "1":
            typeNumber(isFirst:number,number: tt, num: "1")
        case "2":
            typeNumber(isFirst:number,number: tt, num: "2")
        case "3":
            typeNumber(isFirst:number,number: tt, num: "3")
        case "4":
            typeNumber(isFirst:number,number: tt, num: "4")
        case "5":
            typeNumber(isFirst:number,number: tt, num: "5")
        case "6":
            typeNumber(isFirst:number,number: tt, num: "6")
        case "7":
            typeNumber(isFirst:number,number: tt, num: "7")
        case "8":
            typeNumber(isFirst:number,number: tt, num: "8")
        case "9":
            typeNumber(isFirst:number,number: tt, num: "9")
        case ".":
            typeNumber(isFirst:number,number: tt, num: ".")
        default:
            typeNumber(isFirst:number,number: tt, num: "0")
        }
    }
    
    func typeNumber(isFirst:String? = "0",number:String,num:String)  {
        if  num == "0" {
            if firstValue {
                labelText.text = "0"
            } else {
                labelText.text = number + "0"
            }
            return
        }
        if firstValue  {
            labelText.text = isFirst
            firstValue = false
        } else {
            labelText.text = number + num
        }
    }
    
    @objc  func handlePlusMinus () {
         guard let text = labelText.text ,let val = text.toDouble() else {return}
        labelText.text = "-\(val)"
        subTotal = nil
        firstValue = true
    }
    
    @objc  func handlePercent () {
         guard let text = labelText.text ,let val = text.toDouble() else {return}
        subTotal = val / 100
        
        labelText.text = "\(subTotal!)"
        subTotal = nil
        firstValue = true
    }
    
    @objc func pressMultiply() {
        guard let text = labelText.text ,let val = text.toDouble() else {return}
        if let currentSubTotal = subTotal {
            subTotal = val * currentSubTotal
        } else {
            subTotal = val
        }
        lastOperator = operatorType.multiply
        firstValue = true
        labelText.text = "\(subTotal!)"
    }
    
    @objc func pressDivide() {
        guard let text = labelText.text ,let val = text.toDouble() else {return}
        if let currentSubTotal = subTotal {
            subTotal = currentSubTotal == 0 ? val / 1.0 : currentSubTotal /  val
        } else {
            subTotal = val
        }
        lastOperator = operatorType.divide
        firstValue = true
        labelText.text = "\(subTotal!)"
    }
    
    @objc func pressMinus() {
        guard let text = labelText.text ,let val = text.toDouble() else {return}
        if let currentSubTotal = subTotal {
            subTotal = val - currentSubTotal
        } else {
            subTotal = val
        }
        lastOperator = operatorType.subtract
        firstValue = true
        labelText.text = "\(subTotal!)"
    }
    
    @objc func pressPlus() {
        guard let text = labelText.text ,let val = text.toDouble() else {return}
        if let currentSubTotal = subTotal {
            subTotal = val + currentSubTotal
        } else {
            subTotal = val
        }
        lastOperator = operatorType.plus
        firstValue = true
        labelText.text = "\(subTotal!)"
    }
    
    @objc func handleEqual()  {
        var result: Double? = 0.0
        let total = subTotal ?? 0.0
        
        let last = lastOperator ?? .none
        guard let text = labelText.text ,let val = text.toDouble() else {return}
        
        let finalOperator = last
        switch(finalOperator) {
        case .plus : result = total + val
        case .subtract : result = total - val
        case .multiply : result = total * val
        case .divide : result = total / val
        case .none : result = val
        }
        
        
        labelText.text = "\(result!)"
        subTotal = nil
        firstValue = true
    }
}

