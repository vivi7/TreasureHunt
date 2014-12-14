// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"



extension Array {
    func randomItem() -> T {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

let myArray = [1, 2, 3, 4, 5, 6, 7, 8, 10, 12, 14, 16]

var myItem = myArray.randomItem()
myItem = myArray.randomItem()
myItem = myArray.randomItem()
myItem = myArray.randomItem()


let array = ["Frodo", "sam", "wise", "gamgee"]
let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
println(array[randomIndex])

class Clue {
    var name:String?
    var group:Int?
    init(nameP:String, groupP:Int){
        name=nameP
        group=groupP
    }
}

var listClue: Array<Clue> = [
    Clue(nameP: "nome0",groupP: 0),
    Clue(nameP: "nome1",groupP: 1),
    Clue(nameP: "nome2",groupP: 2),
    Clue(nameP: "nome3",groupP: 2),
    Clue(nameP: "nome4",groupP: 2),
    Clue(nameP: "nome5",groupP: 3)
    ];

func shuffle<String>(var list: Array<String>, var groupV:Int) -> Array<String> {
    for i in 0..<list.count {
        let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
        list.insert(list.removeAtIndex(j), atIndex: i)
    }
    return list
}






