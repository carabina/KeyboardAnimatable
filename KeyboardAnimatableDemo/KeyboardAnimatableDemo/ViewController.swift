//
//  ViewController.swift
//  KeyboardAnimatableDemo
//
//  Created by Jerome Tan on 25/08/2016.
//  Copyright © 2016 Jerome Tan. All rights reserved.
//

import UIKit
import KeyboardAnimatable

class ViewController: UIViewController, KeyboardAnimatable {

    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var toolBarBottomConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        enableKeyboardAnimation()
    }
    
    deinit {
        disableKeyboardAnimation()
    }
    
    @IBAction func toggleKeyboardButtonTapped(sender: UIBarButtonItem) {
        if textView.isFirstResponder() {
            textView.resignFirstResponder()
        } else {
            textView.becomeFirstResponder()
        }
    }
    
    
    func animateWhenKeyboardAppear(keyboardHeight keyboardHeight: CGFloat, duration: NSTimeInterval) {
        toolBarBottomConstraint.constant = keyboardHeight
        
        UIView.animateWithDuration(duration) { 
            self.view.layoutIfNeeded()
        }
    }
    
    func animateWhenKeyboardDisappear(keyboardHeight keyboardHeight: CGFloat, duration: NSTimeInterval) {
        toolBarBottomConstraint.constant = 0
        
        UIView.animateWithDuration(duration) {
            self.view.layoutIfNeeded()
        }
    }

}

