//
//  TriviaQuestion.swift
//  TreasureHunt
//
//  Created by Vincenzo Favara on 25/09/14.
//  Copyright (c) 2014 Vincenzo Favara. All rights reserved.
//

import Foundation

class TriviaQuestion {
    
    var question: String?
    var bitmapID: String?
    var answers: Array<String>?
    var correctAnswer: Int? = -1
    var rightMessage: String?
    var wrongMessage: String?
    
/*
    typealias JSON = AnyObject
    typealias JSONDictionary = Dictionary<String, JSON>
    typealias JSONArray = Array<JSON>
    
    init(jsonobj:JSON) {
    
    question = jsonobj.getString("question");
    if (jsonobj.has("bitmap")) {
    bitmapID = jsonobj.getString("bitmap");
    }
    
    answers = ArrayList<String>();
    
    JSONArray questionList = jsonobj.getJSONArray("answers");
    for (int i = 0; i < questionList.length(); i++) {
    String answerString = (String) questionList.get(i);
    answers.add(answerString);
    }
    
    correctAnswer = jsonobj.getInt("correctAnswer");
    rightMessage = jsonobj.getString("rightMessage");
    wrongMessage = jsonobj.getString("wrongMessage");
    }
*/
    
}