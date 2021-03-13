//
//  ViewController.swift
//  Flashcards
//
//  Created by Sydnee Tan on 2/21/21.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}

class ViewController: UIViewController {
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        card.layer.cornerRadius = 20.0
        frontLabel.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        
        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
        
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.3
        
        Button1.layer.cornerRadius = 20.0
        Button2.layer.cornerRadius = 20.0
        Button3.layer.cornerRadius = 20.0
        
        Button1.layer.borderWidth = 3.0
        Button2.layer.borderWidth = 3.0
        Button3.layer.borderWidth = 3.0
        
        Button1.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        Button2.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        Button3.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
    }


    
    @IBAction func didTapOnFlashCard(_ sender: Any) {
        frontLabel.isHidden = !frontLabel.isHidden
        if frontLabel.isHidden == false {
            Button1.isHidden = false;
            Button3.isHidden = false;
        }
    }
    
    
    @IBAction func didTapButton1(_ sender: Any) {
        Button1.isHidden = true
    }
    
    
    @IBAction func didTapButton2(_ sender: Any) {
        frontLabel.isHidden = true
    }
    
    @IBAction func didTapButton3(_ sender: Any) {
        Button3.isHidden = true
    }
    
    func updateFlashcard(question: String, answer: String, option1: String, option2: String)  {
        frontLabel.text = question
        backLabel.text = answer
        Button2.setTitle(answer, for: .normal)
        Button1.setTitle(option1, for: .normal)
        Button3.setTitle(option2, for: .normal)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // destination of the segue is the navigation Controller
        let navigationController = segue.destination as! UINavigationController
        
        // the navigation controller only contains a creation view controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        //set the FlashcardController property to self
        creationController.flashcardController = self
        if segue.identifier == "EditSegue"{
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
            creationController.initialOption1 = Button1.title(for: .normal)
            creationController.initialOption2 = Button3.title(for: .normal)
            
            
        }
    }

}

