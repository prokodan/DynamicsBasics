//
//  ViewController.swift
//  DynamicsDemo
//
//  Created by Данил Прокопенко on 04.10.2022.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    
    /// Physical engine which observe object behavior and animations
    var animator: UIDynamicAnimator!
    
    /// Adding Gravity Force for Objects in ReferenceView
    var gravity: UIGravityBehavior!
    
    var collision: UICollisionBehavior!
    
//    var firstContact = false
    
    var square: UIView!
    var snap: UISnapBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adding a square to a view
        square = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        square.backgroundColor = UIColor.gray
        view.addSubview(square)
        
        //Adding a barrier to a view
        let barrier = UIView(frame: CGRect(x:0, y:300, width: 130, height: 20))
        barrier.backgroundColor = UIColor.red
        view.addSubview(barrier)
        
        
//      Initialaizing Animator and Gravity
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [square])
        
//        gravity.angle = .pi
//        gravity.magnitude = 100
        animator.addBehavior(gravity)
      
//        Creating a collision with bounds for square
        collision = UICollisionBehavior(items: [square])
        
//        Creating a boundary for barrier
        collision.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect: barrier.frame))
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        collision.collisionDelegate = self
        
        let itemBehavior = UIDynamicItemBehavior(items: [square])
        itemBehavior.elasticity = 0.6
        animator.addBehavior(itemBehavior)
//        Printing transformation logs
//        collision.action = {
//            print("\(NSCoder.string(for: square.transform)) \(NSCoder.string(for: square.center))")
//        }
        
        
    }

    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        print("Boundary contact occured: \(identifier)")
        let collidingView = item as! UIView
        collidingView.backgroundColor = UIColor.yellow
        UIView.animate(withDuration: 0.3) {
            collidingView.backgroundColor = UIColor.gray
        }
        
//        if (!firstContact) {
//            firstContact = true
//            let square = UIView(frame: CGRect(x: 30, y: 0, width: 100, height: 100))
//            square.backgroundColor = UIColor.gray
//            view.addSubview(square)
//
//            collision.addItem(square)
//            gravity.addItem(square)
////           Spring attachemt of two squares
//            let attach = UIAttachmentBehavior(item: collidingView, attachedTo: square)
//            animator.addBehavior(attach)
//        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if snap != nil {
            animator.removeBehavior(snap)
        }
            //        Programming snap behavior for square
        
        let touch = touches.first! as UITouch
            snap = UISnapBehavior(item: square, snapTo: touch.location(in: view))
            animator.addBehavior(snap)
        }
}

