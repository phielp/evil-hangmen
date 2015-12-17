//
//  ViewController.swift
//  
//  Main View
//
//  Created by Philip Bouman on 01-12-15.
//  Copyright © 2015 Philip Bouman. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController {

    //IMAGES\\
    var animationImages: [UIImage?] = []
    var faultImages: [UIImage?] = []
    
    //SOUNDS\\
    var bladeSound : AVAudioPlayer?
    var chopSound : AVAudioPlayer?
    
    //OUTLETS\\
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var wordDisplay: UILabel!
    
    // letter button input. Handles a game turn with chosen letter
    @IBAction func alphabetButtons(sender: UIButton) {
        
        let (mode, _, _) = Settings().loadSettings()
        
        // evil mode
        if (mode == true) {
            let letter: String = sender.restorationIdentifier!
            GlobalVariables.letter = letter
            let (displayWord, correct) = EvilGameplay().playTurn()
            wordDisplay.text = displayWord
            
            sender.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
            sender.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
            sender.enabled = false
            
            // update image
            if correct == false {
                changeImage()
            }
            
        // good mode
        } else {
        
            let letter: String = sender.restorationIdentifier!
            let (displayWord, correct) = GoodGameplay().playTurn(letter)
            wordDisplay.text = displayWord
        
            sender.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
            sender.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
            sender.enabled = false
        
            // update image
            if correct == false {
                changeImage()
            }
        }
    }
    
    // view init
    override func viewDidLoad() {

        super.viewDidLoad()
        
        bladeSound = setupAudioPlayerWithFile("BladeDrag", type:"aif")
        chopSound = setupAudioPlayerWithFile("BladeChop", type:"aif")

        wordDisplay.text = GlobalVariables.displayWord
    }
    
    // Setup audioplayer and load files
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer?  {
        // setup path
        let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)

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