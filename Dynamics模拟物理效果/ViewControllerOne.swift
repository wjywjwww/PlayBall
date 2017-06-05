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
        let collisionBehavior = UICollisionBehavior(items: [self.blueBall])
        collisionBehavior.collisionDelegate = self
        collisionBehavior.addBoundary(withIdentifier: "floor" as NSCopying, from: CGPoint(x: 0 , y : ConvenienceTool.SCREENH_HEIGHT), to: CGPoint(x: ConvenienceTool.SCREEN_WIDTH, y: ConvenienceTool.SCREENH_HEIGHT))
        self.animator.addBehavior(collisionBehavior)
        let ballBehavior = UIDynamicItemBehavior(items: [self.blueBall])
        ballBehavior.elasticity = 0.8
        self.animator.addBehavior(ballBehavior)
        
    }
    func playBall(){
        let view1 = UIView(frame: CGRect(x: 100, y:200, width: 150, height: 20))
        view1.backgroundColor = ConvenienceTool.JYRandomColor
        view1.layer.cornerRadius = 10
        
        let view2 = UIView(frame: CGRect(x: 50, y:350, width: 150, height: 20))
        view2.backgroundColor = ConvenienceTool.JYRandomColor
        view2.layer.cornerRadius = 10
        
        let view3 = UIView(frame: CGRect(x: 150, y:500, width: 150, height: 20))
        view3.backgroundColor = ConvenienceTool.JYRandomColor
        view3.layer.cornerRadius = 10
        
        self.view.addSubview(view1)
        self.view.addSubview(view2)
        self.view.addSubview(view3)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        self.blueBall.backgroundColor = ConvenienceTool.JYRandomColor
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
