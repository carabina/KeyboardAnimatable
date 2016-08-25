//
//  KeyboardAnimatable.swift
//  MonoShare
//
//  Created by Jerome Tan on 05/08/2016.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2016 Jerome Tan
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation

private var observersKey: Void?

public protocol KeyboardAnimatable: class {
    
    /// Perform animation when keyboard appears
    ///
    /// - note: `func enableKeyboardAnimation()` must be called previously
    /// - important: `func disableKeyboardAnimation()` must be called to remove notification observers, this is typically called in `deinit` method
    /// - parameter keyboardHeight: the height of keyboard when it is fully opened
    /// - parameter duration:       the amount of time the keyboard takes to fully open
    func animateWhenKeyboardAppear(keyboardHeight keyboardHeight: CGFloat, duration: NSTimeInterval)
    
    /// Perform animation when keyboard disappears
    ///
    /// - important: `func disableKeyboardAnimation()` must be called to remove notification observers, this is typically called in `deinit` method
    /// - parameter keyboardHeight: the height of keyboard when it is fully opened
    /// - parameter duration:       the amount of time the keyboard takes to fully closed
    func animateWhenKeyboardDisappear(keyboardHeight keyboardHeight: CGFloat, duration: NSTimeInterval)
    
}

public extension KeyboardAnimatable where Self: UIViewController {
    
    
    /// Add observers to observe keboard notifications
    /// - important: `func disableKeyboardAnimation()` must be called to remove notification observers, this is typically called in `deinit` method
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
    
    /// Remove keyboard notification observers
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
