//
//  GallowsVC.swift
//  vkTestBurnashev
//
//  Created by T BURNASHEVA on 05.09.2024.
//

import UIKit

class GallowsVC: UIViewController {
    
    @IBOutlet weak var answerSymbol1: UIButton!
    @IBOutlet weak var answerSymbol2: UIButton!
    @IBOutlet weak var answerSymbol3: UIButton!
    @IBOutlet weak var answerSymbol4: UIButton!
    @IBOutlet weak var answerSymbol5: UIButton!
    @IBOutlet weak var answerSymbol6: UIButton!
    @IBOutlet weak var answerSymbol7: UIButton!
    @IBOutlet weak var answerSymbol8: UIButton!
    @IBOutlet weak var answerSymbol9: UIButton!
    @IBOutlet weak var imageError: UIImageView!
    
    @IBOutlet weak var symbolButton1: UIButton!
    @IBOutlet weak var symbolButton2: UIButton!
    @IBOutlet weak var symbolButton3: UIButton!
    @IBOutlet weak var symbolButton4: UIButton!
    @IBOutlet weak var symbolButton5: UIButton!
    @IBOutlet weak var symbolButton6: UIButton!
    @IBOutlet weak var symbolButton7: UIButton!
    @IBOutlet weak var symbolButton8: UIButton!
    @IBOutlet weak var symbolButton9: UIButton!
    @IBOutlet weak var symbolButton10: UIButton!
    @IBOutlet weak var symbolButton11: UIButton!
    @IBOutlet weak var symbolButton12: UIButton!
    @IBOutlet weak var symbolButton13: UIButton!
    @IBOutlet weak var symbolButton14: UIButton!
    @IBOutlet weak var symbolButton15: UIButton!
    @IBOutlet weak var symbolButton16: UIButton!
    @IBOutlet weak var symbolButton17: UIButton!
    @IBOutlet weak var symbolButton18: UIButton!
    @IBOutlet weak var symbolButton19: UIButton!
    @IBOutlet weak var symbolButton20: UIButton!
    @IBOutlet weak var symbolButton21: UIButton!
    @IBOutlet weak var symbolButton22: UIButton!
    @IBOutlet weak var symbolButton23: UIButton!
    @IBOutlet weak var symbolButton24: UIButton!
    @IBOutlet weak var symbolButton25: UIButton!
    @IBOutlet weak var symbolButton26: UIButton!
    @IBOutlet weak var symbolButton27: UIButton!
    @IBOutlet weak var symbolButton28: UIButton!
    @IBOutlet weak var symbolButton29: UIButton!
    @IBOutlet weak var symbolButton30: UIButton!
    @IBOutlet weak var symbolButton31: UIButton!
    @IBOutlet weak var symbolButton32: UIButton!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var line1: UIStackView!
    @IBOutlet weak var line2: UIStackView!
    @IBOutlet weak var line3: UIStackView!
    
    var answerArray: [Substring] = []
    
    var errorCount = 0
    var correctCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = NSLocalizedString("gallows", comment: "")
        startNewGame()
    
    }
    
    private func startNewGame() {
        
        let arrayWords = [
            "пирог",
            "сметана",
            "линейка",
            "стол",
            "стул",
            "экран",
            "ветер",
            "окно",
            "кошка",
            "кулек",
            "вышка",
            "рюкзак",
            "сумка",
            "портрет",
            "туя",
            "душ"]
        
        errorCount = 0
        correctCount = 0
        answerArray = arrayWords.randomElement()?.split(separator: "") ?? ["о","ш","и","б","к","а"]
        resetSymbolButtons()
        preparingAnswerField()
        setNumberLetterInResponse()
        setImageByErrorCount()
    }
    
    private func resetSymbolButtons() {
        
        symbolButton1.isEnabled = true
        symbolButton2.isEnabled = true
        symbolButton3.isEnabled = true
        symbolButton4.isEnabled = true
        symbolButton5.isEnabled = true
        symbolButton6.isEnabled = true
        symbolButton7.isEnabled = true
        symbolButton8.isEnabled = true
        symbolButton9.isEnabled = true
        symbolButton10.isEnabled = true
        symbolButton11.isEnabled = true
        symbolButton12.isEnabled = true
        symbolButton13.isEnabled = true
        symbolButton14.isEnabled = true
        symbolButton15.isEnabled = true
        symbolButton16.isEnabled = true
        symbolButton17.isEnabled = true
        symbolButton18.isEnabled = true
        symbolButton19.isEnabled = true
        symbolButton20.isEnabled = true
        symbolButton21.isEnabled = true
        symbolButton22.isEnabled = true
        symbolButton23.isEnabled = true
        symbolButton24.isEnabled = true
        symbolButton25.isEnabled = true
        symbolButton26.isEnabled = true
        symbolButton27.isEnabled = true
        symbolButton28.isEnabled = true
        symbolButton29.isEnabled = true
        symbolButton30.isEnabled = true
        symbolButton31.isEnabled = true
        symbolButton32.isEnabled = true
        
        symbolButton1.alpha = 1
        symbolButton2.alpha = 1
        symbolButton3.alpha = 1
        symbolButton4.alpha = 1
        symbolButton5.alpha = 1
        symbolButton6.alpha = 1
        symbolButton7.alpha = 1
        symbolButton8.alpha = 1
        symbolButton9.alpha = 1
        symbolButton10.alpha = 1
        symbolButton11.alpha = 1
        symbolButton12.alpha = 1
        symbolButton13.alpha = 1
        symbolButton14.alpha = 1
        symbolButton15.alpha = 1
        symbolButton16.alpha = 1
        symbolButton17.alpha = 1
        symbolButton18.alpha = 1
        symbolButton19.alpha = 1
        symbolButton20.alpha = 1
        symbolButton21.alpha = 1
        symbolButton22.alpha = 1
        symbolButton23.alpha = 1
        symbolButton24.alpha = 1
        symbolButton25.alpha = 1
        symbolButton26.alpha = 1
        symbolButton27.alpha = 1
        symbolButton28.alpha = 1
        symbolButton29.alpha = 1
        symbolButton30.alpha = 1
        symbolButton31.alpha = 1
        symbolButton32.alpha = 1
        
    }
    
    private func preparingAnswerField() {
        answerSymbol1.setTitle("_", for: .normal)
        answerSymbol2.setTitle("_", for: .normal)
        answerSymbol3.setTitle("_", for: .normal)
        answerSymbol4.setTitle("_", for: .normal)
        answerSymbol5.setTitle("_", for: .normal)
        answerSymbol6.setTitle("_", for: .normal)
        answerSymbol7.setTitle("_", for: .normal)
        answerSymbol8.setTitle("_", for: .normal)
        answerSymbol9.setTitle("_", for: .normal)
    }
    
    private func setNumberLetterInResponse() {
        
        let count = answerArray.count
        answerSymbol1.isHidden = !(count >= 1)
        answerSymbol2.isHidden = !(count >= 2)
        answerSymbol3.isHidden = !(count >= 3)
        answerSymbol4.isHidden = !(count >= 4)
        answerSymbol5.isHidden = !(count >= 5)
        answerSymbol6.isHidden = !(count >= 6)
        answerSymbol7.isHidden = !(count >= 7)
        answerSymbol8.isHidden = !(count >= 8)
        answerSymbol9.isHidden = !(count >= 9)
        
    }
    
    private func setImageByErrorCount() {
        
        if errorCount == 0 {
            imageError.image = UIImage(named: "hanged_0")
        } else if errorCount == 1 {
            imageError.image = UIImage(named: "hanged_1")
        } else if errorCount == 2 {
            imageError.image = UIImage(named: "hanged_2")
        } else if errorCount == 3 {
            imageError.image = UIImage(named: "hanged_3")
        } else if errorCount == 4 {
            imageError.image = UIImage(named: "hanged_4")
        } else if errorCount == 5 {
            imageError.image = UIImage(named: "hanged_5")
        } else if errorCount == 6 {
            imageError.image = UIImage(named: "hanged_6")
        }
        
    }
    
    private func checkingSymbol(symbol: String) -> Bool {
        var isRightSymbol = false
        for i in 0 ... answerArray.count - 1 {
            if (answerArray[i].lowercased() == symbol.lowercased()) {
                isRightSymbol = true
                correctCount += 1
                if (i == 0) {
                    answerSymbol1.setTitle(symbol.uppercased(), for: .normal)
                } else if (i == 1) {
                    answerSymbol2.setTitle(symbol.uppercased(), for: .normal)
                } else if (i == 2) {
                    answerSymbol3.setTitle(symbol.uppercased(), for: .normal)
                } else if (i == 3) {
                    answerSymbol4.setTitle(symbol.uppercased(), for: .normal)
                } else if (i == 4) {
                    answerSymbol5.setTitle(symbol.uppercased(), for: .normal)
                } else if (i == 5) {
                    answerSymbol6.setTitle(symbol.uppercased(), for: .normal)
                } else if (i == 6) {
                    answerSymbol7.setTitle(symbol.uppercased(), for: .normal)
                } else if (i == 7) {
                    answerSymbol8.setTitle(symbol.uppercased(), for: .normal)
                } else if (i == 8) {
                    answerSymbol9.setTitle(symbol.uppercased(), for: .normal)
                }
            }
        }
        
        if isRightSymbol && correctCount == answerArray.count {
            showWinDialog()
        } else if !isRightSymbol {
            errorCount += 1
            setImageByErrorCount()
            if (errorCount == 6) {
                showLoseDialog()
            }
        }
        
        return isRightSymbol
        
    }

    @IBAction func clickSymbol(button: UIButton) {
        
        button.isEnabled = false
        button.alpha = 0.3
        let isRightSymbol = checkingSymbol(symbol: button.titleLabel?.text ?? "")
        
    }
    
    @IBAction func clickBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func clickNewGame(_ sender: Any) {
        startNewGame()
    }
    
}

extension GallowsVC {
    
    private func showWinDialog() {
        
        let alert = UIAlertController(
            title: NSLocalizedString("gallows_dialog_win_title", comment: ""),
            message: NSLocalizedString("gallows_dialog_win_subtitle", comment: ""),
            preferredStyle: .alert)
         
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("gallows_dialog_exit", comment: ""),
            style: .default, handler: {_ in 
                self.dismiss(animated: true)
            }))
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("gallows_dialog_repeat", comment: ""),
            style: .cancel, handler: {_ in
                self.startNewGame()
            }))
         
        self.present(alert, animated: true)
        
    }
    
    private func showLoseDialog() {
        
        let alert = UIAlertController(
            title: NSLocalizedString("gallows_dialog_lose_title", comment: ""),
            message: NSLocalizedString("gallows_dialog_lose_subtitle", comment: ""),
            preferredStyle: .alert)
         
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("gallows_dialog_exit", comment: ""),
            style: .default, handler: {_ in
                self.dismiss(animated: true)
            }))
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("gallows_dialog_repeat", comment: ""),
            style: .cancel, handler: {_ in
                self.startNewGame()
            }))
         
        self.present(alert, animated: true)
        
    }
    
}
