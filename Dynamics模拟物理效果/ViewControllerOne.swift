//
//  ViewControllerOne.swift
//  Dynamics模拟物理效果
//
//  Created by sks on 17/6/5.
//  Copyright © 2017年 besttone. All rights reserved.
//

import UIKit

class ViewControllerOne: UIViewController,UICollisionBehaviorDelegate {
    
    var animator : UIDynamicAnimator!
    var blueBall : UIView = UIView()
    let view1 = UIView(frame: CGRect(x: 100, y:200, width: 150, height: 20))
    let view2 = UIView(frame: CGRect(x: 50, y:350, width: 150, height: 20))
    let view3 = UIView(frame: CGRect(x: 150, y:500, width: 150, height: 20))
    let view4 = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
    var isBallRolling : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blueBall.frame = CGRect(x: ConvenienceTool.SCREEN_WIDTH / 2 - 25, y: 64, width: 50, height: 50)
        blueBall.layer.cornerRadius = 25
        blueBall.backgroundColor = UIColor.blue
        self.view.addSubview(blueBall)
        playBall()
        showGravity()
        // Do any additional setup after loading the view.
    }
    func showGravity(){
       
        animator = UIDynamicAnimator(referenceView: self.view)
        let gravityBehavior = UIGravityBehavior(items: [self.blueBall])
        self.animator.addBehavior(gravityBehavior)
        
        let collisionBehavior = UICollisionBehavior(items: [self.blueBall,self.view1,self.view2,self.view3,self.view4])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionDelegate = self
        collisionBehavior.collisionMode = UICollisionBehaviorMode.everything
        collisionBehavior.addBoundary(withIdentifier: "floor" as NSCopying, from: CGPoint(x: 0 , y : ConvenienceTool.SCREENH_HEIGHT), to: CGPoint(x: ConvenienceTool.SCREEN_WIDTH, y: ConvenienceTool.SCREENH_HEIGHT))
        self.animator.addBehavior(collisionBehavior)
        
        let ballBehavior = UIDynamicItemBehavior(items: [self.blueBall])
        ballBehavior.elasticity = 0.8
        ballBehavior.resistance = 0
        ballBehavior.friction = 0
        ballBehavior.allowsRotation = false
        self.animator.addBehavior(ballBehavior)
        
        let view1Item = UIDynamicItemBehavior(items: [self.view1,self.view2,self.view4])
        view1Item.allowsRotation = false
        view1Item.density = 10000
        self.animator.addBehavior(view1Item)
        
        let view3Item = UIDynamicItemBehavior(items: [self.view3])
        view3Item.allowsRotation = true
        self.animator.addBehavior(view3Item)
    }
    func playBall(){
        
        view1.backgroundColor = ConvenienceTool.JYRandomColor
        view1.layer.cornerRadius = 10
        
        view2.backgroundColor = ConvenienceTool.JYRandomColor
        view2.layer.cornerRadius = 10
        
        view3.backgroundColor = ConvenienceTool.JYRandomColor
        view3.layer.cornerRadius = 10
        
        self.view.addSubview(view1)
        self.view.addSubview(view2)
        self.view.addSubview(view3)
        
        view4.backgroundColor = ConvenienceTool.JYRandomColor
        view4.layer.cornerRadius = 15
        view4.center = CGPoint(x: ConvenienceTool.SCREEN_WIDTH / 2, y: ConvenienceTool.SCREENH_HEIGHT - 30)
        self.view.addSubview(view4)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewControllerOne.panClick(sender:)))
        view4.addGestureRecognizer(pan)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func panClick(sender : UIGestureRecognizer){
        if sender.state == UIGestureRecognizerState.changed{
            let point = sender.location(in: self.view)
            self.view4.center = point
            self.animator.updateItem(usingCurrentState: self.view4)
        }
    }
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        self.blueBall.backgroundColor = ConvenienceTool.JYRandomColor
        
    }
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        if (item2 as! UIView) == self.view4 && (item1 as! UIView) == self.blueBall{
            let pushBehavior = UIPushBehavior(items: [self.blueBall], mode: UIPushBehaviorMode.instantaneous)
            pushBehavior.magnitude = 1.5
            self.animator.addBehavior(pushBehavior)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !self.isBallRolling{
            let pushBehavior = UIPushBehavior(items: [self.blueBall], mode: UIPushBehaviorMode.instantaneous)
            pushBehavior.magnitude = 1.5
            self.animator.addBehavior(pushBehavior)
            self.isBallRolling = true
        }else{
            super.touchesBegan(touches, with: event)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
