//
//  ViewController.swift
//  Dota 2 Item Quiz
//
//  Created by Sravan on 11/02/16.
//  Copyright © 2016 pioneer11x. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let sampleQuestion = ["Poor Mans Shield","Stout Shield","Slippers of Agility","Slipper of Agility"]
    
    let buffer = ["branch","Ogre Club","Blades of Attack","Pipe of Insight","Bubu","Nara"]
    
    var selectedOptions = Array<String>()
    
    @IBOutlet var resultLabel: UILabel!
    
    var answerOptions = Array<String>()

    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var optionButtons: [UIButton]!
    
    @IBOutlet var submitButton: UIButton!
    
    @IBOutlet var reloadButton: UIButton!
    
    @IBAction func optionSeleceted(sender: UIButton) {
        let optionSelected = sender.titleLabel?.text
        if selectedOptions.contains(optionSelected!){
            // We need to delete it and change the color to Red
            selectedOptions  = selectedOptions.filter{$0 != optionSelected}
            sender.backgroundColor = UIColor(red: 0.766832, green: 1, blue: 0.891204, alpha: 1)
        }
        else{
            selectedOptions.append(optionSelected!)
            sender.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
        }
        print(selectedOptions)
    }

    
    @IBAction func submitPressed(sender: UIButton) {
        let selectedCount = selectedOptions.count
        let answerCount = answerOptions.count
        
        if (selectedCount != answerCount){
            lost()
            return
        }
        else{
            for i in 0...(answerCount-1){
                if selectedOptions.contains(answerOptions[i]){
                    selectedOptions = selectedOptions.filter{ $0 != answerOptions[i] }
                }else{
                    lost()
                    return
                }
            }
        }
        view.backgroundColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1)
        questionLabel.text = "Won"
        return
    }
    
    func lost(){
        view.backgroundColor = UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1)
        for i in 0...5{
            optionButtons[i].hidden = true
        }
        questionLabel.hidden = true
        resultLabel.hidden = false
        resultLabel.text = "Lost"
        submitButton.hidden = true
        reloadButton.hidden = false
        return
    }
    
    @IBAction func reloadButtonFunction(sender: UIButton) {
        start()
    }
    
    func start(){
        
        selectedOptions.removeAll()
        answerOptions.removeAll()
        
        let questionCreated = createQuestion(sampleQuestion)
        answerOptions = questionCreated.answers
        displayQuestion(questionCreated)
        
        for i in 0...5{
            optionButtons[i].hidden = false
            optionButtons[i].backgroundColor = UIColor(red: 0.766832, green: 1, blue: 0.891204, alpha: 1)
        }
        questionLabel.hidden = false
        submitButton.hidden = false
        resultLabel.hidden = true
        reloadButton.hidden = true
    }
    
    override func viewDidLoad() {
//        print(optionButtons[0].backgroundColor)
/*        let questionCreated = createQuestion(sampleQuestion)
        answerOptions = questionCreated.answers
        displayQuestion(questionCreated)
        
        resultLabel.hidden = true
        reloadButton.hidden = true
*/
        start()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayQuestion ( questionArray: questionStructure ) {
        questionLabel.text = questionArray.question
        
        for i in 0...5{
            optionButtons[i].setTitle(questionArray.options[i], forState: .Normal)
        }
        
    }
    
    struct questionStructure {
        var question : String
        var options : Array<String>
        var answers : Array<String>
    }
    
    func createQuestion( data: Array<String> ) -> questionStructure {
        
        let limit = 6 // This is the maximum number of options we have i nour app
        
        let question = data[0]
        let numOfOptions = data.count
        
        var options = Array<String>()
        
        for i in 1...(numOfOptions-1) {
            options.append(data[i])
        }
        
        let answers = options
        
        let fillerCount = limit - numOfOptions
        
        for _ in 0...fillerCount{
            
            options.append(buffer[random()%fillerCount])
            
        }
        
        let shuffledOptions = shuffle(options)
        
        print(shuffledOptions)
        
        let returnArray = questionStructure(question: question, options: shuffledOptions, answers: answers)
        
        return returnArray
        
    }
    
    func shuffle<T>(var list: Array<T>) -> Array<T> {
        for i in 0...(list.count-1) {
            let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
            list.insert(list.removeAtIndex(j), atIndex: i)
        }
        return list
    }


}

