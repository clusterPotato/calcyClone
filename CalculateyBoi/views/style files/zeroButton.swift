//
//  zeroButton.swift
//  CalculateyBoi
//
//  Created by Gavin Craft on 5/17/21.
//
import UIKit
class ZeroButton: UIButton{
    override func awakeFromNib() {
        super.awakeFromNib()
        self.makeRound()
        setup()
        setFontAppropriately()
    }
    func setup(){
        self.titleLabel?.textColor = UIColor(named: "numberColor")
        self.backgroundColor = UIColor(named: "numberButtonColor")
    }
}
