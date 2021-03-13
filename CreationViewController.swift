//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Sydnee Tan on 2/27/21.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardController : ViewController!
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var option1TextField: UITextField!
    @IBOutlet weak var option2TextField: UITextField!
    
    var initialQuestion: String?
    var initialAnswer: String?
    var initialOption1: String?
    var initialOption2: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
        option1TextField.text = initialOption1
        option2TextField.text = initialOption2

        // Do any additional setup after loading the view.
    }
    

    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionTextField.text
        
        let answerText = answerTextField.text
        
        let option1Text = option1TextField.text
        
        let option2Text = option2TextField.text
        
        if questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty || option1Text == nil || option1Text!.isEmpty || option2Text == nil || option2Text!.isEmpty
        {
            let alert = UIAlertController(title: "Missing Text", message: "Please enter question and answers.", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default)
            
            alert.addAction(okAction)
            present(alert, animated: true)
            
        } else{
            var isExisting = false
            if initialQuestion !=  nil {
                isExisting = true
            }
            
            flashcardController.updateFlashcard(question: questionText!, answer: answerText!, option1: option1Text!, option2: option2Text!, isExisting: isExisting)
        
            dismiss(animated: true)
        }
    }
    
    
    /*
     
    // MARK: - Navigation
     
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
