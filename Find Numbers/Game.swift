//
//  Game.swift
//  Guess Number
//
//  Created by Андрей Русин on 07.04.2022.
//

import Foundation
// Enumeration of game statuses
// Состояния игры
enum StatusGame {
    case start
    case win
    case lose
}
// A class that determines the model of the game
// Класс,описывающий модель игры
class Game {
    // A struct that determines an item (button)
    // Структура, описывающая айтем (кнопку)
    struct Item {
        var title: String
        var isFound: Bool = false
        var isError = false
    }
    // An array of numbers containing the data to use in array of items
    // Массив чисел, из которого будем брать элементы для массива айтемов
    private let data = Array(1...99)
    // empty array for items
    var items: [Item] = []
    private var countItems: Int
    // Число, передаваемое в лейбл, которое нужно найти среди кнопок с числами
    // The next number in lable
    var nextItem: Item?
    // Default status of the game with observer
    // Значение статуса по умолчанию, с наблюдателем
    var status: StatusGame = .start {
        didSet{
            if status != .start{
                stopGame()
            }
        }
    }
    //Defining time for game
    // Определяем игровое время
    private var timeForGame: Int
    // Time left
    // Оставшееся для игры время
    private var secondsGame: Int {
        didSet {
            if secondsGame == 0{
                status = .lose
            }
            updateTimer(status, secondsGame)
        }
    }
    private var timer: Timer?
    // ??
    private var updateTimer:((StatusGame, Int)->Void)
    init(countItems: Int,  updateTimer: @escaping (_ status: StatusGame, _ seconds: Int) -> Void) {
        self.countItems = countItems
        self.timeForGame = Settings.shared.currentSettings.timeForGame
        self .secondsGame = self.timeForGame
        self.updateTimer = updateTimer
        setupGame()
    }
    // создание необходимого количества уникальных айтемов и числа, которое необходимо найти, установка таймера
    // Preparing the game by creating uniq items and adding items in array. Creating next number to find. timer setup
    private func setupGame(){
        var digits = data.shuffled()
        items.removeAll()
        while items.count < countItems {
            let item = Item(title: String(digits.removeFirst()))
            items.append(item)
        }
        nextItem = items.shuffled().first
        updateTimer(status, secondsGame)
        if Settings.shared.currentSettings.timerState{
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {[weak self] (_) in
                self?.secondsGame -= 1
            })
        }
    }
    func newGame(){
        status = .start
        self.secondsGame = self.timeForGame
        setupGame()
        
    }
    // Checking up numbers to
    // проверка числа на соответствие числу из лейбла, которое нужно найти. когда все числа будут найдены, сменить статус на .win
    func check (index: Int) {
        guard status == .start else {return}
        if items[index].title == nextItem?.title {
            items[index].isFound = true
            nextItem = items.shuffled().first(where: {(Item)-> Bool in Item.isFound == false})
        }   else {
            items[index].isError = true
        }
        if nextItem == nil {
            status = .win
        }
    }
    // Stopping the timer
    
    func stopGame () {
        timer?.invalidate()
    }
    
}
// Making timerlabel info more comfortable
// Делаем удобное представление для timerLabel
extension Int{
    func secondsToString()->String{
        let minutes = self / 60
        let seconds = self % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
