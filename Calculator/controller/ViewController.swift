//
//  ViewController.swift
//  Calculator
//
//  Created by hosam on 1/8/20.
//  Copyright © 2020 hosam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let labelText = UILabel(text: "1546", font: .systemFont(ofSize: 25), textColor: .white, textAlignment: .right, numberOfLines: 0)
    
    lazy var buttonss:[[CalculatorButton]] = [
    [.ac,.plusMinus,.percent,.divide],
    [.seven,.eight,.nine,.multiply]
    ]
    
    lazy var acButton = createButtons(text: "AC", backgroundColor: .gray, action: #selector(handleClear))
     lazy var plusMinsButton = createButtons(text: "+-", backgroundColor: .gray, action: #selector(handlePlusMinus))
     lazy var percentButton = createButtons(text: "%", backgroundColor: .gray, action: #selector(handlePercent))
    
    lazy var divideButton = createButtons(text: "/", backgroundColor: #colorLiteral(red: 0.9752290845, green: 0.641053319, blue: 0.02241232432, alpha: 1), action: #selector(handleClear))
    lazy var multiButton = createButtons(text: "*", backgroundColor: #colorLiteral(red: 0.9752290845, green: 0.641053319, blue: 0.02241232432, alpha: 1), action: #selector(handlePlusMinus))
    lazy var minusButton = createButtons(text: "-", backgroundColor: #colorLiteral(red: 0.9752290845, green: 0.641053319, blue: 0.02241232432, alpha: 1), action: #selector(handlePercent))
    lazy var plusButton = createButtons(text: "+", backgroundColor: #colorLiteral(red: 0.9752290845, green: 0.641053319, blue: 0.02241232432, alpha: 1), action: #selector(handleClear))
//    lazy var equalButton = createButtons(text: "=", backgroundColor: #colorLiteral(red: 0.9752290845, green: 0.641053319, blue: 0.02241232432, alpha: 1), action: #selector(handlePlusMinus))
    lazy var dotButton = createButtons(isZero:true,text: ".", backgroundColor: .gray, action: #selector(handlePercent))
//     lazy var dotButton = createButtons(text: ".", backgroundColor: .gray, action: #selector(handlePercent))
    lazy var zeroButton = createButtons(isZero:true,text: "0", backgroundColor: .gray, action: #selector(handlePercent))
    lazy var equalButton = createButtons(isZero:true,text: "=", backgroundColor: .gray, action: #selector(handlePercent))
//    lazy var zerozButton = UIButton(title: "0", titleColor: .white, font: .systemFont(ofSize: 25), backgroundColor: .gray, target: self, action: #selector(handlePercent))
    lazy var numberButtons:[UIButton] = {
       var bt = [UIButton]()
        for x in 1...9 {
          bt.append(createButtons(text: "\(x)", backgroundColor: .lightGray, action: #selector(handleTyped)))
        }
        return bt
    }()
//    lazy var numberStack:UIStackView = {
//
//        numberButtons.forEach({ (v) in
//          return  ss = getStack(views: v, spacing: 8, distribution: .fillEqually, axis: .horizontal)
//        })
//
//
//    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }

//    func setupViews()  {
//
//    }
    func setupViews()  {
//        zerozButton.layer.cornerRadius = 32
//        zerozButton.clipsToBounds = true
        view.backgroundColor = .black
        let subOperation = view.getStack(views: acButton,plusMinsButton,percentButton, spacing: 8, distribution: .fillEqually, axis: .horizontal)
        let operation = view.getStack(views: divideButton,multiButton,minusButton,plusButton, spacing: 8, distribution: .fillEqually, axis: .vertical)

        let numberStack = view.getStack(views: numberButtons[0],numberButtons[1],numberButtons[2], spacing: 8, distribution: .fillEqually, axis: .horizontal)
        let numberStack2 = view.getStack(views: numberButtons[3],numberButtons[4],numberButtons[5], spacing: 8, distribution: .fillEqually, axis: .horizontal)
        let numberStack3 = view.getStack(views: numberButtons[6],numberButtons[7],numberButtons[8], spacing: 8, distribution: .fillEqually, axis: .horizontal)

         let numberStack4 = view.getStack(views: zeroButton,dotButton,equalButton, spacing: 8, distribution: .fill, axis: .horizontal)

        view.addSubViews(views: labelText,subOperation,operation,numberStack,numberStack2,numberStack3,numberStack4)
        labelText.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 60, left: 0, bottom: 0, right: 16))
        subOperation.anchor(top: labelText.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 16, left: 8, bottom: 0, right: 0))
        operation.anchor(top: labelText.bottomAnchor, leading: subOperation.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor,padding: .init(top: 16, left: 8, bottom: 0, right: 8))
         numberStack3.anchor(top: subOperation.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: operation.leadingAnchor,padding: .init(top: 16, left: 8, bottom: 8, right: 8))
        numberStack2.anchor(top: numberStack3.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: operation.leadingAnchor,padding: .init(top: 16, left: 8, bottom: 8, right: 8))
        numberStack.anchor(top: numberStack2.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: operation.leadingAnchor,padding: .init(top: 16, left: 8, bottom: 0, right: 8))
        numberStack4.anchor(top: numberStack.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: operation.leadingAnchor,padding: .init(top: 16, left: 8, bottom: 8, right: 8))

//        numberButtons.forEach { (v) in
//            view.addSubview(v)
//            v.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
//        }
//        view.addSubViews(views: numberButtons)

//        numberButtons
//        let ss = getStack(views: numberButtons, spacing: 8, distribution: .fillEqually, axis: <#T##NSLayoutConstraint.Axis#>)
//
//       view.stack(numberButtons,UIView())

    }

    func createButtons(isZero:Bool? = false,text:String,backgroundColor:UIColor,action:Selector) -> UIButton {
        let bt  = UIButton(title: text, titleColor: .white, font: .systemFont(ofSize: 16), backgroundColor: backgroundColor, target: self, action: action)
        let width = ( view.frame.width - 5 * 8) / 4
//        let height = view.frame.height / 2
        let widthZero = (view.frame.width - 4 * 5 ) / 4 * 2
        if isZero ?? false {
            bt.constrainHeight(constant: widthZero)
            bt.constrainWidth(constant: widthZero)
        }else {
            bt.constrainHeight(constant: width)
            bt.constrainWidth(constant: width)
        }
       
        bt.layer.cornerRadius = width / 2
        bt.clipsToBounds = true
        return bt
    }
    
    
    
   @objc func handleClear()  {
        print(951)
    }
    
  @objc  func handleTyped () {
        print(956)
    }
    
    @objc  func handlePlusMinus () {
        print(956)
    }
    
    @objc  func handlePercent () {
        print(956)
    }
}

