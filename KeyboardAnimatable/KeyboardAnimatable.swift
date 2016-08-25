//
//  KeyboardAnimatable.swift
//  MonoShare
//
//  Created by Jerome Tan on 05/08/2016.
//  Copyright © 2016 Jerome Tan. All rights reserved.
//

import Foundation

private var observersKey: Void?

public protocol KeyboardAnimatable: class {
    
    /// Perform animation when keyboard appears
    ///
    /// - note: `func enableKeyboardAnimation()` must be called previously
    /// - important: `func disableKeyboardAnimation()` must be called to remove notification observers, this is typically called in `deinit` method
    /// - parameter keyboardHeight: the height of keyboard when it is fully opened
    /// - parameter duration:       the amount of time the keyboard takes to fully open
    func animateWhenKeyboardAppear(keyboardHeight: CGFloat, duration: TimeInterval)
    
    /// Perform animation when keyboard disappears
    ///
    /// - important: `func disableKeyboardAnimation()` must be called to remove notification observers, this is typically called in `deinit` method
    /// - parameter keyboardHeight: the height of keyboard when it is fully opened
    /// - parameter duration:       the amount of time the keyboard takes to fully closed
    func animateWhenKeyboardDisappear(keyboardHeight: CGFloat, duration: TimeInterval)
    
}

public extension KeyboardAnimatable where Self: UIViewController {
    
    
    /// Add observers to observe keboard notifications
    /// - important: `func disableKeyboardAnimation()` must be called to remove notification observers, this is typically called in `deinit` method
    public func enableKeyboardAnimation() {
        let appearObserver = NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillShow, object: nil, queue: nil) { [weak self] (notification) in
            guard let `self` = self else { return }
            
            if let userInfo = notification.userInfo {
                let duration: TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
                
                let frameEnd = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
                let keyboardHeight = frameEnd.height
                
                self.animateWhenKeyboardAppear(keyboardHeight: keyboardHeight, duration: duration)
            }
        }
        
        let dissappearObserver = NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillHide, object: nil, queue: nil) { [weak self] (notification) in
            guard let `self` = self else { return }
            
            if let userInfo = notification.userInfo {
                let duration: TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
                
                let frameEnd = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
                let keyboardHeight = frameEnd.height
                
                self.animateWhenKeyboardDisappear(keyboardHeight: keyboardHeight, duration: duration)
            }
        }
        
        observers = [appearObserver, dissappearObserver]
    }
    
    /// Remove keyboard notification observers
    public func disableKeyboardAnimation() {
        for observer in observers {
            NotificationCenter.default.removeObserver(observer)
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
