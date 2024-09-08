//
//  TicTacToeViewController.swift
//  AppWithMiniApps
//
//  Created by Полина Голодаевская on 03.09.2024.
//

import UIKit

class TicTacToeViewController: UIViewController {
    enum Turn {
        case Nought
        case Cross
    }
    
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    
    var NOUGHT = "O"
    var CROSS = "X"
    var board = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard();

    }
    
    func initBoard() {
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)

    }

    @IBAction func boardTapAction(_ sender: UIButton) {
        addToBoard(sender)
        
        if checkForWin(CROSS) {
            resultAlert(title: "CROSS WIN!!!")
        } else if checkForWin(NOUGHT) {
            resultAlert(title: "NOUGHT WIN!!!")
        }
        
        if (fullBoard()){
            resultAlert(title: "The end")
        }
    }
    
    func resetColors(){
        a1.setTitleColor(.black, for: .normal)
        a2.setTitleColor(.black, for: .normal)
        a3.setTitleColor(.black, for: .normal)
        c1.setTitleColor(.black, for: .normal)
        c2.setTitleColor(.black, for: .normal)
        c3.setTitleColor(.black, for: .normal)
        b1.setTitleColor(.black, for: .normal)
        b2.setTitleColor(.black, for: .normal)
        b3.setTitleColor(.black, for: .normal)
    }
    
    func checkForWin(_ s: String) -> Bool {
        if checkSymbol(a1, s) && checkSymbol(a2, s) && checkSymbol(a3, s) {
            a1.setTitleColor(.red, for: .normal)
            a2.setTitleColor(.red, for: .normal)
            a3.setTitleColor(.red, for: .normal)
            return true
        }
        if checkSymbol(b1, s) && checkSymbol(b2, s) && checkSymbol(b3, s) {
            b1.setTitleColor(.red, for: .normal)
            b2.setTitleColor(.red, for: .normal)
            b3.setTitleColor(.red, for: .normal)
            return true
        }
        if checkSymbol(c1, s) && checkSymbol(c2, s) && checkSymbol(c3, s) {
            c1.setTitleColor(.red, for: .normal)
            c2.setTitleColor(.red, for: .normal)
            c3.setTitleColor(.red, for: .normal)
            return true
        }
        if checkSymbol(a1, s) && checkSymbol(b1, s) && checkSymbol(c1, s) {
            a1.setTitleColor(.red, for: .normal)
            b1.setTitleColor(.red, for: .normal)
            c1.setTitleColor(.red, for: .normal)
            return true
        }
        if checkSymbol(a2, s) && checkSymbol(b2, s) && checkSymbol(c2, s) {
            a2.setTitleColor(.red, for: .normal)
            b2.setTitleColor(.red, for: .normal)
            c2.setTitleColor(.red, for: .normal)
            return true
        }
        if checkSymbol(a3, s) && checkSymbol(b3, s) && checkSymbol(c3, s) {
            a3.setTitleColor(.red, for: .normal)
            b3.setTitleColor(.red, for: .normal)
            c3.setTitleColor(.red, for: .normal)
            return true
        }
        if checkSymbol(a1, s) && checkSymbol(b2, s) && checkSymbol(c3, s) {
            a1.setTitleColor(.red, for: .normal)
            b2.setTitleColor(.red, for: .normal)
            c3.setTitleColor(.red, for: .normal)
            return true
        }
        if checkSymbol(a3, s) && checkSymbol(b2, s) && checkSymbol(c1, s) {
            a3.setTitleColor(.red, for: .normal)
            b2.setTitleColor(.red, for: .normal)
            c1.setTitleColor(.red, for: .normal)
            return true
        }
        return false
    }
    
    func checkSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert(title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resetBoard()
        }))
        
        // Для iPad
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        self.present(alertController, animated: true)
    }
    
    func resetBoard(){
        resetColors()
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if (firstTurn == Turn.Cross) {
            firstTurn = Turn.Nought
            turnLabel.text = NOUGHT
        } else if (firstTurn == Turn.Nought) {
            firstTurn = Turn.Cross
            turnLabel.text = CROSS
        }
        currentTurn = firstTurn
    }
    
    func fullBoard() -> Bool {
        for button in board {
            if (button.title(for: .normal) == nil){
                return false
            }
        }
        return true
    }
    
    func addToBoard(_ sender: UIButton) {
        if (sender.title(for: .normal) == nil){
            if (currentTurn == Turn.Nought){
                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = CROSS
            }
            else if (currentTurn == Turn.Cross){
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.Nought
                turnLabel.text = NOUGHT
            }
            sender.isEnabled = false
        }
    }
}
