//
//  ViewController.swift
//  Calculator
//
//  Created by Seda Kirakosyan on 09.06.25.
//

import UIKit

class ViewController: UIViewController {
    
    enum ButtonType {
        case digit
        case operatorSymbol
        case equal
        case clear
    }

    func color(for type: ButtonType) -> UIColor {
        switch type {
        case .digit:
            return UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        case .operatorSymbol, .equal:
            return UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 1)
        case .clear:
            return UIColor(red: 212/255, green: 212/255, blue: 210/255, alpha: 1)
        }
    }
    func formatResult(_ result: Double) -> String {
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(result))
        } else {
            return String(result)
        }
    }
    var label_text = ""
    var expression: String = ""
    let label = UILabel()
    func calculate() -> String {
        var separator = ""
        if expression.contains("+") {
            separator = "+"
        } else if expression.contains("-") {
            separator = "-"
        } else if expression.contains("×") {
            separator = "×"
        } else if expression.contains("÷") {
            separator = "÷"
        }
        let elems = expression.split(separator: separator)
        var result: String = ""
        if elems.count == 2 {
            if let first = Double(elems[0]), let second = Double(elems[1]) {
                switch separator {
                case "+":
                    result = formatResult(first + second)
                case "-":
                    result = formatResult(first - second)
                case "×":
                    result = formatResult(first * second)
                case "÷":
                    if (second == 0) {
                        return "Not defined"
                    }
                    result = formatResult(first / second)
                default:
                    return "Error1"
                }
            }
        }
        self.expression = result
        print("Expression before return: \(self.expression)\nReturn: \(result)")
        return result
    }
    func createBtn(name: String, color: UIColor) -> UIButton {
        var config = UIButton.Configuration.filled()
        config.title = name
        config.baseBackgroundColor = color
        config.baseForegroundColor = config.baseBackgroundColor == UIColor(red: 212/255, green: 212/255, blue: 210/255, alpha: 1) ? .black : .white
        config.cornerStyle = .medium
        config.titleAlignment = .center
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attr in
            var attr = attr
            attr.font = UIFont.boldSystemFont(ofSize: 24)
            return attr
        }

        let button = UIButton(configuration: config, primaryAction: UIAction(handler: { _ in
            print("Expression: \(self.expression)")
            if (name == "=") {
                self.label_text = ""
                self.label.text = self.calculate()
            } else if (name == "Clear") {
                self.label_text = ""
                self.label.text = self.label_text
                self.expression = ""
            } else if (name == "+" || name == "-" || name == "×" || name == "÷") {
                self.expression += name
                self.label_text = ""
            } else {
                self.label_text += name
                self.expression += name
                print("Tapped: \(name)")
                self.label.text = self.label_text
            }
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let btnClear = createBtn(name: "Clear", color: color(for: .clear))
        let btnAdd   = createBtn(name: "+",     color: color(for: .operatorSymbol))
        let btnSub   = createBtn(name: "−",     color: color(for: .operatorSymbol))
        let btnMul   = createBtn(name: "×",     color: color(for: .operatorSymbol))
        let btnDiv   = createBtn(name: "÷",     color: color(for: .operatorSymbol))
        let btnPoint = createBtn(name: ".",     color: color(for: .digit))
        let btnEqual = createBtn(name: "=",     color: color(for: .equal))

        let btn0 = createBtn(name: "0", color: color(for: .digit))
        let btn1 = createBtn(name: "1", color: color(for: .digit))
        let btn2 = createBtn(name: "2", color: color(for: .digit))
        let btn3 = createBtn(name: "3", color: color(for: .digit))
        let btn4 = createBtn(name: "4", color: color(for: .digit))
        let btn5 = createBtn(name: "5", color: color(for: .digit))
        let btn6 = createBtn(name: "6", color: color(for: .digit))
        let btn7 = createBtn(name: "7", color: color(for: .digit))
        let btn8 = createBtn(name: "8", color: color(for: .digit))
        let btn9 = createBtn(name: "9", color: color(for: .digit))
        
        
        let rowStack1 = UIStackView(arrangedSubviews: [btnPoint, btn0, btnEqual, btnAdd])
        rowStack1.spacing = 8
        
        let rowStack2 = UIStackView(arrangedSubviews: [btn1, btn2, btn3, btnSub])
        rowStack2.spacing = 8
        
        let rowStack3 = UIStackView(arrangedSubviews: [btn4, btn5, btn6, btnMul])
        rowStack3.spacing = 8
        
        let rowStack4 = UIStackView(arrangedSubviews: [btn7, btn8, btn9, btnDiv])
        rowStack4.spacing = 8
        let rowStack5 = UIStackView(arrangedSubviews: [btnClear])
        
        
       
        label.textColor = .white
        label.backgroundColor = .black
        label.text = label_text
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        label.heightAnchor.constraint(equalToConstant: 80).isActive = true
        let rowStack6 = UIStackView(arrangedSubviews: [label])
        let mainStack = UIStackView(arrangedSubviews: [rowStack6, rowStack5, rowStack4, rowStack3, rowStack2, rowStack1])
        mainStack.axis = .vertical
        mainStack.spacing = 12
        mainStack.distribution = .fillEqually
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            mainStack.heightAnchor.constraint(equalToConstant: 3 * 140 + 3 * 12) // 3 rows * height + 2 spacings
        ])

        
        
    }
    
    
    
}

