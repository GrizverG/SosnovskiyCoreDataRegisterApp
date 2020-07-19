//
//  UIViewExtension.swift
//  SosnovskiyVTBCoreDataCarStorage
//
//  Created by Gregory Pinetree on 14.07.2020.
//  Copyright © 2020 Gregory Pinetree. All rights reserved.
//

import UIKit
import Foundation

// Syntactic sugar extension
extension UIView {
    
    // MARK: - Pin
    func pin(superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
    
    // MARK: - Add to left anchor
    func addToLeft(anchor: NSLayoutXAxisAnchor, multiplier: Int) {
        leadingAnchor.constraint(equalTo: anchor, constant: CGFloat(multiplier)).isActive = true
    }
    
    // MARK: - Add to right anchor
    func addToRight(anchor: NSLayoutXAxisAnchor, multiplier: Int) {
        trailingAnchor.constraint(equalTo: anchor, constant: CGFloat(multiplier)).isActive = true
    }
    
    // MARK: - Add to top anchor
    func addToTop(anchor: NSLayoutYAxisAnchor, multiplier: Int) {
        topAnchor.constraint(equalTo: anchor, constant: CGFloat(multiplier)).isActive = true
    }
    
    // MARK: - Add to botom anchor
    func addToBottom(anchor: NSLayoutYAxisAnchor, multiplier: Int) {
        bottomAnchor.constraint(equalTo: anchor, constant: CGFloat(multiplier)).isActive = true
    }
    
    // MARK: - Set height anchor
    func height(_ height: Int) {
        heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
    }
    
    // MARK: - Set width anchor
    func width(_ width: Int) {
        widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
    }
    
    // MARK: - Hide or show
    func hideOrShow(_ button: UIButton?) {
        if isHidden {
            button?.isHidden = false
            alpha = 0
            isHidden = false
        } else {
            button?.isHidden = true
        }

        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = abs(1 - self.alpha)
        }) {
            (finished) in
            if (self.alpha == 0 && finished) {
                self.isHidden = true
            }
        }
    }
}
