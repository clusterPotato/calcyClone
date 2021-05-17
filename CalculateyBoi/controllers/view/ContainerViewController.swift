//
//  ContainerViewController.swift
//  CalculateyBoi
//
//  Created by Gavin Craft on 5/17/21.
//

import UIKit
protocol ContainerViewDelegate:AnyObject {
    func updateNumberLabel(numberText: String)
    func pressedActionButton(_ action: Function)
    func pressedEqual()
    func pressedPercent()
    func pressedPositiveNegative()
}
protocol MainDelegate: AnyObject{
    func pressedBackspace(newVal: String)
}
class ContainerViewController: UIViewController, MainDelegate{
    func pressedBackspace(newVal: String) {
        currentNumber = newVal
    }
    
    weak var delegate: ContainerViewDelegate?
    var currentNumber = ""
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        guard let titleLabel = sender.titleLabel else {self.showToast(message: "Cannot find button text");return}
        if !(titleLabel.text == "."){
            guard let text = titleLabel.text else {return}
            currentNumber += text
            let numberOfString = Double(currentNumber)
            if let _ = numberOfString{
                print(currentNumber)
                delegate?.updateNumberLabel(numberText: currentNumber)
            }
        }
        else{
            guard let text = titleLabel.text else {return}
            currentNumber += text
            delegate?.updateNumberLabel(numberText: currentNumber)
        }
    }
    @IBAction func clearButtonPressed(_ sender: Any) {
        currentNumber = ""
        delegate?.updateNumberLabel(numberText: "0.0")
    }
    @IBAction func pressedFunctionButton(_ sender: UIButton) {
        guard let titleLabel = sender.titleLabel else {self.showToast(message: "Cannot find button text");return}
        switch titleLabel.text{
        case "÷":
            delegate?.pressedActionButton(.DIVIDE)
        case "*":
            delegate?.pressedActionButton(.MULTIPLY)
        case "+":
            delegate?.pressedActionButton(.ADD)
        case "-":
            delegate?.pressedActionButton(.SUBTRACT)
        case "=":
            delegate?.pressedEqual()
        case "%":
            delegate?.pressedPercent()
        default:
            self.showToast(message: "Invalid button pressed")
        }
        currentNumber = ""
    }
    @IBAction func pressedPositiveNeg(_ sender: Any) {
        self.delegate?.pressedPositiveNegative()
    }
}
