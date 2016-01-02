//
//  ViewController.swift
//  GestureTutorial
//
//  Created by Rajan Maheshwari on 02/01/16.
//  Copyright © 2016 Rajan Maheshwari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var swipeView: UIView!
    @IBOutlet weak var myImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myImageView.userInteractionEnabled = true
        
        //Tap
        let tapGesture = UITapGestureRecognizer(target: self, action: "handleTap:")
        myImageView.addGestureRecognizer(tapGesture)
        
        //Pinch Zoom
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: "handlePinch:")
        myImageView.addGestureRecognizer(pinchGesture)
        
        //Rotate
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: "handleRotation:")
        myImageView.addGestureRecognizer(rotationGesture)
        
        //Pan Translation
        let panGesture = UIPanGestureRecognizer(target: self, action: "handlePan:")
        myImageView.addGestureRecognizer(panGesture)
        
        //Swipe
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        leftSwipeGesture.direction = .Left
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        rightSwipeGesture.direction = .Right
        
        let upSwipeGesture = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        upSwipeGesture.direction = .Up
        
        let downSwipeGesture = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        downSwipeGesture.direction = .Down
        
        self.swipeView.addGestureRecognizer(leftSwipeGesture)
        self.swipeView.addGestureRecognizer(rightSwipeGesture)
        self.swipeView.addGestureRecognizer(upSwipeGesture)
        self.swipeView.addGestureRecognizer(downSwipeGesture)
        
        //Long press
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: "handleLongPress:")
        longPressGesture.minimumPressDuration = 1.0
        self.swipeView.addGestureRecognizer(longPressGesture)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func handleTap(recognizer:UITapGestureRecognizer){
        print("Image Tapped")
    }

    func handlePinch(recognizer:UIPinchGestureRecognizer){
        guard let view = recognizer.view else{return}
        view.transform = CGAffineTransformScale(view.transform, recognizer.scale, recognizer.scale)
        recognizer.scale = 1.0
    }
    
    func handleRotation(recognizer:UIRotationGestureRecognizer){
        guard let view = recognizer.view else {return}
        view.transform = CGAffineTransformRotate(view.transform, recognizer.rotation)
        recognizer.rotation = 0
    }
    
    func handlePan(recognizer:UIPanGestureRecognizer){
        let translation = recognizer.translationInView(self.view)
        guard let view = recognizer.view else{return}
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        recognizer.setTranslation(CGPointZero, inView: self.view)
    }
    
    func handleSwipe(recognizer:UISwipeGestureRecognizer){
        switch recognizer.direction{
        case UISwipeGestureRecognizerDirection.Left:
            self.directionLabel.text = "Left"
            break
            
        case UISwipeGestureRecognizerDirection.Right:
            self.directionLabel.text = "Right"
            break
            
        case UISwipeGestureRecognizerDirection.Up:
            self.directionLabel.text = "Up"
            break
            
        case UISwipeGestureRecognizerDirection.Down:
            self.directionLabel.text = "Down"
            break
            
        default:
            break
        }
    }
    
    func handleLongPress(recognizer:UILongPressGestureRecognizer){
        if(recognizer.state == .Began){
            let alert = UIAlertController(title: "Long Press", message: "Yes, It worked!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "YAY", style: .Cancel, handler: { (action:UIAlertAction) -> Void in
                print("Cancelled")
            }))
            self.showViewController(alert, sender: nil)
        }
        
        if(recognizer.state == .Ended){
            print("Long Press Ended")
        }
    }
    @IBAction func pinchZoomButtonAction(sender: AnyObject) {
        
        let secondVC = self.storyboard?.instantiateViewControllerWithIdentifier("SecondViewController") as! SecondViewController
        
        self.presentViewController(secondVC, animated: true, completion: nil)
    }
}


