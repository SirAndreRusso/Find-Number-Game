//
//  RecordViewController.swift
//  Find Numbers
//
//  Created by Андрей Русин on 03.05.2022.
//

import UIKit

class RecordViewController: UIViewController {

    @IBOutlet weak var recordLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let record = UserDefaults.standard.integer(forKey: keysUserDefaults.recordGame)
        if record != 0 {
            recordLabel.text = "Ваш рекорд: \(record) cек"
        } else {
            recordLabel.text = "Рекорд не установлен"
        }
       
    }
    @IBAction func CancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}
