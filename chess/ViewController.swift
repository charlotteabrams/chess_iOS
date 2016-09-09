
//
//  ViewController.swift
//  chess
//
//  Created by Charlotte Abrams on 9/9/16.
//  Copyright © 2016 Charlotte Abrams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var messageToPlayers: UILabel!
    var click1 = (-1,-1)
    var click2 = (-1,-1)
    var click3 = (-1,-1)
    var piece : Int = 0
    var player : Int = 1 //white is 1, black is 2
    //prepend color to piece value (P=1, N=2, B=3, R=4, Q=5, K=6
    var board : [[Int]] = [[14,12,13,16,15,13,12,14],
                           [11,11,11,11,11,11,11,11],
                           [0,0,0,0,0,0,0,0],
                           [0,0,0,0,0,0,0,0],
                           [0,0,0,0,0,0,0,0],
                           [0,0,0,0,0,0,0,0],
                           [21,21,21,21,21,21,21,21],
                           [24,22,23,26,25,23,22,24]
                           ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func convertSenderToPiece(selected: UILabel?)->Int {
        print(selected!.textColor)
        print(UIColor.whiteColor().isEqual(selected!.textColor))
        print(selected!.textColor == UIColor.whiteColor())
        return 1
    }
    
    func convertIntToPieceString(piece: Int)-> String{
        switch (piece % 10) {
        case 1: return "P"
        case 2: return "N"
        case 3: return "B"
        case 4: return "R"
        case 5: return "Q"
        case 6: return "K"
        default: return "Error"
        }
    }
    
    func updateDisplay() {
        for button in buttons {
            let row = button.tag / 8
            let col = button.tag % 8
            //print("updating \(row),\(col)")
            if board[row][col] == 0 {
                button.setTitle("", forState: .Normal)
            } else {
                button.setTitle(convertIntToPieceString(board[row][col]), forState: .Normal)
                if board[row][col] / 10 == 2 {
                    button.titleLabel?.textColor = UIColor.blackColor()
                } else {
                    button.titleLabel?.textColor = UIColor.whiteColor()
                }
            }
            if click3.0 != -1 { //reset highlighted colors & clicks
                if (row % 2 == 0 && col % 2 == 0) || (row % 2 == 1 && col % 2 == 1) {
                    button.backgroundColor = UIColor.lightGrayColor()
                } else {
                    button.backgroundColor = UIColor.darkGrayColor()
                }
            }
        }
        if click3.0 != -1 {
            click1 = (-1,-1)
            click2 = (-1,-1)
            click3 = (-1,-1)
        }
    }

    @IBAction func squarePressed(sender: UIButton) {
        updateDisplay()
        let row = sender.tag / 8
        let col = sender.tag % 8
        var selected = board[row][col]
        if click1.0 == -1 { // it's the first click (what to move)
            if selected / 10 == player {
                click1 = (row,col)
                piece = selected+sender.tag
                sender.backgroundColor = UIColor.blueColor()
            } else {
                messageToPlayers.text = "You can only move your own pieces"
            }
        } else if click2.0 == -1 { //it's the second click (where to move)
            if player != board[row][col] / 10 { //not moving own piece onto another own
                click2 = (row,col)
                sender.backgroundColor = UIColor.blueColor()
            } else {
                messageToPlayers.text = "You can't capture your own piece"
            }
        } else if click3.0 == -1 { // confirm the move
            if click2 == (row,col) {
                click3 = (row,col)

                board[row][col] = board[click1.0][click1.1]
                board[click1.0][click1.1] = 0
                if player == 1 {
                    
                    print("Tag: \(buttons[row*8+col].tag),calculated value:\(row*8+col)")
                    
                    buttons[row*8+col].titleLabel!.textColor = UIColor.whiteColor()
                    updateDisplay()
                    player = 2
                } else {
                    
                    print("Tag: \(buttons[row*8+col].tag), calculated value:\(row*8+col)")
                    
                    buttons[row*8+col].titleLabel!.textColor = UIColor.blackColor()
                    
                    updateDisplay()
                    player = 1
                }
            } else {
                click3 = (row,col)

                messageToPlayers.text = "You must click the same square to confirm"
            }
        }
        updateDisplay()
    }
    
    func reset(){
        board = [[14,12,13,16,15,13,12,14],
                 [11,11,11,11,11,11,11,11],
                 [0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0],
                 [21,21,21,21,21,21,21,21],
                 [24,22,23,26,25,23,22,24]
        ]
        piece = 0
        player = 1
    }

}

