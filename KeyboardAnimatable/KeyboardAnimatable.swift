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
    
    func animateWhenKeyboardAppear(keyboardHeight: CGFloat, duration: TimeInterval)
    func animateWhenKeyboardDisappear(keyboardHeight: CGFloat, duration: TimeInterval)
    
}

public extension KeyboardAnimatable where Self: UIViewController {
    
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
