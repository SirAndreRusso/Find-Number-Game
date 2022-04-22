//
//  GameViewController.swift
//  Guess Number
//
//  Created by Андрей Русин on 07.04.2022.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nextDigitLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var newGameButton: UIButton!
    // Creating Game object after buttons outlets will be loaded in viewdidload
    // Создается экземпляр класса Game после загрузки аутлетов кнопок
    lazy var game = Game(countItems: buttons.count, time: 30) { [weak self] (status, time) in
        guard let self = self else {return}
        self.timerLabel.text = time.secondsToString()
        self.updateInfoGame(with: status)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen ()
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else {return}
        game.check(index: buttonIndex)
        updateUI()
        
    }
    // Setting up buttons titles in appliance with items titles. Setting up label with next number. Making all buttons visible
    // кнопкам на экране присваиваются тайтлы, соответствующие числам из массива айтемов. В лейбл добавляется число, которое нужно найти. Все кнопки становятся видимыми
    
    private func setupScreen () {
        for index in game.items.indices {
            buttons[index].setTitle(game.items[index].title, for: .normal)
            buttons[index].alpha = 1
            buttons[index].isEnabled = true
        }
        nextDigitLabel.text = game.nextItem?.title
        
    }
    // Hiding the buttons after they  was found. Changing the label text after game status updated to .win
    // Скрываем кнопки после того как найдены искомые числа. Обновляем лейбл после победы
    private func updateUI() {
        for index in game.items.indices {
            buttons[index].alpha = game.items[index].isFound ? 0 : 1
            buttons[index].isEnabled = !game.items[index].isFound
            if game.items[index].isError {
                UIView.animate(withDuration: 0.3) {[weak self]  in
                    self?.buttons[index].backgroundColor = .red
                } completion: {[weak self] (_) in
                    self?.buttons[index].backgroundColor = .white
                    self?.game.items[index].isError = false
                }

            }
        }
        nextDigitLabel.text = game.nextItem?.title
        updateInfoGame(with: game.status)
}
private func updateInfoGame(with status: StatusGame) {
    switch status {
    case .start:
        statusLabel.text = "Игра началась"
        statusLabel.textColor = .black
        newGameButton.isHidden = true
    case .win:
        statusLabel.text = "Вы выиграли!"
        statusLabel.textColor = .green
        newGameButton.isHidden = false
    case .lose:
        statusLabel.text = "Вы проиграли"
        statusLabel.textColor = .red
        newGameButton.isHidden = false
    }
}
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        sender.isHidden = true
        setupScreen()
    }
}

