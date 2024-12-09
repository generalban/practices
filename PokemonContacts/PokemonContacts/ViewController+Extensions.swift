//
//  ViewController+Extensions.swift
//  PokemonContacts
//
//  Created by 반성준 on 12/9/24.
//

import UIKit

extension UIViewController {
    /// Displays an alert with a title, message, and an OK button.
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in completion?() }))
        present(alert, animated: true, completion: nil)
    }

    /// Adds a child view controller and its view to the current view controller.
    func add(_ child: UIViewController, to containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.view.frame = containerView.bounds
        child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        child.didMove(toParent: self)
    }

    /// Removes the view controller from its parent.
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
