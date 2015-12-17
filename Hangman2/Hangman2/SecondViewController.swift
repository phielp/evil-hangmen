//
//  SecondViewController.swift
//  
//  Settings View
//
//  Created by Philip Bouman on 01-12-15.
//  Copyright © 2015 Philip Bouman. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var mode: Bool = true
    var wordLength: Int = 1
    var numberOfGuesses: Int = 1
    
    //OUTLETS\\
    @IBOutlet weak var Slider1: UISlider!
    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var Slider2: UISlider!
    @IBOutlet weak var Label2: UILabel!
    @IBOutlet weak var Switch: UISwitch!
    @IBOutlet weak var Label3: UILabel!
    
    // Start a new game
    @IBAction func NewGame(sender: AnyObject) {
        
        if Switch.on == true {
            EvilGameplay().initPlay()
            GamePlay().createDisplayWord()
        } else {
            GoodGameplay().initPlay()
        }
    }
    
    // WordLength Slider
    @IBAction func Slider1Moved(sender: UISlider) {
        let interval = 1
        let step = Int(sender.value / Float(interval) ) * interval
        sender.value = Float(step)
        wordLength = Int(Slider1.value)
        Label1.text = "\(wordLength)"
        Settings().wordLength(wordLength)
    }
    
    // Number of turns Slider
    @IBAction func Slider2Moved(sender: UISlider) {
        let interval = 1
        let step = Int(sender.value / Float(interval) ) * interval
        sender.value = Float(step)
        numberOfGuesses = Int(Slider2.value)
        Label2.text = "\(numberOfGuesses)"
        Settings().numberOfGuesses(numberOfGuesses)
    }
    
    // Evil or good mode switch
    @IBAction func Switch(sender: AnyObject) {
        
        if Switch.on == true {
            Label3.text = "Evil"
            mode = true
            Settings().mode(mode)
        } else {
            Label3.text = "Good"
            mode = false
            Settings().mode(mode)
        }
    }
    
    // load view
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSettings()
    }
    
    // load in current settings
    func loadSettings() {
        (mode, wordLength, numberOfGuesses) = Settings().loadSettings()
        Label1.text = "\(wordLength)"
        Slider1.value = Float(wordLength)
        Label2.text = "\(numberOfGuesses)"
        Slider2.value = Float(numberOfGuesses)
        if mode == true {
            Label3.text = "Evil"
            Switch.setOn(true, animated: true)
        } else {
            Label3.text = "Good"
            Switch.setOn(false, animated: true)
        }
    }
}