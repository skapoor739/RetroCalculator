//
//  ViewController.swift
//  Retro Calculator
//
//  Created by Shivam Kapur on 28/09/15.
//  Copyright © 2015 Shivam Kapur. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation:String {
        case Addition = "+"
        case Division = "/"
        case Multiplication = "*"
        case Subtract = "-"
        case Empty = ""
    }
    
    
    @IBOutlet weak var outputLabel:UILabel!
    
    var buttonSound:AVAudioPlayer!
    
    var leftOperand = ""
    var rightOperand = ""
    var result:String = ""
    var currentOperation:Operation = Operation.Empty
    var currentValue = ""
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL.fileURLWithPath(path!)
        do {
            try buttonSound = AVAudioPlayer(contentsOfURL: soundURL)
            buttonSound.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
        
    }

    @IBAction func numberPressed(button : UIButton!) {
        isButtonSoundPlaying()
        currentValue += "\(button.tag)"
        outputLabel.text = currentValue
       
        
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        isButtonSoundPlaying()
        processOperation(Operation.Multiplication)
        
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        isButtonSoundPlaying()
        processOperation(Operation.Division)
    }
    
    @IBAction func onAdditionPressed(sender: AnyObject) {
        isButtonSoundPlaying()
        processOperation(Operation.Addition)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        isButtonSoundPlaying()
        processOperation(Operation.Subtract)
    }

    @IBAction func onEqualsPressed(sender: AnyObject) {
        isButtonSoundPlaying()
        processOperation(currentOperation)
        outputLabel.text = result
        
    }
    
    
    
    
    func isButtonSoundPlaying() {
        if buttonSound.playing {
            buttonSound.stop()
        } else {
            buttonSound.play()
        }

    }
    
    func processOperation (operation: Operation) {
        
        if currentOperation != Operation.Empty {
            
            if currentValue != "" {
            
            rightOperand = currentValue
            currentValue = ""
            
            if currentOperation == Operation.Addition {
                result = "\(Double(leftOperand)! + Double(rightOperand)!)"
                print("Addition = \(result)")
            } else if currentOperation == Operation.Subtract {
                result = "\(Double(leftOperand)! - Double(rightOperand)!)"
                
            } else if currentOperation == Operation.Multiplication {
                result = "\(Double(leftOperand)! * Double(rightOperand)!)"
            } else if currentOperation == Operation.Division {
                result = "\(Double(leftOperand)! / Double(rightOperand)!)"
            }
            
            leftOperand = result
            outputLabel.text = result
                
            }
            currentOperation = operation
            
        } else if currentOperation == Operation.Empty{
            leftOperand = currentValue
            currentValue = ""
            currentOperation = operation
        }
    }
    
    @IBAction func clearButtonPressed(sender : AnyObject!) {
        isButtonSoundPlaying()
        outputLabel.text = "0"
        currentValue = ""
        leftOperand = ""
        rightOperand = ""
        result = ""
        currentOperation = Operation.Empty
    }
    
    
}

