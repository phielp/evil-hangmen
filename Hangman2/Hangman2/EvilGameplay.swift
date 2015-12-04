//
//  EvilGameplay.swift
//  Hangman2
//
//  Created by Philip Bouman on 01-12-15.
//  Copyright © 2015 Philip Bouman. All rights reserved.
//

import UIKit

class EvilGameplay {
    
    var wordLengths : [Int] = []
    var wordLength : Int = 0
//    var wordListN : [String] = []
    
    var listWithLetter : [String] = []
    var listWithoutLetter : [String] = []
    
    var wordList : NSArray = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("words", ofType: "plist")!)!
    
    func testEvil() {
        getWordLengths()
        randomWordLength()
        generateWordListN()
        print("wordLIstN1: \(GlobalVariables.wordListN)")
    }

    // generate array of all possible number of characters in words
    func getWordLengths() {
        for (_, element) in wordList.enumerate() {
            let elementString = String(element)
            let length = elementString.characters.count
            wordLengths.append(length)
        }
        wordLengths = Array(Set(wordLengths))
        wordLengths.sortInPlace()
    }
    
    // pick random length
    func randomWordLength() {
        let randomIndex = Int(arc4random_uniform(UInt32(wordLengths.count)))
        wordLength = wordLengths[randomIndex]
    }
    
    // generate wordlist of all words with length n
    func generateWordListN() {
        GlobalVariables.wordListN = []
        for (_, element) in wordList.enumerate() {
            let elementString = String(element)
            if (elementString.characters.count == wordLength) {
                GlobalVariables.wordListN.append(elementString)
            }
        }
    }
    
    // check if letter is in word
    func memberOfWord(letter: String, word: String) -> Bool {
        
        if word.containsString(letter) {
            return true
        } else {
            return false
        }
    }
    
    // generate two arrays: words with letter and words without letter
    func countOccurences() {
        for (_, element) in GlobalVariables.wordListN.enumerate() {
            let elementString = String(element)
            if ((memberOfWord(GlobalVariables.letter, word: elementString)) == true ) {
                listWithLetter.append(element)
            }
            else {
                listWithoutLetter.append(element)
            }
        }
//        print("With: \(listWithLetter)")
//        print("Without: \(listWithoutLetter)")
        if (listWithLetter.count > listWithoutLetter.count) {
            GlobalVariables.wordListN = listWithLetter
//            print("wordLIstN2: \(GlobalVariables.wordListN)")
            print("WITH: \(GlobalVariables.wordListN.count)")
        } else if (listWithLetter.count < listWithoutLetter.count) {
            GlobalVariables.wordListN = listWithoutLetter
//            print("wordLIstN3: \(GlobalVariables.wordListN)")
            print("WITHOUT: \(GlobalVariables.wordListN.count)")
        } else {
            print("same length!")
        }
    }
}
