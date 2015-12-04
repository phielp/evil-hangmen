//
//  GoodGameplay.swift
//  Hangman2
//
//  Created by Philip Bouman on 01-12-15.
//  Copyright © 2015 Philip Bouman. All rights reserved.
//

import UIKit

class GoodGameplay {
    
    // Load plist file (wordlist) into array
    var wordList : NSArray = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("words", ofType: "plist")!)!
    
    // print contents of wordlist
    func printListContents() {
        
        for (index, element) in wordList.enumerate() {
            print("Item \(index): \(element)")
        }
        print("Length of List: \(wordList.count)")
    }
    
    // pick random word from wordlist
    func pickRandomWord() -> String {
        let randomIndex = Int(arc4random_uniform(UInt32(wordList.count)))
        let randomWord = wordList[randomIndex]
        print("Random \(randomIndex): \(randomWord)")
        return randomWord as! String
    }
    
    // check if letter is in word
    func memberOfWord(letter: String, word: NSString) -> Bool {
        
        if word.containsString(letter) {
            return true
        } else {
            return false
        }
    }
    
    // give back all positions of letter in a word
    func positionInWord(letter: String, word: NSString) -> [Int] {
        var positions : [Int] = []
        var index = 0
        
        while index < word.length {
            
            // characterAtIndex returns ASCII, UnicodeScalar converts it back
            if String(UnicodeScalar(word.characterAtIndex(index))) == letter {
                positions.append(index)
            }
            index++
        }
        return positions
    }
    
    // create visible word
    func createDisplayWord(word: NSString) {
        GlobalVariables.displayWord = ""        // reset
        var index = 0
        while index < word.length {
            GlobalVariables.displayWord = GlobalVariables.displayWord + "_"
            index++
        }
        print(GlobalVariables.displayWord)
    }
    
    // update visible word
    func updateDisplayWord(positions: [Int]) {
        for position in positions {
            GlobalVariables.displayWord.replaceRange(GlobalVariables.displayWord.startIndex.advancedBy(
                position)..<GlobalVariables.displayWord.startIndex.advancedBy(position + 1),
                with: GlobalVariables.letter)
        }
        print(GlobalVariables.displayWord)
    }
    
    func playTurn(letter: String, word: NSString) {
        if memberOfWord(letter, word: word) == true {
            updateDisplayWord(positionInWord(letter, word: word))
        } else {
            print("\(GlobalVariables.letter) not in word")
        }
    }
}