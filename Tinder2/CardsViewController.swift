//
//  CardsViewController.swift
//  Tinder2
//
//  Created by Richard Du on 4/26/17.
//  Copyright © 2017 Richard. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    var cardInitialCenter: CGPoint!
    
    @IBOutlet weak var cardImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onCardPan(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: self.view) as CGPoint
        
        let translation = sender.translation(in: self.view)
        //cardImageView.transform = CGAffineTransform(rotationAngle: CGFloat(45 * M_PI / 180))
        
        if sender.state == .began {
            if cardInitialCenter == nil {
                cardInitialCenter = cardImageView.frame.origin
            }
            print("Gesture began")
        } else if sender.state == .changed {
            cardImageView.center = CGPoint(x:cardImageView.center.x + translation.x, y: cardImageView.center.y)
            print("Gesture is changing")
            
            if translation.x > 0 {
                if location.y < cardInitialCenter.y {
                    cardImageView.transform = cardImageView.transform.rotated(by: CGFloat(2 * M_PI / 180))
                }
                else {
                    cardImageView.transform = cardImageView.transform.rotated(by: CGFloat(-2 * M_PI / 180))
                    
                }
            }
            if translation.x < 0 {
                if location.y < cardInitialCenter.y {
                    cardImageView.transform = cardImageView.transform.rotated(by: CGFloat(-2 * M_PI / 180))
                }
                else {
                    cardImageView.transform = cardImageView.transform.rotated(by: CGFloat(2 * M_PI / 180))
                }
            }
            sender.setTranslation(CGPoint.zero, in: self.view)
        } else if sender.state == .ended {
            print("Gesture ended")
            UIView.animate(withDuration: 0.5, animations: {
                if self.cardImageView.frame.origin.x - self.cardInitialCenter.x > 50 {
                    if location.y < self.cardInitialCenter.y {
                        self.cardImageView.transform = self.cardImageView.transform.rotated(by: CGFloat(2 * M_PI / 180))
                        self.cardImageView.frame.origin.x += 20
                    }
                    else {
                        self.cardImageView.transform = self.cardImageView.transform.rotated(by: CGFloat(-2 * M_PI / 180))
                        self.cardImageView.frame.origin.x += 20
                        
                    }

                }
                else if self.cardImageView.frame.origin.x - self.cardInitialCenter.x < -50 {
                    if location.y < self.cardInitialCenter.y {
                        self.cardImageView.transform = self.cardImageView.transform.rotated(by: CGFloat(-2 * M_PI / 180))
                        self.cardImageView.frame.origin.x -= 20
                    }
                    else {
                        self.cardImageView.transform = self.cardImageView.transform.rotated(by: CGFloat(2 * M_PI / 180))
                        self.cardImageView.frame.origin.x -= 20
                    }
                }
                else {
                    self.cardImageView.transform = CGAffineTransform.identity
                    self.cardImageView.frame.origin.y = self.cardInitialCenter.y
                    self.cardImageView.frame.origin.x = self.cardInitialCenter.x
                }
            })
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
