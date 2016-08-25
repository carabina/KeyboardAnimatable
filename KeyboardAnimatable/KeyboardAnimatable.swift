//
//  KeyboardAnimatable.swift
//  MonoShare
//
//  Created by Jerome Tan on 05/08/2016.
//  Copyright © 2016 Jerome Tan. All rights reserved.
//

import UIKit

private var observersKey: Void?

public protocol KeyboardAnimatable: class {
    
    func animateWhenKeyboardAppear(keyboardHeight keyboardHeight: CGFloat, duration: NSTimeInterval)
    func animateWhenKeyboardDisappear(keyboardHeight keyboardHeight: CGFloat, duration: NSTimeInterval)
    
}

public extension KeyboardAnimatable where Self: UIViewController {
    
    public func enableKeyboardAnimation() {
        let appearObserver = NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillShowNotification, object: nil, queue: nil) { [weak self] (notification) in
            guard let `self` = self else { return }
            
            if let userInfo = notification.userInfo {
                let duration: NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
                
                let frameEnd = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
                let keyboardHeight = frameEnd.height
                
                self.animateWhenKeyboardAppear(keyboardHeight: keyboardHeight, duration: duration)
            }
        }
        
        let dissappearObserver = NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillHideNotification, object: nil, queue: nil) { [weak self] (notification) in
            guard let `self` = self else { return }
            
            if let userInfo = notification.userInfo {
                let duration: NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
                
                let frameEnd = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
                let keyboardHeight = frameEnd.height
                
                self.animateWhenKeyboardDisappear(keyboardHeight: keyboardHeight, duration: duration)
            }
        }
        
        observers = [appearObserver, dissappearObserver]
    }
    
    public func disableKeyboardAnimation() {
        for observer in observers {
            NSNotificationCenter.defaultCenter().removeObserver(observer)
        }
        observers.removeAll()
    }
    
    
    private var observers: [NSObjectProtocol] {
        get {
            return objc_getAssociatedObject(self, &observersKey) as? [NSObjectProtocol] ?? []
        }
        set {
            objc_setAssociatedObject(self, &observersKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

}
