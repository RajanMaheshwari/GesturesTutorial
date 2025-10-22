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
        
        myImageView.isUserInteractionEnabled = true
        
        //Tap
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        myImageView.addGestureRecognizer(tapGesture)
        
        //Pinch Zoom
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        myImageView.addGestureRecognizer(pinchGesture)
        
        //Rotate
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation))
        myImageView.addGestureRecognizer(rotationGesture)
        
        //Pan Translation
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        myImageView.addGestureRecognizer(panGesture)
        
        //Swipe
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        leftSwipeGesture.direction = .left
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        rightSwipeGesture.direction = .right
        
        let upSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        upSwipeGesture.direction = .up
        
        let downSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        downSwipeGesture.direction = .down
        
        self.swipeView.addGestureRecognizer(leftSwipeGesture)
        self.swipeView.addGestureRecognizer(rightSwipeGesture)
        self.swipeView.addGestureRecognizer(upSwipeGesture)
        self.swipeView.addGestureRecognizer(downSwipeGesture)
        
        //Long press
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGesture.minimumPressDuration = 1.0
        self.swipeView.addGestureRecognizer(longPressGesture)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func handleTap(recognizer:UITapGestureRecognizer){
        print("Image Tapped")
    }

    @objc func handlePinch(recognizer:UIPinchGestureRecognizer){
        guard let view = recognizer.view else{return}
        view.transform = CGAffineTransformScale(view.transform, recognizer.scale, recognizer.scale)
        recognizer.scale = 1.0
    }
    
    @objc func handleRotation(recognizer:UIRotationGestureRecognizer){
        guard let view = recognizer.view else {return}
        view.transform = CGAffineTransformRotate(view.transform, recognizer.rotation)
        recognizer.rotation = 0
    }
    
    @objc func handlePan(recognizer:UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self.view)
        guard let view = recognizer.view else{return}
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        recognizer.setTranslation(CGPointZero, in: self.view)
    }
    
    @objc func handleSwipe(recognizer:UISwipeGestureRecognizer){
        switch recognizer.direction {
        case .left:
            self.directionLabel.text = "Left"
            break
            
        case .right:
            self.directionLabel.text = "Right"
            break
            
        case .up:
            self.directionLabel.text = "Up"
            break
            
        case .down:
            self.directionLabel.text = "Down"
            break
            
        default:
            break
        }
    }
    
    @objc func handleLongPress(recognizer:UILongPressGestureRecognizer){
        if(recognizer.state == .began){
            let alert = UIAlertController(title: "Long Press", message: "Yes, It worked!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "YAY", style: .cancel, handler: { (action:UIAlertAction) -> Void in
                print("Cancelled")
            }))
            self.show(alert, sender: nil)
        }
        
        if(recognizer.state == .ended){
            print("Long Press Ended")
        }
    }

    @IBAction func pinchAction(_ sender: Any) {
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        
        secondVC.modalPresentationStyle = .fullScreen
        self.present(secondVC, animated: true, completion: nil)

    }
}


