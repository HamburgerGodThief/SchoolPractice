//
//  SelectionView.swift
//  DelegatePractice
//
//  Created by Hamburger on 2020/1/13.
//  Copyright © 2020 Hamburger. All rights reserved.
//

import Foundation
import UIKit

protocol SelectionViewDelegate: AnyObject {
    
}

protocol SelectionViewDataSource: AnyObject {
    
    func numberOfOption(_ selectionView: SelectionView) -> Int
    
    func textOnButton(_ selectionView: SelectionView, buttonForNumber: Int) -> String
    
    func colorOfUnderLine(_ selectionView: SelectionView) -> UIColor?
    
    func colorOfTextOnButton(_ selectionView: SelectionView, buttonForNumber: Int) -> UIColor?
    
    func fontOfTextOnButton(_ selectionView: SelectionView, buttonForNumber: Int) -> UIFont?
}

class SelectionView: UIView {
    
    weak var delegate: SelectionViewDelegate? {
        
        didSet {
            
        }
        
    }
    
    weak var dataSource: SelectionViewDataSource? {
        
        didSet {
            setButton()
            setIndicatorLine()
        }
        
    }
    
    var arrayButton = [UIButton]()
    
    let colorView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .black
        return stack
    }()
    
    let indicatorView: UIView = {
        let view = UIView()
        return view
    }()
    
    func setColorView() {
        colorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(colorView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: colorView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 50),
            NSLayoutConstraint(item: colorView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: colorView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: colorView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        ])
    }
    
    func setStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.spacing = 0
        addSubview(stackView)
        //stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: colorView, attribute: .top, multiplier: 1, constant: -5),
            NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: stackView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        ])
    }
    
    func setButton() {
        guard let numberOfButton = dataSource?.numberOfOption(self) else { return }
        for number in 0...numberOfButton - 1 {
            let optionButton: UIButton = {
                let btn = UIButton()
                btn.setTitle(dataSource?.textOnButton(self, buttonForNumber: number), for: .normal)
                btn.setTitleColor(dataSource?.colorOfTextOnButton(self, buttonForNumber: number), for: .normal)
                btn.isEnabled = true
                btn.backgroundColor = .black
                btn.titleLabel?.font = dataSource?.fontOfTextOnButton(self, buttonForNumber: number)
                return btn
            }()
            arrayButton.append(optionButton)
            stackView.addArrangedSubview(optionButton)
        }
    }
    
    func setIndicatorLine() {
        indicatorView.backgroundColor = dataSource?.colorOfUnderLine(self)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.addSubview(indicatorView)
        
        indicatorView.frame.origin.x = 0
        indicatorView.frame.origin.y = colorView.frame.origin.y - 5
        indicatorView.frame.size.width = UIScreen.main.bounds.width / CGFloat(arrayButton.count)
        indicatorView.frame.size.height = 5
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setColorView()
        setStackView()
        setButton()
        self.backgroundColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
