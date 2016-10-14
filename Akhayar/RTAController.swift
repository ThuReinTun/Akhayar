//
//  RTController.swift
//  Akhayar
//
//  Created by Thwin Htoo Aung on 10/13/16.
//  Copyright © 2016 Revo Tech. All rights reserved.
//
/*
    * This is the starting point for Akhayar
    * Add your view controllers inside this object
    * This class will serve as Controller between Model and View
    * View will be the display of UI and Model will be API calls
 */

import UIKit

class RTAController: UIViewController,
RTANavigationControllerDelegate{

    var akhayarNavController : RTANavigationController!
    var topView : UIView!
    var btn : UIButton!
    var names : [String] = []
    var selectedindex: Int = 0;
    
    private var viewControllers: [UIViewController] = [];
    
    private var baseView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        topView = UIView()
        self.view.addSubview(topView)
        topView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64)
        topView.backgroundColor = RTAColor.paleBlack
        
        btn = UIButton()
        topView.addSubview(btn)
        let width = topView.frame.size.width * 0.4;
        let height = topView.frame.size.height;
        btn.setTitle("Home", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 18)
        btn.setTitleColor(.white, for: .normal)
        btn.frame = CGRect(x: topView.center.x - width/2, y: 20, width: width, height: height - 20)
        btn.addTarget(self, action: #selector(RTAController.showAkhayarNavController), for: .touchUpInside)
        
        self.view.addSubview(baseView)
        
        
        self.layoutBaseView()
        self.initialize()
        self.setUpViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool){
        
        
//        self.initialize()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.layoutTopView()
        self.layoutBaseView()
    }
    
    // MARK:- THA internal sources
    private func setUpViews() {
        self.hideAllViewControllers()
        self.showViewController(at: self.selectedindex)
    }
    private func layoutTopView() {
        topView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64)
        topView.backgroundColor = RTAColor.paleBlack
        
        let width = topView.frame.size.width * 0.4;
        let height = topView.frame.size.height;
        btn.frame = CGRect(x: topView.center.x - width/2, y: 20, width: width, height: height - 20)
    }
    private func layoutBaseView() {
        let width = self.view.frame.size.width;
        let height = self.view.frame.size.height - self.topView.frame.size.height
        let x : CGFloat = 0;
        let y : CGFloat = self.topView.frame.size.height
        
        self.baseView.frame = CGRect(x: x, y: y, width: width, height: height)
        
        self.baseView.backgroundColor = UIColor.brown;
    }
    private func layoutViewControllers() {
        self.hideAllViewControllers()
        self.showViewController(at: self.selectedindex)
    }

    
    
    private func showViewController(at index: Int){
        
        if index >= self.viewControllers.count {
            return;
        }
        
        for i in 0 ..< self.viewControllers.count {
            if i == index{
                self.viewControllers[i].view.frame = CGRect(x: 0, y: 0, width: self.baseView.frame.size.width, height: self.baseView.frame.size.height)
                return;
            }
        }
    }
    private func hideAllViewControllers() {
        for each in viewControllers {
            each.view.frame = CGRect(x: self.baseView.frame.size.width * -1, y: 0, width: self.baseView.frame.size.width, height: self.baseView.frame.size.height)
        }
    }
    
    
    private func addViewControllers(_ viewController : UIViewController) {
        self.viewControllers.append(viewController)
        self.baseView.addSubview(viewController.view)
        var titleText = viewController.title
        if titleText == nil {
            titleText = "No Title"
        }
        self.names.append(titleText!)
    }
    @objc
    private func showAkhayarNavController() {
        
        self.akhayarNavController = nil
        // initialize akhayarNavController
        self.akhayarNavController = RTANavigationController()
        self.akhayarNavController.buttonTitles = names;
        self.akhayarNavController.delegate = self;
        self.akhayarNavController.selectedIndex = self.selectedindex;
        self.present(self.akhayarNavController, animated: false, completion: nil)
    }
    
    func didNavControllerEndTappingWithButtonAtIndex(_ index: Int) {
        print("tapped index : \(index)");
        
        // set page title
        self.btn.setTitle(self.names[index], for: .normal)
        
        // recapture the selected index
        self.selectedindex = index;
        
        // hide all view controllers first
        self.hideAllViewControllers()
        
        // reshow the selected index
        self.showViewController(at: index)
    }
    
    
    
    
    
    // MARK:- Public apis for TRT
    private func initialize() {
        // initialize your view controllers
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let homeVC = storyboard.instantiateViewController(withIdentifier: "Home")
        let techVC = storyboard.instantiateViewController(withIdentifier: "Tech")
        let lifestyleVC = storyboard.instantiateViewController(withIdentifier: "Lifestyle")
        let videoVC = storyboard.instantiateViewController(withIdentifier: "Videos")
        
        // add your view controllers through "addViewController"
        
        self.addViewControllers(homeVC)
        self.addViewControllers(techVC)
        self.addViewControllers(lifestyleVC)
        self.addViewControllers(videoVC)
    }

}
