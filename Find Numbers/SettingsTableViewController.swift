//
//  SettingsTableViewController.swift
//  Find Numbers
//
//  Created by Андрей Русин on 02.05.2022.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var timeGameLabel: UILabel!
    @IBOutlet weak var switchTimer: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        loadSettings()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "selectTimeVC":
          if  let vc = segue.destination as? SelectTimeViewController {
              vc.data = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150]
          }
        default:
            break
        }
    }
    func loadSettings() {
        timeGameLabel.text = "\(Settings.shared.currentSettings.timeForGame) cек"
        switchTimer.isOn = Settings.shared.currentSettings.timerState
    }
    @IBAction func changeTimerState(_ sender: UISwitch) {
        Settings.shared.currentSettings.timerState = sender.isOn
    }
    @IBAction func resetSettings(_ sender: Any) {
        Settings.shared.resetSettings()
        loadSettings()
    }
}
