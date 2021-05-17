//
//  MainVC.swift
//  CalculateyBoi
//
//  Created by Gavin Craft on 5/17/21.
//

import UIKit
class MainVC: UIViewController, ContainerViewDelegate{
    var currentFunction: Function = .stillWorking
    @IBOutlet weak var backspace: UIButton!
    @IBOutlet weak var numberLabel: UILabel!
    var prevNum: Double?
    var currentNumber: String = ""
    weak var delegate: MainDelegate?
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        numberLabel.text = "0.0"
        guard let image = backspace.imageView else {return}
        image.tintColor = UIColor(named: "strangeButtonColor")
    }
    
    //MARK: - actions
    @IBAction func pressedBackSpace(_ sender: Any) {
        var stringArrayBoi = Array(currentNumber)
        if !(stringArrayBoi.count == 1){
            if(stringArrayBoi[stringArrayBoi.count-1] == "0"){
                stringArrayBoi.remove(at: stringArrayBoi.count-1)
                stringArrayBoi.remove(at: stringArrayBoi.count-1)
            }else{
                stringArrayBoi.remove(at: stringArrayBoi.count-1)
            }
        }else{
            stringArrayBoi[0] = "0"
        }
        currentNumber = ""
        for element in stringArrayBoi{
            currentNumber += String(element)
        }
        numberLabel.text = currentNumber
        if stringArrayBoi[stringArrayBoi.count-1] == "."{
            numberLabel.text? += "0"
        }
        delegate?.pressedBackspace(newVal: currentNumber)
    }
    
    //MARK: - inherited
    func updateNumberLabel(numberText: String) {
        self.currentNumber = numberText
        numberLabel.text = currentNumber
    }
    func pressedActionButton(_ action: Function) {
        self.currentFunction = action
        if let number = Double(currentNumber){
            prevNum = number
            currentNumber = "0.0"
            numberLabel.text = currentNumber
        }
        else{
            return
        }
    }
    func pressedEqual() {
        guard let number1 = prevNum else {return}
        guard let number2 = Double(currentNumber) else {return}
        switch currentFunction{
        case .ADD:
            self.numberLabel.text = String(number1+number2)
        case .MULTIPLY:
            self.numberLabel.text = String(number1*number2)
        case .SUBTRACT:
            self.numberLabel.text = String(number1-number2)
        case .DIVIDE:
            self.numberLabel.text = String(number1/number2)
        case .stillWorking:
            print("still working")
        }
        currentNumber = self.numberLabel.text ?? "0"
    }
    func pressedPositiveNegative() {
        var stringArrayBoi = Array(currentNumber)
        if stringArrayBoi[0] == "-"{
            //go positive
            stringArrayBoi.remove(at: 0)
        }
        else{
            stringArrayBoi.insert("-", at: 0)
        }
        currentNumber = ""
        for element in stringArrayBoi{
            currentNumber += String(element)
        }
        numberLabel.text = currentNumber
    }
    func pressedPercent() {
        var stringArrayBoi = Array(currentNumber)
        let index = stringArrayBoi.firstIndex(of: ".") ?? 0
        print(stringArrayBoi, index)
        if(index != 0){
            stringArrayBoi.remove(at: index)
            stringArrayBoi.insert(".", at: index-1)
            if stringArrayBoi[0] != "0"{
                stringArrayBoi.insert("0", at: 0)
            }
        }else{
            stringArrayBoi.insert(".", at: index)
            stringArrayBoi.remove(at: index+1)
            stringArrayBoi.insert("0", at: index+1)
            stringArrayBoi.insert("0", at: 0)
        }
        currentNumber = ""
        for element in stringArrayBoi{
            currentNumber += String(element)
        }
        numberLabel.text = currentNumber
    }
    //MARK: - nav
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "relationship_buttons"){
            guard let destination = segue.destination as? ContainerViewController else {return}
            destination.delegate = self
            delegate = destination
        }
    }
}
