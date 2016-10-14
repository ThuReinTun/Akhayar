//
//  FloatingAlertController.swift
//  OXO
//
//  Created by Thwin Htoo Aung on 10/10/16.
//  Copyright © 2016 Revo Tech. All rights reserved.
//

import UIKit

class FloatingAlertController: UIViewController {

    private var floatingView : UIView!
    
    private var actionButtons : [UIButton]!
    private var actionTitles : [String]!
    private var actionBlocks  : [() -> Void]!
    
    private var titleLabel : UILabel!
    private var messageLabel : UILabel!
    
    private var titleValue : String!
    private var messageValue : String!
    
    private var pan: UIPanGestureRecognizer!
    
    init(_ title : String, message : String) {
        super.init(nibName: nil, bundle: nil)
        self.initialize(title : title, message : message)
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(white: 0.1, alpha: 0.0)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.1, animations: {
            self.view.backgroundColor = UIColor(white: 0.1, alpha: 0.4)
        }) {
            (b) in
            self.showAlertView()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initialize(title : String, message : String){
        
        self.modalPresentationStyle = .overCurrentContext
        
        self.floatingView = UIView()
        self.floatingView.backgroundColor = UIColor.white;
        self.floatingView.layer.cornerRadius = 5;
//        self.floatingView.clipsToBounds = true
        
        self.actionButtons = [];
        self.actionTitles = [];
        self.actionBlocks = [];
        
        self.titleValue = title;
        self.messageValue = message;
        
        self.titleLabel = UILabel()
        self.titleLabel.numberOfLines = 5;
        self.titleLabel.font = UIFont(name: "Menlo", size: 18)
        self.titleLabel.textAlignment = .center;
        
        self.messageLabel = UILabel()
        self.messageLabel.font = UIFont(name: "Menlo", size: 15)
        self.messageLabel.numberOfLines = 10;
        self.messageLabel.textAlignment = .center;
        self.messageLabel.textColor = UIColor.gray
        
        self.pan = UIPanGestureRecognizer()
        self.floatingView.addGestureRecognizer(self.pan)
        self.pan.addTarget(self, action: #selector(FloatingAlertController.panMovement(sender:)) )
    }
    private func showAlertView() {
        self.view.addSubview(self.floatingView)
        
//        autoreleasepool{
//            
//        }
        autoreleasepool{
            let floatingViewX : CGFloat = 0;
            let floatingViewY : CGFloat = 0;
            let floatingViewWidth : CGFloat = self.view.frame.size.width * 0.8
            let floatingViewPadding : CGFloat = (self.view.frame.size.width * 0.2) / 2
            let floatingViewHeight : CGFloat = 0
            let floatingViewFrame = CGRect(x: floatingViewX + floatingViewPadding, y: floatingViewY, width: floatingViewWidth, height: floatingViewHeight)
            
            self.floatingView.frame = floatingViewFrame
            let maxWidth : CGFloat = 300
            if self.floatingView.frame.size.width > maxWidth {
                self.floatingView.frame.size.width = maxWidth;
                self.floatingView.frame.origin.x = self.view.center.x - 100
            }
        }
        
        var totalHeight : CGFloat = 0;
        
        // set title label
        self.floatingView.addSubview(self.titleLabel)
        self.titleLabel.text = self.titleValue
        
        // set message Label
        self.floatingView.addSubview(self.messageLabel)
        self.messageLabel.text = self.messageValue
        
        // layout title label
        self.titleLabel.frame = CGRect(x: 0, y: 0, width: self.floatingView.frame.size.width, height: 30)
        totalHeight += 30
        
        // layout message label
        self.messageLabel.frame = CGRect(x: 0, y: 40, width: self.floatingView.frame.size.width, height: 50)
        totalHeight += 50
        
        var buttonX : CGFloat = 0;
        var buttonY : CGFloat = totalHeight;
        var buttonWidth : CGFloat = self.floatingView.frame.size.width / 2;
        let buttonHeight : CGFloat = 50;
        totalHeight += buttonHeight
        for i in 0 ..< self.actionTitles.count {
            let button = UIButton()
            button.setTitle(self.actionTitles[i], for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont(name: "menlo", size: 15)
            button.tag = i;
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor(white: 0.1, alpha: 0.1).cgColor
            button.addTarget(self, action: #selector(FloatingAlertController.buttonPressEvent(sender:)), for: .touchUpInside)
            self.actionButtons.append(button)
            
            self.floatingView.addSubview(button)
            
            if self.actionTitles.count % 2 != 0 {
                if i == self.actionTitles.count - 1 {
                    buttonWidth = self.floatingView.frame.size.width
                }
            }
            
            button.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
            buttonX += buttonWidth
            
            if (i + 1) % 2 == 0 {
                buttonX = 0;
                buttonY += buttonHeight
                
                if i != self.actionTitles.count - 1 {
                    totalHeight += buttonHeight
                }
                
            }
        }

        self.floatingView.frame.size.height = totalHeight
        
        self.floatingView.center = self.view.center;
    }
    private func hideAlertView( _ block : @escaping () -> Void ) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.floatingView.alpha = 0.0;
            self.view.backgroundColor = UIColor.clear
            }) { (b) in
                for each in self.actionButtons {
                    each.removeFromSuperview()
                }
                self.messageLabel.removeFromSuperview()
                self.titleLabel.removeFromSuperview()
                self.floatingView.removeFromSuperview()
                
                block()
        }
        
        
    }
    private func deallocateMembers() {
        self.floatingView = nil
        
        self.actionButtons = nil
        self.actionTitles = nil
        self.actionBlocks = nil
        
        self.titleValue = nil
        self.messageValue = nil
        
        self.titleLabel = nil
        self.messageLabel = nil
    }
    @objc
    private func buttonPressEvent(sender button : UIButton) {
        print("button with tag : \(button.tag) is pressed")
        
        self.hideAlertView{
            let block = self.actionBlocks[button.tag]
            self.deallocateMembers()
            self.dismiss(animated: false, completion: block)
        }
        
    }
    @objc
    private func panMovement(sender pan : UIPanGestureRecognizer) {
        
        func degToRad(_ deg : CGFloat) -> CGFloat {
            let pi = CGFloat(M_PI)
            return deg * (pi / 180)
        }
        
        switch pan.state {
        case .ended:
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 30, initialSpringVelocity: 30, options: [.allowUserInteraction, .curveEaseOut], animations: {
//                self.floatingView.transform = CGAffineTransform(rotationAngle: 0)
                self.floatingView.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: nil)
            
            break;
        default:
            let translation = pan.translation(in: self.view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 30, initialSpringVelocity: 30, options: [.allowUserInteraction, .curveEaseOut], animations: {
//                self.floatingView.transform = CGAffineTransform(rotationAngle: 0)
                self.floatingView.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
//                self.floatingView.center = location;
                }, completion: nil)
            
//            pan.setTranslation(CGPoint(x:0, y:0), in: self.view)
            break;
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

    open func addAction(_ title: String, actionBlock : @escaping () -> Void ) {
        
        self.actionTitles.append(title)
        self.actionBlocks.append(actionBlock)
    }
}
