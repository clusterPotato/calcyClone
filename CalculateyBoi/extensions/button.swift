//
//  button.swift
//  CalculateyBoi
//
//  Created by Gavin Craft on 5/17/21.
//

import UIKit
extension UIButton{
    func makeRound(){
        self.layer.cornerRadius = 40
        self.layer.masksToBounds = true
    }
    func setFontAppropriately(){
        let font = UIFont(name: "Arial-BoldMT", size: 36)
        self.titleLabel?.font = font
        switch self{
        case is StrangerButton:
            self.setTitleColor(UIColor(named: "strangeTextColor"), for: .normal)
        default:
            self.setTitleColor(UIColor(named: "textColor"), for: .normal)
        }
    }
}
