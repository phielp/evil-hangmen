//
//  GoodGameplay.swift
//
//  Handles Good gameplay
//
//  Created by Philip Bouman on 01-12-15.
//  Copyright © 2015 Philip Bouman. All rights reserved.
//

import UIKit

class GoodGameplay {
    
    var word : String = GlobalVariables.word
    var displayWord : String = GlobalVariables.displayWord
    
    // Load plist file (wordlist) into array
    var wordList : NSArray = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("words", ofType: "plist")!)!
    
    // pick word, return display word
    func initPlay() -> String {
        word = pickRandomWord()
        GlobalVariables.word = word                         // update global
        displayWord = createDisplayWord(word)
        GlobalVariables.displayWord = displayWord           // update global
        return displayWord
    }
    
    // check if letter is member, if so update the display word, else
    // reduce the number of turns to play
    func playTurn(letter: String) -> (displayWord: String, correct:Bool) {
        let correct : Bool
        if memberOfWord(letter, word: word) == true {
            updateDisplayWord(positionInWord(letter, word: word), letter: letter)
            correct = true
        } else {
            correct = false
            GlobalVariables.numberOfTurns = GlobalVariables.numberOfTurns - 1
        }
        GlobalVariables.displayWord = displayWord           // update global
        winCheck()
        return (displayWord, correct)
    }
    
    // check if word is guessed correctly
    func winCheck() {
        if word == displayWord {
            print("win")
        } else {
            if GlobalVariables.numberOfTurns == 1 {
                print("lose")
            }
        }
    }
    
    // create visible word
    func createDisplayWord(word: NSString) -> String {
        displayWord = ""        // reset
        var index = 0
        while index < word.length {
            displayWord = displayWord + "-"
            index++
        }
        return displayWord
    }
    
    // update visible word
    func updateDisplayWord(positions: [Int], letter: String) -> String {
        for position in positions {
            displayWord.replaceRange(displayWord.startIndex.advancedBy(
                position)..<displayWord.startIndex.advancedBy(position + 1),
                with: letter)
        }
        return displayWord
    }

    // pick random word from wordlist
    func pickRandomWord() -> String {
        let randomIndex = Int(arc4random_uniform(UInt32(wordList.count)))
        let randomWord = wordList[randomIndex]
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
    
    // print contents of wordlist
    func printListContents() {
        
        for (index, element) in wordList.enumerate() {
            print("Item \(index): \(element)")
        }
        print("Length of List: \(wordList.count)")
    }
}