//
//  PickerPresentationController.swift
//  SamplePresentation
//
//  Created by Thahir Maheen on 5/13/18.
//  Copyright © 2018 Thahir. All rights reserved.
//

import UIKit

protocol PickerPresentable {
    var pickerHeight: CGFloat { get }
}

class PickerPresentationDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PickerPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PickerPresentationAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PickerPresentationAnimator(isDismissing: true)
    }
}

extension PickerPresentationDelegate {
    class PickerPresentationController: UIPresentationController {
        
        lazy var viewGradient: UIView = configureViewGradient()
        
        private var pickerHeight: CGFloat {
            var maxHeight = presentingViewController.view.bounds.height * 0.5

            if let pickerPresentable = presentedViewController as? PickerPresentable {
                maxHeight = pickerPresentable.pickerHeight > maxHeight ? maxHeight : pickerPresentable.pickerHeight
            }
            
            return maxHeight
        }
        
        override func presentationTransitionWillBegin() {
            
            // add gradient background
            containerView?.insertSubview(viewGradient, at: 0)
            
            // fill in superview
            containerView?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[viewGradient]|", options: [], metrics: nil, views: ["viewGradient": viewGradient]))
            containerView?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[viewGradient]|", options: [], metrics: nil, views: ["viewGradient": viewGradient]))
            
            // present gradient gracefully 🤓
            presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in
                self?.viewGradient.alpha = 1.0
            })
        }
        
        override func dismissalTransitionWillBegin() {
            
            // remove gradient gracefully
            presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in
                self?.viewGradient.alpha = 0.0
            })
        }
        
        private func configureViewGradient() -> UIView {
            viewGradient = UIView()
            viewGradient.translatesAutoresizingMaskIntoConstraints = false
            viewGradient.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
            viewGradient.alpha = 0.0
            
            let gestureDismiss = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
            viewGradient.addGestureRecognizer(gestureDismiss)
            
            return viewGradient
        }
        
        @objc private func handleTap(recognizer: UITapGestureRecognizer) {
            presentingViewController.dismiss(animated: true)
        }
        
        override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
            return CGSize(width: parentSize.width, height: pickerHeight)
        }
        
        override var frameOfPresentedViewInContainerView: CGRect {
            guard let containerView = containerView else { return .zero }
            
            var frame: CGRect = .zero
            frame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerView.bounds.size)
            frame.origin.y = containerView.frame.height - pickerHeight
            return frame
        }
    }
}

extension PickerPresentationDelegate {
    class PickerPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
        
        var isDismissing = false
        
        convenience init(isDismissing: Bool) {
            self.init()
            self.isDismissing = isDismissing
        }
        
        func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            return 0.3
        }
        
        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            
            // get the controller
            let key = isDismissing ? UITransitionContextViewControllerKey.from : UITransitionContextViewControllerKey.to
            guard let controller = transitionContext.viewController(forKey: key) else { return }
            
            // add in container if we are presenting
            if !isDismissing {
                transitionContext.containerView.addSubview(controller.view)
            }
            
            // some frame math
            let presentedFrame = transitionContext.finalFrame(for: controller)
            var dismissedFrame = presentedFrame
            dismissedFrame.origin.y = transitionContext.containerView.frame.size.height
            
            // initial and final frames
            let initialFrame = isDismissing ? presentedFrame : dismissedFrame
            let finalFrame = isDismissing ? dismissedFrame : presentedFrame
            
            // animate
            let animationDuration = transitionDuration(using: transitionContext)
            controller.view.frame = initialFrame
            UIView.animate(withDuration: animationDuration, animations: {
                controller.view.frame = finalFrame
            }) { finished in
                transitionContext.completeTransition(finished)
            }
        }
    }
}
