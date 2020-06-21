import UIKit

class ViewController: UIViewController {
    
    var calculatorLogic = CalculatorLogic()
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var finishedInput: Bool = true
    private var buttonStatus: UIButton?
    
    var displayValue: Double{
        get {
            guard let number = Double(Double(displayLabel.text!)!.removeZerosFromEnd()) else { fatalError("cant change text to double") }
            return number
        }
        set {
            let checkInt = floor(newValue) == newValue
            if checkInt { return displayLabel.text = String(format: "%0.f" ,newValue) }
            else { return displayLabel.text = String(newValue) }
        }
    }
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        finishedInput = true
        buttonsLogic(status: true)
        
        if let calcButton = sender.currentTitle {
            calculatorLogic.setNumber(displayValue)
            if let calculationIsDouble = calculatorLogic.calcButtonPressed(sender: calcButton) {
                displayValue = calculationIsDouble
            }
        }
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        if let numValue = sender.currentTitle {
            if finishedInput {
                if numValue == "." { return }
                displayLabel.text = numValue
                finishedInput = false
            } else {
                if numValue == "." {
                    sender.isEnabled = false
                    buttonStatus = sender
                }
                displayLabel.text! += numValue
            }
        }
    }
    
    func buttonsLogic(status: Bool) {
        if let buttonID = buttonStatus {
            buttonID.isEnabled = status
        }
    }
}
//ze stackoverflow
extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}
