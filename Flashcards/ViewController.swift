//
//  ViewController.swift
//  Flashcards
//
//  Created by Sydnee Tan on 2/21/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        card.layer.cornerRadius = 20.0
        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.3
        
    }


    
    @IBAction func didTapOnFlashCard(_ sender: Any) {
        frontLabel.isHidden = !frontLabel.isHidden
    }
}

