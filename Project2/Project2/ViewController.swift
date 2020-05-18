//
//  ViewController.swift
//  Project2
//
//  Created by Juan Camilo Bages Prada on 5/16/20.
//  Copyright © 2020 Juan Camilo Bages Prada. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    let MAX_QUESTIONS = 10

    var countries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    var score = 0
    var correctAnswer = 0
    var currentQuestion = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1

        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor

        restartGame()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        currentQuestion += 1
        title = "\(countries[correctAnswer].uppercased()) - Score: \(score)"
    }
    
    func restartGame(action: UIAlertAction! = nil) {
        currentQuestion = 0;
        score = 0
        askQuestion()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title = "Question \(currentQuestion)/\(MAX_QUESTIONS): "

        if sender.tag == correctAnswer {
            title += "Correct, but don't get too excited. Anyone can have some luck."
            score += 1
        } else {
            let selectedCountry = countries[sender.tag].uppercased()
            title += "Wrong, that's the flag of \(selectedCountry). Shame on you!"
            score -= 1
        }
        
        let ac: UIAlertController
        if currentQuestion < 10 {
            let message = "Your score is \(score)"
            ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        } else {
            let message = "Game over, final score: \(score)"
            ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Start Over", style: .default, handler: restartGame))
        }

        present(ac, animated: true)
    }
}

