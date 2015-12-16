//
//  EvilGameplay.swift
//  Hangman2
//
//  Created by Philip Bouman on 01-12-15.
//  Copyright © 2015 Philip Bouman. All rights reserved.
//

import UIKit
import Foundation

class EvilGameplay {
    
    var wordLengths : [Int] = []
    var wordLength = GlobalVariables.wordLength
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
        print(wordLengths)
    }
    
    // pick random length
    func randomWordLength() {
        let randomIndex = Int(arc4random_uniform(UInt32(wordLengths.count)))
        GlobalVariables.wordLength = wordLengths[randomIndex]
    }
    
    // generate wordlist of all words with length n
    func generateWordListN() {
        GlobalVariables.wordListN = []
        for (_, element) in wordList.enumerate() {
            let elementString = String(element)
            if (elementString.characters.count == GlobalVariables.wordLength) {
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
        print("With: \(listWithLetter)")
        print("Without: \(listWithoutLetter)")
        if (listWithLetter.count > listWithoutLetter.count) {
            GlobalVariables.wordListN = listWithLetter
//            print("wordLIstN2: \(GlobalVariables.wordListN)")
            print("WITH: \(GlobalVariables.wordListN.count)")
            
            mostCommonPos(GlobalVariables.wordListN, letter: Character(GlobalVariables.letter))
            
        } else if (listWithLetter.count < listWithoutLetter.count) {
            GlobalVariables.wordListN = listWithoutLetter
//            print("wordLIstN3: \(GlobalVariables.wordListN)")
            print("WITHOUT: \(GlobalVariables.wordListN.count)")
        } else {
            print("same length!")
            GlobalVariables.wordListN = listWithoutLetter
            //            print("wordLIstN3: \(GlobalVariables.wordListN)")
            print("WITHOUT: \(GlobalVariables.wordListN.count)")
        }
        
    }
    
    func mostCommonPos(list: [String], letter: Character) {
        var commonPos: Array<NSObject> = []
        
        for (_,word) in list.enumerate() {
            var positions : [Int] = []
            var index = word.startIndex
            var count = 0
            while count < wordLength {
                if word[index] == letter {
                    positions.append(count)
                }
                
                count++
                index = word.startIndex.advancedBy(count)
            }
            commonPos.append(positions)
        }
        print(commonPos)
        
        var index = 0
        var common: NSObject = []
        for (element, key) in freq(commonPos) {
            if key > index {
                index = key
                common = element
            }
            
        }
        print(common)
        var count = 0
        var returnList: [String] = []
        for (element) in commonPos {
            if element == common {
                returnList.append(list[count])
            }
            count++
        }
        print(returnList)
        GlobalVariables.wordListN = returnList
 
    }
    
    func freq<S: SequenceType where S.Generator.Element: Hashable>(seq: S) -> [S.Generator.Element:Int] {
        
        return seq.reduce([:]) {
            
            (var accu: [S.Generator.Element:Int], element) in
            accu[element] = accu[element]?.successor() ?? 1
            return accu
            
        }
    }
    
    
    
}
