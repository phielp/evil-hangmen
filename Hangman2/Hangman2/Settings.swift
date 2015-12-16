//
//  Settings.swift
//  Grammar Guillotine
//
//  Created by Philip Bouman on 11-12-15.
//  Copyright © 2015 Philip Bouman. All rights reserved.
//

import UIKit

class Settings {
    
    // set evil or good gameplay
    func mode(mode: Bool) {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(mode, forKey: "gamePlay")
        defaults.synchronize()
    }
    
    // set length of word
    func wordLength(length: Int) {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(length, forKey: "wordLength")
        defaults.synchronize()
    }
    
    // set number of guesses
    func numberOfGuesses(length: Int) {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(length, forKey: "numberOfGuesses")
        defaults.synchronize()
    }
    
    // load settings
    func loadSettings() -> (mode: Bool, wordLength: Int, numberOfGuesses: Int) {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let mode = defaults.valueForKey("gamePlay") as? Bool
        let wordLength = defaults.valueForKey("wordLength") as? Int
        let numberOfGuesses = defaults.valueForKey("numberOfGuesses") as? Int
        
        if (mode != nil && wordLength != nil && numberOfGuesses != nil) {
            return (mode: mode!, wordLength: wordLength! - 1, numberOfGuesses: numberOfGuesses! - 1)
        } else {
            return (true, 1, 1)
        }
    }
}
