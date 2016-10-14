//
//  RTANavigationController.swift
//  Akhayar
//
//  Created by Thwin Htoo Aung on 10/13/16.
//  Copyright © 2016 Revo Tech. All rights reserved.
//

import UIKit

class RTANavigationController: UIViewController {
    
    
    var titleText: String!
    var buttonTitles : [String]!
    var selectedIndex: Int = 0;
    
    private var roofBarHeight: CGFloat = 64
    private var roofBarColor : UIColor = RTAColor.paleBlack
    private var roofBar : UIView!
    
    private var roofLabel : UIButton!
    private var scrollViewForButton : UIScrollView!
    private var buttons : [UIButton]!
    private var tappedIndex: Int = 0;
    
    weak var delegate : RTANavigationControllerDelegate!
    init() {
        super.init(nibName: nil, bundle: nil)
        
        initialize()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initialize()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.clear
        self.layoutRoofBar()
        self.layoutScrollView()
        self.allocateButtons()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5) { 
            self.view.backgroundColor = UIColor(white: 0.1, alpha: 0.8)
        }
        self.expandButtons()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // one way initialization
    private func initialize() {
        
        // set overlay style presentation
        self.modalPresentationStyle = .overCurrentContext
        
        // set default initial values for optional members
        self.titleText = "Akhayar"
        self.buttonTitles = [];
        self.roofBar = UIView()
        self.roofLabel = UIButton()
        self.scrollViewForButton = UIScrollView()
        self.buttons = [];
    }
    
    private func layoutRoofBar() {
        self.view.addSubview(self.roofBar!)
        self.roofBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.roofBarHeight)
        self.roofBar.backgroundColor = self.roofBarColor
        
        
        self.roofBar.addSubview(self.roofLabel)
        self.roofLabel.titleLabel?.font = UIFont(name: "Menlo", size: 18)
//        self.roofLabel.textColor = UIColor.white
        self.roofLabel.setTitleColor(UIColor.white, for: .normal)
        self.roofLabel.setTitleColor(UIColor.lightGray, for: .highlighted)
        self.roofLabel.addTarget(self, action: #selector(RTANavigationController.buttonPressEventHandle(sender:)), for: .touchUpInside)
        
        autoreleasepool{
            let midRoofBarX : CGFloat = self.roofBar.frame.size.width / 2;
            let midRoofBarY : CGFloat = (self.roofBar.frame.size.height + 20 ) / 2;
            let roofBarCenter : CGPoint = CGPoint(x: midRoofBarX, y: midRoofBarY)
        
            self.roofLabel.setTitle(self.titleText, for: .normal)
            self.roofLabel.sizeToFit()
            self.roofLabel.center = roofBarCenter;
        }
    }
    private func layoutScrollView() {
        self.view.addSubview(self.scrollViewForButton)
        self.scrollViewForButton.frame = CGRect(x: 0, y: self.roofBar.frame.origin.y + self.roofBarHeight, width: self.view.frame.size.width, height: self.view.frame.size.height - self.roofBarHeight)
        self.scrollViewForButton.showsVerticalScrollIndicator = false
        self.scrollViewForButton.backgroundColor = UIColor.clear
    }
    private func allocateButtons() {
        for i in 0 ..< self.buttonTitles.count {
            let button = UIButton()
            button.setTitle(self.buttonTitles[i], for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            
            if i == self.selectedIndex {
                button.setTitleColor(UIColor.cyan, for: .normal)
            }
            
            button.setTitleColor(UIColor.lightGray, for: UIControlState.highlighted)
            button.tintColor = UIColor.white
            button.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 18)
            button.tag = i;
            button.addTarget(self, action: #selector(RTANavigationController.buttonPressEventHandle(sender:)), for: .touchUpInside)
            self.scrollViewForButton.addSubview(button)
            button.frame = CGRect(x: 0, y: -10 * self.roofBarHeight, width: self.scrollViewForButton.frame.size.width, height: self.roofBarHeight)
//            button.backgroundColor = UIColor.lightGray
            self.buttons.append(button)
        }
    }
    private func shrinkButtons (_ completion : @escaping () -> Void) {
        var y : CGFloat = -10 * self.roofBarHeight;
        let x : CGFloat = 0;
        let width: CGFloat = self.scrollViewForButton.frame.size.width;
        let height: CGFloat = self.roofBarHeight;
        
        var delay : TimeInterval = 0;
        let duration : TimeInterval = 1;
        
        for i in 0 ..< self.buttons.count {
                UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 10, initialSpringVelocity: 10, options: [.allowUserInteraction, .curveEaseOut], animations: {
                    self.buttons[i].frame = CGRect(x: x, y: y, width: width, height: height)
                    }, completion: nil)
            delay += 0.05;
        }
        Timer.scheduledTimer(withTimeInterval: delay + 0.5, repeats: false) { (timer) in
            completion();
        }
    }
    private func expandButtons() {
        var y : CGFloat = self.roofBarHeight * CGFloat(self.buttons.count - 1);
        let x : CGFloat = 0;
        let width: CGFloat = self.scrollViewForButton.frame.size.width;
        let height: CGFloat = self.roofBarHeight;
        
        var delay : TimeInterval = 0;
        let duration : TimeInterval = 1;
        
        var contentHeight : CGFloat = 0;
        
        var i = self.buttons.count - 1;
        while i >= 0 {
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 10, initialSpringVelocity: 10, options: [.allowUserInteraction, .curveEaseOut], animations: {
                self.buttons[i].frame = CGRect(x: x, y: y, width: width, height: height)
                }, completion: nil)
            
            y -= height;
            
            delay += 0.05;
            
            contentHeight += height;
            
            i -= 1;
        }
        
        self.scrollViewForButton.contentSize = CGSize(width:width, height: contentHeight)
    }
    
    
    @objc
    private func buttonPressEventHandle (sender btn : UIButton) -> Void {
        
        let duration = 0.05 * Double(self.buttons.count);
        UIView.animate(withDuration: duration + 1) {
            self.view.backgroundColor = UIColor.clear
        }

        if btn == self.roofLabel {
            self.shrinkButtons(){
                self.dismiss(animated: false){
                    b in
                    if self.delegate != nil {
                        if self.delegate.didNavControllerDidExit != nil {
                            self.delegate.didNavControllerDidExit!()
                        }
                    }
                }
            }
        }else {
            self.tappedIndex = btn.tag
            self.shrinkButtons(){
                self.dismiss(animated: false){
                    b in
                    if self.delegate != nil {
                        if self.delegate.didNavControllerEndTappingWithButtonAtIndex != nil {
                            self.delegate.didNavControllerEndTappingWithButtonAtIndex!(self.tappedIndex)
                        }
                    }
                }
            }
        }
    }
}




@objc
protocol RTANavigationControllerDelegate{
    @objc
    optional func didNavControllerEndTappingWithButtonAtIndex(_ index: Int)
    
    @objc
    optional func didNavControllerDidExit()
}
