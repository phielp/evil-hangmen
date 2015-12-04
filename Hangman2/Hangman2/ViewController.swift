//
//  ViewController.swift
//  Hangman2
//
//  Created by Philip Bouman on 01-12-15.
//  Copyright © 2015 Philip Bouman. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController {
    
    var animationImages: [UIImage?] = []
    var faultImages: [UIImage?] = []
    
    var bladeSound : AVAudioPlayer?
    var chopSound : AVAudioPlayer?
    
    
    @IBOutlet weak var letterInput: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    // test evil gameplay (EW)
    @IBAction func evilGamePlay(sender: AnyObject) {
        EvilGameplay().testEvil()
    }
    
    // check evil letter (EL)
    @IBAction func checkLetter(sender: AnyObject) {
        let input = letterInput.text!
        GlobalVariables.letter = input.uppercaseString
        EvilGameplay().countOccurences()
    }
    
    
    // test animation button (PIC)
    @IBAction func startAnimation(sender: AnyObject) {
        changeImage()
        GlobalVariables.numberOfTurns = GlobalVariables.numberOfTurns - 1
    }
    
    // generate random word good gameplay (GW)
    @IBAction func randomWordButton(sender: AnyObject) {
        GlobalVariables.word = GoodGameplay().pickRandomWord()
        GoodGameplay().createDisplayWord(GlobalVariables.word)
    }
    
    // verify user keyboard input (GL)
    @IBAction func verifyLetterButton(sender: AnyObject) {
        let input = letterInput.text!
        GlobalVariables.letter = input.uppercaseString
        GoodGameplay().playTurn(GlobalVariables.letter, word: GlobalVariables.word)
        letterInput.text = ""
    }
    
    // letter button input
    @IBAction func alphabetButtons(sender: UIButton) {
        let value: String = sender.restorationIdentifier!
        GlobalVariables.letter = value
        GoodGameplay().playTurn(GlobalVariables.letter, word: GlobalVariables.word)
        sender.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        sender.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        sender.enabled = false
    }
    
    // view init
    override func viewDidLoad() {

        super.viewDidLoad()
        
        bladeSound = setupAudioPlayerWithFile("BladeDrag", type:"aif")
        chopSound = setupAudioPlayerWithFile("BladeChop", type:"aif")
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Setup audioplayer and load files
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer?  {
        // setup path
        let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
//        print("\(path)")
        let url = NSURL.fileURLWithPath(path!)
        
        var audioPlayer:AVAudioPlayer?
        
        // setup player
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
        } catch {
            print("Player not available")
        }
        
        audioPlayer?.prepareToPlay()
        return audioPlayer
    }
    
    // preload lose animation
    func prepareAnimation() {
        imageView.animationImages = [
            UIImage(named: "Blade10.jpg")!,
            UIImage(named: "Blade9.jpg")!,
            UIImage(named: "Blade8.jpg")!,
            UIImage(named: "Blade7.jpg")!,
            UIImage(named: "Blade6.jpg")!,
            UIImage(named: "Blade5.jpg")!,
            UIImage(named: "Blade4.jpg")!,
            UIImage(named: "Blade3.jpg")!,
            UIImage(named: "Blade2.jpg")!,
            UIImage(named: "Blade1.jpg")!,
            UIImage(named: "Blade0.jpg")!,
            UIImage(named: "Blade-3.jpg")!,
            UIImage(named: "Blade-2.jpg")!,
            UIImage(named: "Blade-1.jpg")!,
            UIImage(named: "Blade-0.jpg")!,
        ]
    }
    
    // lose Animation
    func startAnimation(){
        chopSound?.prepareToPlay()
        imageView.animationDuration = 1.3
        imageView.animationRepeatCount = 1
        imageView.startAnimating()
        chopSound!.play()
    }
    
    // update Images based on number of mistakes
    func changeImage() {
        bladeSound?.prepareToPlay()
        switch GlobalVariables.numberOfTurns {
            case 10: imageView.image = UIImage(named: "Blade1.jpg"); bladeSound!.play()
            case 9: imageView.image = UIImage(named: "Blade2.jpg"); bladeSound!.play()
            case 8: imageView.image = UIImage(named: "Blade3.jpg"); bladeSound!.play()
            case 7: imageView.image = UIImage(named: "Blade4.jpg"); bladeSound!.play()
            case 6: imageView.image = UIImage(named: "Blade5.jpg"); bladeSound!.play()
            case 5: imageView.image = UIImage(named: "Blade6.jpg"); bladeSound!.play()
            case 4: imageView.image = UIImage(named: "Blade7.jpg"); bladeSound!.play()
            case 3: imageView.image = UIImage(named: "Blade8.jpg"); bladeSound!.play()
            case 2: imageView.image = UIImage(named: "Blade9.jpg"); bladeSound!.play()
            case 1: prepareAnimation(); imageView.image = UIImage(named: "Blade-0.jpg"); bladeSound!.play(); startAnimation()
            case 0: GlobalVariables.numberOfTurns = 11  // reset
            default: imageView.image = UIImage(named: "Blade0.jpg")
        }
    }
}

