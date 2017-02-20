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
    }
    @IBAction func buttonDidPress(sender : UIButton){
        playSounds()
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

}

