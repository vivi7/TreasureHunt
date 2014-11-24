//
//  Hunt.swift
//  TreasureHunt
//
//  Created by Vincenzo Favara on 25/09/14.
//  Copyright (c) 2014 Vincenzo Favara. All rights reserved.
//

import Foundation

class Hunt {
    let QUESTION_STATE_NONE:Int = 0
    let QUESTION_STATE_INTRO:Int = 1
    let QUESTION_STATE_QUESTIONING:Int = 2
    let QUESTION_STATE_KEY:String = "QUESTION_STATE_KEY"
    let FINISH_TIME_KEY:String = "FINISH_TIME_KEY"
    
    //var theHunt:Hunt
    var hrm:HuntResourceManager = HuntResourceManager()
    
    var isShuffled:Bool = false
    var questionState:Int = 0
    var finishTime:Double = 0.0
    
    var soundManager:SoundManager = SoundManager()
    var achievementManager:AchievementManager = AchievementManager()
    
    var tagsFound: Dictionary<String,Bool> = Dictionary<String,Bool>()
    var tags: Dictionary<String,AHTag> = Dictionary<String,AHTag>()
    var clues: Dictionary<String,Clue> = Dictionary<String,Clue>()
    
    var clueList: Array<Clue> = Array<Clue>()
    var clueListShuffleFinal: Array<Clue> = Array<Clue>()
    var tagList: Array<AHTag> = Array<AHTag>()
    
    var hasSeenIntro:Bool = false;
    
    let HAS_SEEN_INTRO_KEY: String = "HAS_SEEN_INTRO_KEY";
    
    let WRONG_CLUE:String = "WRONG CLUE"
    let ACK:String = "ACK"
    let CLUE_COMPLETE:String = "CLUE COMPLETE"
    let ALREADY_FOUND:String = "ALREADY FOUND"
    let DECOY:String = "DECOY"
    // The actual text for the DECOY clue.
    let DECOY_ID:String = "decoy"
    
    
    /** Shuffles the clues.  Note that each clue is marked with
    *  a difficulty group, so that, say, a hard clue can't preceed
    *  an easier clue.
    * @param seed The random number seed.
    */
    func shuffle(seed:Int) {
        if (isShuffled) {
            return;
        }
        
        var cluesToShuffle:Array<Clue> = Array<Clue>();
    
        let firstClue:Clue = clueList[0]
        let lastClue:Clue = clueList[clueList.count-1]
        
        //Divide Clues for shufflegroup
        for var i:Int = 0; i < clueList.count; i++ {
            var clueIter:Clue = clueList[i]
            if (clueIter.shufflegroup != firstClue.shufflegroup &&
                clueIter.shufflegroup != lastClue.shufflegroup) {
                cluesToShuffle.append(clueIter)
            }
        }
        //Shuffle clues divided
        var clueListShuffle:Array<Clue> = shuffleClues(cluesToShuffle)
        
        //Set clueListShufflFinal
        clueListShuffleFinal.append(firstClue)
        for (var i=0; i<clueListShuffle.count; i++) {
            clueListShuffleFinal.append(clueListShuffle[i])
        }
        clueListShuffleFinal.append(lastClue)
            
        isShuffled = true;
    }
    
    func shuffleClues<Clue>(var list: Array<Clue>) -> Array<Clue> {
        for i in 0..<list.count {
            let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
            list.insert(list.removeAtIndex(j), atIndex: i)
        }
        return list
    }
  
/*
    /**
    * Saves the player's progress.
    *
    * @param res
    * @param context
    */
    public void save(Resources res, Context context) {
    SharedPreferences sharedPref = context.getSharedPreferences(
    res.getString(R.string.preference_file_key),
    Context.MODE_PRIVATE);
    
    Editor editor = sharedPref.edit();
    
    // XXX encrypt this?
    for (String key : tagsFound.keySet()) {
    editor.putBoolean(key, tagsFound.get(key));
    }
    
    editor.putBoolean(HAS_SEEN_INTRO_KEY, hasSeenIntro);
    editor.putInt(QUESTION_STATE_KEY, questionState);
    editor.putLong(FINISH_TIME_KEY, finishTime);
    
    editor.commit();
    
    }
*/
    
    /** Loads player progress. */
    func restore() {
        //TODO restore App deleting any object
    }
    
    /** Returns whether or not we're in a question so we can restore itself. */
    func getQuestionState() ->Int {
        return questionState;
    }
    
    /** Deletes all player progress.*/
    func reset() {
        tagsFound = Dictionary<String,Bool>()
        for tag :AHTag in tagList {
            tagsFound.updateValue(false, forKey: tag.id)
        }
        // I'm not currently asking a question
        questionState = QUESTION_STATE_NONE;
        hasSeenIntro = false;
    }
    
    func getCurrentClue() ->Clue? {
        var length:Int = clueList.count;
        for (var i:Int = 0; i < length; i++) {
            var clue:Clue = clueList[i];
    
            if (isClueFinished(clue) && questionState != QUESTION_STATE_NONE) {
                // We're still asking a question
                return clue;
            }
    
            if (!isClueFinished(clue)) {
                return clue;
            }
        }
        // The hunt is complete!
        return nil;
    }
    
    /** What clue have I *just* completed? */
    func getLastCompletedClue() -> Clue? {
        var length:Int = clueList.count
        var lastBestClue:Clue?
        for var i:Int = 0; i < length; i++ {
            var clue:Clue = clueList[i]
    
            if (!isClueFinished(clue)) {
                return lastBestClue
            }
            lastBestClue = clue
        }
        // The hunt is complete.
        return lastBestClue
    }
    
    
    func isTagFound(id:String ) -> Bool {
        if ((tagsFound.indexForKey(id)) == nil) {
            return false;
        }
        return tagsFound[id]!;
    }
    
    /**
    * Called when a tag is scanned.  Checks the hunt
    */
    func findTag(tagId:String) -> String? {
    
        if (tagId == DECOY_ID) {
            return DECOY;
        }
        // See if this tag is part of this clue
        var clue:Clue = getCurrentClue()!;
    
        var tag:AHTag = tags[tagId]!;
    
        //if tag == nil {
        //    return WRONG_CLUE
        //}
    
        if (clue.id == tag.clueId) {
            if (isTagFound(tagId)) {
                return ALREADY_FOUND
            }
    
            tagsFound.updateValue(true, forKey: tag.id)
    
            if (isClueFinished(clue)) {
                return CLUE_COMPLETE;
            }
            return ACK;
        }
        return WRONG_CLUE;
    }
    
    /** Have we found all the clues?  Does not check question completeness. */
    func isClueFinished(clue:Clue) ->Bool {
        for tag :AHTag in clue.tags {
            if (!isTagFound(tag.id)) {
                return false;
            }
    }
    
    return true;
    }
    
    func getTotalClues() -> Int {
        return clueList.count;
    }
    
    /** Count from 1. */
    func getClueDisplayNumber(clue:Clue) ->Int {
        return  NSArray(array: clueList).indexOfObject(clue)+1
    }
    
    /** Count from 0. */
    func getClueIndex(clue:Clue) ->Int {
        return NSArray(array: clueList).indexOfObject(clue);
    }
    
/*
    func setClueImage() {
        let clue:Clue = getCurrentClue()!;
    
        if (clue.displayImage == nil) {
            imgView.setImageDrawable(res.getDrawable(R.drawable.ab_icon));
        } else {
            imgView.setImageDrawable(hrm.drawables.get(clue.displayImage));
        }
    }
*/
    
    func getHasSeenIntro() -> Bool {
        return hasSeenIntro
    }
    
    func setIntroSeen(val:Bool) {
        hasSeenIntro = val;
    }
    
    func setQuestionState(state:Int) {
        questionState = state;
    }
    
    func setStartTime() {
        finishTime = CFAbsoluteTimeGetCurrent() + 15000;
    }
    
    func getFinishTime() -> Double {
        return CFAbsoluteTimeGetCurrent()
    }
    
    func getSecondsLeft() -> Int{
        return Int((finishTime - CFAbsoluteTimeGetCurrent()) / 1000.0)
    }
    
    func isComplete() ->Bool {
        return (getCurrentClue() == nil)
    }
    
    func hasAnsweredQuestion(clue:Clue) -> Bool{
        var currentClueNum:Int = getClueIndex(clue)
    
        // Find the first question in the list and see if we're past it.
        var totalClues:Int = clueList.count
        for var i:Int = 0; i < totalClues; i++ {
            if (clueList[i].question != nil) {
                return currentClueNum > i;
            }
        }
        return false;
    }
}


