//
//  ViewController.swift
//  Calculator
//
//  Created by Эля Корельская on 28.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    var stillTyping = false
    var dotIsPlased = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign: String = ""
    
    var currentInput: Double {
        get {
            return Double(resultLabel.text!)!
        }
        
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0" {
                resultLabel.text = "\(valueArray[0])"
            } else {
                resultLabel.text = "\(newValue)"
            }
            stillTyping = false
        }
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        let number = sender.currentTitle!
        
        if stillTyping {
            if (resultLabel.text?.count)! < 10 {
                resultLabel.text = resultLabel.text! + number
            }
        } else {
            resultLabel.text = number
            stillTyping = true
        }
    }
    
    
    @IBAction func twoOperandPressed(_ sender: UIButton) {
        ///нажимаем на кнопку действий
        operationSign = sender.currentTitle!
        firstOperand = currentInput
        stillTyping = false
        dotIsPlased = false
    }
    func operateWithOperands (operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = false
    }
    @IBAction func equalitySignPressed(_ sender: UIButton) {
        if stillTyping {
            secondOperand = currentInput
        }
        dotIsPlased = false
        
        switch operationSign {
        case "+":
            operateWithOperands{$0 + $1}
        case "-":
            operateWithOperands{$0 - $1}
        case "✕":
            operateWithOperands{$0 * $1}
        case "÷":
            operateWithOperands{$0 / $1}
        default: break
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        resultLabel.text = "0"
        stillTyping = false
        dotIsPlased = false
        operationSign = ""
    }
    
    @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }
    @IBAction func squareButtonPressed(_ sender: UIButton) {
        if currentInput > 0 {
            currentInput = sqrt(currentInput)
        } else {
            currentInput = 0
        }
    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        if stillTyping && !dotIsPlased {
            resultLabel.text = resultLabel.text! + "."
            dotIsPlased = true
            
        } else if !stillTyping && !dotIsPlased {
            resultLabel.text = "0."
        }
    }
    @IBAction func persentageButtonPressed(_ sender: UIButton) {

        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
        }
    }
    
    
    
    
    
}

