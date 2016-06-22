//
//  CustomTabAnimatedTransitioning.swift
//  CustomTabBar
//
//  Created by Adam Bardon on 01/04/16.
//  Copyright © 2016 Swift Joureny. All rights reserved.
//

import UIKit

//class CustomTabAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
//    
//    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
//        return 0.6
//    }
//    
//    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
//        if let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
//            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) {
//            let fromView = fromVC.view
//            let toView = toVC.view
//            
//            let containerView = transitionContext.containerView()!
//            
//            containerView.clipsToBounds = false
//            containerView.addSubview(toView)
//            
//            var fromViewEndFrame = fromView.frame
//            fromViewEndFrame.origin.x -= (containerView.frame.width)
//            
//            let toViewEndFrame = transitionContext.finalFrameForViewController(toVC)
//            var toViewStartFrame = toViewEndFrame
//            toViewStartFrame.origin.x += (containerView.frame.width)
//            toView.frame = toViewStartFrame
//            
//            UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
//                toView.frame = toViewEndFrame
//                fromView.frame = fromViewEndFrame
//                }, completion: { (completed) -> Void in
//                    fromView.removeFromSuperview()
//                    transitionContext.completeTransition(completed)
//                    containerView.clipsToBounds = true
//            })
//        }
//    }
//    
//}
