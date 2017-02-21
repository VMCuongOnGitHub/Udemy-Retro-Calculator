//
//  ViewController.swift
//  Udemy-Retro Calculator
//
//  Created by Cuong on 2/14/17.
//  Copyright © 2017 Cuong. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var numberLabel: UILabel!
    
    enum _operation : String {
        case divide = "/"
        case multiply = "*"
        case subtract = "-"
        case add = "+"
        case empty = "empty"
    }
    
    var currentOperation = _operation.empty
    var runningNumber = ""
    var leftValue = ""
    var rightValue = ""
    var result = ""
    
    var buttonAudio : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create a path for the audio file
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        print("this is \(path)")
        // Create an URL because the path above is just returning String, we need to convert it in to url so IOS can read it
        if path != nil {
            let pathURL = URL.init(fileURLWithPath: path!)
            // Sometime when we download music from the internet to play it, if it's not there or the internet connection is fail, you app will crash so we have to use a way to handle this error
            do {
                // Get the button ready to play by finding it path and setting it in the ready mode
                try buttonAudio = AVAudioPlayer.init(contentsOf: pathURL)
                buttonAudio.prepareToPlay()
            } catch let error as NSError {
                // If it fail, it will do this
                print(error.debugDescription)
            }
        }
        
        numberLabel.text = "0"
    }
    @IBAction func buttonDidPress(sender : UIButton){
        playSounds()
        
        runningNumber += "\(sender.tag)"
        numberLabel.text = runningNumber
    }
    func playSounds(){
        // Handle errors
        if buttonAudio != nil {
            // Stop button when its playing
            if buttonAudio.isPlaying == true {
                buttonAudio.stop()
            }
            buttonAudio.play()
        }else{
            print("error")
        }
    }
    func processOperator(operation : _operation) {
        playSounds()
        
        if currentOperation != _operation.empty {
            if runningNumber != ""{
                rightValue = runningNumber
                runningNumber = ""
                
                if currentOperation == _operation.multiply{
                    result = "\(Double(leftValue)! * Double(rightValue)!)"
                }else if currentOperation == _operation.divide {
                    result = "\(Double(leftValue)! / Double(rightValue)!)"
                }else if currentOperation == _operation.subtract {
                    result = "\(Double(leftValue)! - Double(rightValue)!)"
                }else if currentOperation == _operation.add {
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                }
                leftValue = result
                numberLabel.text = result
            }
            
            currentOperation = operation
        } else {
            leftValue = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
    @IBAction func equalButtonPressed(_ sender: Any) {
        processOperator(operation: currentOperation)
    }

    @IBAction func divideButtonPressed(_ sender: Any) {
        processOperator(operation: .divide)
    }
    
    @IBAction func multiplyButtonPressed(_ sender: Any) {
        processOperator(operation: .multiply)
    }

    @IBAction func minusButtonPressed(_ sender: Any) {
        processOperator(operation: .subtract)
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        processOperator(operation: .add)
    }
    

}

