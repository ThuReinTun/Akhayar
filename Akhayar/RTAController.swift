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
    var btn : UIButton!
    var names = ["Home", "Tech", "Lifestyle", "Videos","Home", "Tech", "Lifestyle", "Videos","Home", "Tech", "Lifestyle", "Videos","Home", "Tech", "Lifestyle", "Videos","Home", "Tech", "Lifestyle", "Videos","Home", "Tech", "Lifestyle", "Videos"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool){
        
        let topView = UIView()
        self.view.addSubview(topView)
        topView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64)
        topView.backgroundColor = UIColor(red: 0x39/0xff, green: 0x39/0xff, blue: 0x39/0xff, alpha: 1)
        
        btn = UIButton()
        topView.addSubview(btn)
        let width = topView.frame.size.width * 0.4;
        let height = topView.frame.size.height;
        btn.setTitle("Home", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.frame = CGRect(x: topView.center.x - width/2, y: 20, width: width, height: height - 20)
        btn.addTarget(self, action: #selector(RTAController.showAkhayarNavController), for: .touchUpInside)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc
    private func showAkhayarNavController() {
        self.btn.isEnabled = false
        self.akhayarNavController = RTANavigationController()
        self.akhayarNavController.buttonTitles = names;
        self.akhayarNavController.delegate = self;
        self.present(self.akhayarNavController, animated: false, completion: nil)
    }
    
    func didNavControllerEndTappingWithButtonAtIndex(_ index: Int) {
        print("tapped index : \(index)");
        self.btn.setTitle(self.names[index], for: .normal)
        self.btn.isEnabled = true;
        
    }
}
