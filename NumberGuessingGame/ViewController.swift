//
//  ViewController.swift
//  NumberGuessingGame
//
//  Created by aytug on 4.04.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var numberStateImageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var guessStateImageView: UIImageView!
    @IBOutlet weak var tryButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet var starImageViewCollection: [UIImageView]!
    
    let maxTryCount = 5
    var currentTryCount = 0
    var targetNumber: Int?
    var result: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUIConfiguration()
        initGameConfiguration()
    }
    func initUIConfiguration() {
        restartButton.layer.cornerRadius = restartButton.bounds.height / 2
        tryButton.layer.cornerRadius = tryButton.bounds.height / 2
        saveButton.layer.cornerRadius = saveButton.bounds.height / 2
    }
    
    func initGameConfiguration() {
        // önceki oyunda eksilen yıldızlarını tekrar doldurur.
        for i in 0..<currentTryCount {
            let index = maxTryCount - i - 1
            starImageViewCollection[index].image = UIImage(named: "sariYildiz")
        }
        
        currentTryCount = 0
        targetNumber = nil
        result = false
        numberTextField.text = ""
        numberTextField.isEnabled = true
        numberTextField.becomeFirstResponder()
        guessTextField.text = ""
        restartButton.isHidden = true
        numberStateImageView.isHidden = true
        guessStateImageView.isHidden = true
        saveButton.isEnabled = true
        tryButton.isEnabled = false
        numberTextField.isSecureTextEntry = true
        resultLabel.text = ""
        
    }

    @IBAction func saveTapped(_ sender: UIButton) {
        
        if let number = Int(numberTextField.text!) {
            targetNumber = number
            tryButton.isEnabled = true
            numberTextField.isEnabled = false
            saveButton.isEnabled = false
            numberStateImageView.image = UIImage(named: "onay")
            guessTextField.becomeFirstResponder()
        } else {
            numberStateImageView.image = UIImage(named: "hata")
        }
        
        
        numberStateImageView.isHidden = false
    }
    @IBAction func tryTapped(_ sender: UIButton) {
        
        guard result != true || currentTryCount <= maxTryCount else { return }
        guessStateImageView.isHidden = false
        if let number = Int(guessTextField.text!) {
            currentTryCount += 1
            if number == targetNumber! {
                result = true
                resultLabel.text = "YOU WON!"
                restartButton.isHidden = false
                guessStateImageView.image = UIImage(named: "tamam")
            } else {
                guessTextField.text = ""
                let starCount = starImageViewCollection.count
                starImageViewCollection[starCount - currentTryCount].image = UIImage(named: "beyazYildiz")
                
                if number > targetNumber! {
                    guessStateImageView.image = UIImage(named: "asagi")
                } else {
                    guessStateImageView.image = UIImage(named: "yukari")
                }
            }
            if currentTryCount == maxTryCount && !result {
                resultLabel.text = "YOU LOSE!"
                restartButton.isHidden = false
            }
            
        } else {
            guessStateImageView.image = UIImage(named: "hata")
        }
        
    }

    @IBAction func restartTapped(_ sender: Any) {
        initGameConfiguration()
    }
    
}

