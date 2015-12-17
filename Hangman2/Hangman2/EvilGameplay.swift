//
//  EvilGameplay.swift
//  
//  Handles Evil gameplay
//
//  Created by Philip Bouman on 01-12-15.
//  Copyright © 2015 Philip Bouman. All rights reserved.
//

import UIKit
import Foundation

class EvilGameplay {
    
    var wordLengths : [Int] = []
    var wordLength = GamePlay().WordLength()
    
    var displayWord : String = GlobalVariables.displayWord
    
    var listWithLetter : [String] = []
    var listWithoutLetter : [String] = []
    
    var wordList : NSArray = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("words", ofType: "plist")!)!
    
    func testEvil() {
        GamePlay().generateWordListN()
        print("wordLIstN1: \(GlobalVariables.wordListN)")
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
    func playTurn() -> (displayWord: String, correct:Bool) {
        let correct : Bool
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
            
            let pos = mostCommonPos(GlobalVariables.wordListN, letter: Character(GlobalVariables.letter))
            
            displayWord = GamePlay().updateDisplayWord(pos, letter: GlobalVariables.letter)
            GlobalVariables.displayWord = displayWord       // update global
            correct = true
            
        } else if (listWithLetter.count < listWithoutLetter.count) {
            GlobalVariables.wordListN = listWithoutLetter
            correct = false
            GlobalVariables.numberOfTurns = GlobalVariables.numberOfTurns - 1
        } else {
            GlobalVariables.wordListN = listWithoutLetter
            correct = false
            GlobalVariables.numberOfTurns = GlobalVariables.numberOfTurns - 1
        }
        
        if listWithoutLetter.count == 0 && listWithLetter.count == 1 {
            
        }
        return (displayWord, correct)
    }
    
    // calculates the most appearing position of a letter in wordlist
    // and returns chosen letter positions if letter is occuring in more then
    // 50% of the words
    func mostCommonPos(list: [String], letter: Character) -> [Int] {
        var commonPos: Array<NSObject> = []
        
        // get all letter positions of all words
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
        
        // find most common letter position
        var index = 0
        var common: NSObject = []
        for (element, key) in freq(commonPos) {
            if key > index {
                index = key
                common = element
            }
            
        }

        // get all words with most common letter position
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
        
        return common as! [Int]
    }
    
    // count occurences of objects
    func freq<S: SequenceType where S.Generator.Element: Hashable>(seq: S) -> [S.Generator.Element:Int] {
        
        return seq.reduce([:]) {
            
            (var accu: [S.Generator.Element:Int], element) in
            accu[element] = accu[element]?.successor() ?? 1
            return accu
        }
    }
}
