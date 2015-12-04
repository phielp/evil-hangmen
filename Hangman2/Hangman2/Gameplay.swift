//
//  Gameplay.swift
//  Hangman2
//
//  Created by Philip Bouman on 01-12-15.
//  Copyright © 2015 Philip Bouman. All rights reserved.
//

import UIKit

protocol Gameplay {
    
//    var letter : String { get }
//    var word : NSString { get set }
//    var displayWord : String { get set }
    
    var wordList : NSArray { get }
    
    func printListContents()
    
    func pickRandomWord() -> String
    
    func memberOfWord(letter: String, word: NSString) -> Bool
    
    func positionInWord(letter: String, word: NSString) -> [Int]
    
    func createDisplayWord(word: NSString)
    
    func updateDisplayWord(positions: [Int])
    
    func playTurn(letter: String, word: NSString)
    
    
    // SHARED FUNCTIONS
    
    // load in the wordlist from a plist file into an array
    func loadWordList() -> NSArray
    
    // handle a turn after the user guessed a letter
    // true = evil, false = normal
    func playTurn(mode: Bool)
    
    // check if the game is over after the turn has been played
    // true = win, false = lose
    func winCheck() -> Bool
    
    // reset all functions, buttons, views
    func initPlay()
    
    
}

