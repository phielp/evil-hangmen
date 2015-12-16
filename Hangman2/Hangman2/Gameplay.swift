//
//  Gameplay.swift
//  Hangman2
//
//  Created by Philip Bouman on 01-12-15.
//  Copyright © 2015 Philip Bouman. All rights reserved.
//

import UIKit

class GamePlay {
    
    var displayWord : String = GlobalVariables.displayWord
    var wordList : NSArray = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("words", ofType: "plist")!)!
    
    // get word length
    func WordLength() -> Int {
        let index = Settings().loadSettings()
        return index.wordLength
    }

    // generate wordlist of all words with length n
    func generateWordListN() {
        GlobalVariables.wordListN = []
        for (_, element) in wordList.enumerate() {
            let elementString = String(element)
            let length = WordLength()
            if (elementString.characters.count == length) {
                GlobalVariables.wordListN.append(elementString)
            }
        }
    }
    
    // create visible word
    func createDisplayWord() -> String {
        displayWord = ""        // reset
        var index = 0
        let length = WordLength()
        while index < length {
            displayWord = displayWord + "-"
            index++
        }
        print(displayWord)
        GlobalVariables.displayWord = displayWord
        return displayWord
    }
}
