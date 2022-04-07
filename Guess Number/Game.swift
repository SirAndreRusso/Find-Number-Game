//
//  Game.swift
//  Guess Number
//
//  Created by Андрей Русин on 07.04.2022.
//

import Foundation
enum StatusGame {
    case start
    case win
}
class Game {
    struct Item {
        var title: String
        var isFound: Bool = false
    }
    
    private let data = Array(1...99)
    var items: [Item] = []
    private var countItems: Int
    var nextItem: Item?
    var status: StatusGame = .start
    init(countItems: Int) {
        self.countItems = countItems
        setupGame () 
    }
    private func setupGame(){
        var digits = data.shuffled()
        while items.count < countItems {
            var item = Item(title: String(digits.removeFirst()))
            items.append(item)
        }
        nextItem = items.shuffled().first
    }
    func check (index: Int) {
        if items[index].title == nextItem?.title {
            items[index].isFound = true
            nextItem = items.shuffled().first(where: {(Item)-> Bool in Item.isFound == false})
            
        }
        if nextItem == nil {
            status = .win
        }
    }
    
}
