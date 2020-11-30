//
//  ViewController.swift
//  Part6-sliderGame-
//
//  Created by 山本ののか on 2020/11/29.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var slider: UISlider!
    
    private var answerNum = 0

    enum ValidationResult {
        case correct
        case wrong
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        numberLabel.text = "\(arc4random_uniform(100))"
        slider.setValue(50, animated: false)
    }

    @IBAction private func slide(_ sender: UISlider) {
        answerNum = Int(sender.value)
    }

    @IBAction private func checkTheAnswer(_ sender: Any) {
        var alertMessage = ""
        switch validate() {
        case .correct:
            alertMessage = "当たり！"
        case .wrong:
            alertMessage = "はずれ！"
        }
        alertMessage = alertMessage + "\nあなたの値: \(answerNum)"
        showTheResultAlert(message: alertMessage)
    }

    private func validate() -> ValidationResult {
        if numberLabel.text == String(answerNum) {
            return .correct
        } else {
            return .wrong
        }
    }

    private func showTheResultAlert(message: String) {
        let alert = UIAlertController(title: "結果", message: message, preferredStyle: .alert)
        let retry = UIAlertAction(title: "再挑戦", style: .default) {_ in
            self.numberLabel.text = "\(arc4random_uniform(100))"
            self.slider.setValue(50, animated: false)
        }
        alert.addAction(retry)
        present(alert,animated:true ,completion: nil)
    }
}



// 改善点

// 共通部は1箇所にまとめる
// arc4random_uniform(100)だと0~99
// ramdom関数推奨 https://dev.classmethod.jp/articles/wwdc18-random-number-generator/
// アニメーションを使わないならslider.valueを設定するだけで良い
//private func updateValues() {
//    numberLabel.text = String(Int.random(in: 1...100))
//    slider.value = 50
//}

// sliderの初期値をstoryboardのvalueで設定できないのはiOS14のバグ？
// https://fahimfarook.medium.com/xcode-12-and-ios-14-developer-bugs-and-issues-ada35920a104
