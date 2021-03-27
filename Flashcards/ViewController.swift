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
    var option1: String
    var option2: String
}

class ViewController: UIViewController {
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var flashcards = [Flashcard]()
    var currentIndex = 0
    var correctAnswerButton: UIButton!
    
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, option1: dictionary["option1"]!, option2: dictionary["option2"]!)
            }
            
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    

    
    @IBAction func didTapOnFlashCard(_ sender: Any) {
        flipFlashcard()
    }
    
    func flipFlashcard(){
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight) {
            self.frontLabel.isHidden = !self.frontLabel.isHidden
        }
        
        if frontLabel.isHidden == false {
            Button1.isEnabled = true;
            Button2.isEnabled = true;
            Button3.isEnabled = true;
            Button1.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            Button2.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            Button3.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
           
        }
        
    }
    
    
    @IBAction func didTapButton1(_ sender: Any) {
        if Button1 == correctAnswerButton{
            flipFlashcard()
        }else{
            frontLabel.isHidden = false
            Button1.isEnabled = false
            
        }
        if Button1.isEnabled == true{
            Button1.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        } else{
            Button1.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        }
    }
    
    
    @IBAction func didTapButton2(_ sender: Any) {
        if Button2 == correctAnswerButton{
            flipFlashcard()
        }else{
            frontLabel.isHidden = false
            Button2.isEnabled = false
        }
        if Button2.isEnabled == true{
            Button2.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        } else{
            Button2.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        }
    }
    
    @IBAction func didTapButton3(_ sender: Any) {
        if Button3 == correctAnswerButton{
            flipFlashcard()
        }else{
            frontLabel.isHidden = false
            Button3.isEnabled = false
        }
        if Button3.isEnabled == true{
            Button3.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        } else{
            Button3.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        }
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        
        
        
        updateNextPrevButtons()
        animatePrevCard()
    }
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        
        
        updateNextPrevButtons()
        animateCardOut()
        
    }
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Flashcard", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in self.deleteCurrentFlashcard()
        }
        alert.addAction(deleteAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func deleteCurrentFlashcard(){
        if flashcards.count != 1{
            flashcards.remove(at: currentIndex)
        
            if currentIndex > flashcards.count - 1{
                currentIndex = flashcards.count - 1
            }
            updateNextPrevButtons()
            updateLabels()
            
            saveAllFlashcardsToDisk()
        }else{
            let alert = UIAlertController(title: "Error", message: "Must have at least one flashcard", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            
            alert.addAction(okAction)
            present(alert, animated: true)
            
        }
    }
    
    func updateLabels(){
        let currentFlashcard = flashcards[currentIndex]
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
        
        let buttons = [Button1, Button2, Button3].shuffled()
        let answers = [currentFlashcard.answer, currentFlashcard.option1, currentFlashcard.option2].shuffled()
        for (button, answer) in zip(buttons, answers){
            button?.setTitle(answer, for: .normal)
            
            if answer == currentFlashcard.answer{
                correctAnswerButton = button
            }
        }
        
        
    }
    
    func updateFlashcard(question: String, answer: String, option1: String, option2: String, isExisting: Bool)  {
        let flashcard = Flashcard(question: question, answer: answer, option1: option1, option2: option2)
        if isExisting{
            flashcards[currentIndex] = flashcard
        }else{
            flashcards.append(flashcard)
        
            print("Added new flashcard :)")
            print("We now have \(flashcards.count) flashcards")
            
            currentIndex = flashcards.count - 1
            print("Our current index is \(currentIndex)")
        }
        updateNextPrevButtons()
        
        updateLabels()
        
        saveAllFlashcardsToDisk()
        
    }
    
    func updateNextPrevButtons(){
        if currentIndex == flashcards.count - 1{
            nextButton.isEnabled = false
        }else{
            nextButton.isEnabled = true
        }
        
        if currentIndex == 0{
            prevButton.isEnabled = false
        }else{
            prevButton.isEnabled = true
        }
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
    
    func saveAllFlashcardsToDisk(){
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer, "option1": card.option1, "option2": card.option2]
        }
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        print("Yay! Flashcards saved to UserDefaults")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // First start with smaller, invisible flashcard
        card.alpha = 0.0
        card.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        Button1.alpha = 0.0
        Button1.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        Button2.alpha = 0.0
        Button2.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        Button3.alpha = 0.0
        Button3.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.card.alpha = 1.0
            self.card.transform = CGAffineTransform.identity
            self.Button1.alpha = 1.0
            self.Button1.transform = CGAffineTransform.identity
            self.Button2.alpha = 1.0
            self.Button2.transform = CGAffineTransform.identity
            self.Button3.alpha = 1.0
            self.Button3.transform = CGAffineTransform.identity
        })}
    
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
       
        
        readSavedFlashcards()
        if flashcards.count == 0{
            updateFlashcard(question: "What is the capital of Malaysia?", answer: "Kuala Lumpur", option1: "Ipoh", option2: "Penang", isExisting: false)
        }
        updateLabels()
        updateNextPrevButtons()
        
        
    }
    
    
    func animateCardOut(){UIView.animate(
        withDuration: 0.2, animations: {self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)}, completion: {finished in
            self.updateLabels()
            self.animateCardIn()
        })
        
    }
    
    func animateCardIn(){
        card.transform = CGAffineTransform.identity.translatedBy(x:300.0, y: 0.0)
        
        UIView.animate(withDuration: 0.2) { self.card.transform = CGAffineTransform.identity}
        
    }
    
    func animatePrevCard(){
        UIView.animate(withDuration: 0.2, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x:300, y:0.0)
        }, completion: {finished in
            self.updateLabels()
            self.animatePrevCardIn()
        })
    }
    
    func animatePrevCardIn(){
        card.transform = CGAffineTransform.identity.translatedBy(x: -300, y: 0.0)
        UIView.animate(withDuration: 0.2){
            self.card.transform = CGAffineTransform.identity
        }
    }
}

