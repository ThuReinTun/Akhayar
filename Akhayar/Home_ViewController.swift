//
//  ViewController.swift
//  Akhayar
//
//  Created by Thwin Htoo Aung on 10/13/16.
//  Copyright © 2016 Revo Tech. All rights reserved.
//

import UIKit

class Home_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
        let topNaviView : UIView = UIView()
            // topNaviView subviews
            let topNaviTitle : UILabel = UILabel()
            let btnMenu : UIButton = UIButton()
            let btnSearch : UIButton = UIButton()
        let topSelectiveView : UIView = UIView()
            // topCatalogView subviews
            let selectivePost_One : UIButton = UIButton()
            let selectivePost_Two : UIButton = UIButton()
            let selectivePost_Three : UIButton = UIButton()
        // catalog table views
        let selectivePost_TableView_One : UITableView = UITableView()
        let selectivePost_TableView_Two : UITableView = UITableView()
        let selectivePost_TableView_Three : UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        implementationsForViewDidAppear()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        implementationForViewDidLoad()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
        // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return 5
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
            
            return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
        // MARK: - implementations for - viewDidAppear - viewDidLoad
    
    func implementationsForViewDidAppear () {
        self.view.backgroundColor = UIColor.white
        // setting topNaviView
        topNaviView.frame = CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: self.view.frame.size.width, height: 64)
        topNaviView.backgroundColor = UIColor(red: 0x39/0xff, green: 0x39/0xff, blue: 0x39/0xff, alpha: 1)
        // setting topNaviView subviews
        topNaviTitle.frame = CGRect(x: self.topNaviView.bounds.origin.x + (self.topNaviView.frame.size.width / 3), y: self.topNaviView.bounds.origin.y + 27, width: self.topNaviView.frame.size.width / 3, height: 30)
        topNaviTitle.text = "Home"
        topNaviTitle.textAlignment = .center
        topNaviTitle.textColor = UIColor.white
        topNaviTitle.font = UIFont(name: "Menlo", size: 20)
        
        btnMenu.frame = CGRect (x: self.topNaviView.bounds.origin.x + 10, y: self.topNaviView.bounds.origin.y + 27, width: 30, height: 30)
        btnMenu.setImage(UIImage(named: "btnMenu"), for: .normal)
        btnSearch.frame = CGRect (x: self.topNaviView.bounds.origin.x + (self.topNaviView.frame.size.width - 40), y: self.topNaviView.bounds.origin.y + 27, width: 30, height: 30)
        btnSearch.setImage(UIImage(named: "btnMenu"), for: .normal)
        // setting topSelectiveView
        topSelectiveView.frame = CGRect(x: self.view.bounds.origin.x + (self.view.frame.size.width * 0.01), y: self.topNaviView.frame.origin.y + self.topNaviView.frame.size.height, width: self.view.frame.size.width * 0.98, height: 43)
        topSelectiveView.backgroundColor = UIColor.white
        // topSelectiveView sub views
        var catalogOriginX : CGFloat = self.topSelectiveView.bounds.origin.x
        let catalogOriginY : CGFloat = self.topSelectiveView.bounds.origin.y + 6
        let catalogSizeWidth : CGFloat = self.topSelectiveView.frame.size.width / 3
        //catalogOriginX + 5 to overlap below catalogTwo
        self.selectivePost_One.frame = CGRect(x: catalogOriginX, y: catalogOriginY, width: catalogSizeWidth + 5, height: 30)
        catalogOriginX += catalogSizeWidth
        self.selectivePost_Two.frame = CGRect(x: catalogOriginX, y: catalogOriginY, width: catalogSizeWidth, height: 30)
        catalogOriginX += catalogSizeWidth
        //catalogOriginX - 5 and catalog SizeWidth + 5 to overlap below catalogTwo
        self.selectivePost_Three.frame = CGRect(x: catalogOriginX - 5, y: catalogOriginY, width: catalogSizeWidth + 5, height: 30)
        // to overlap above catalogOne and catalogThree
        topSelectiveView.bringSubview(toFront: selectivePost_Two)
        
        // setting selectiveTableView
        selectivePost_TableView_One.frame = CGRect(x: self.view.bounds.origin.x, y: self.topSelectiveView.frame.origin.y + self.topSelectiveView.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height - (self.topSelectiveView.frame.size.height + topNaviView.frame.size.height))
        selectivePost_TableView_One.separatorColor = UIColor.red
        selectivePost_TableView_Two.frame = CGRect(x: self.selectivePost_TableView_One.frame.origin.x + self.selectivePost_TableView_One.frame.size.width, y: self.selectivePost_TableView_One.frame.origin.y, width: self.selectivePost_TableView_One.frame.size.width, height: self.view.frame.size.height)
        selectivePost_TableView_Two.separatorColor = UIColor.blue
        selectivePost_TableView_Three.frame = CGRect(x: self.selectivePost_TableView_Two.frame.origin.x + self.selectivePost_TableView_Two.frame.size.width, y: self.selectivePost_TableView_One.frame.origin.y, width: self.selectivePost_TableView_One.frame.size.width, height: self.view.frame.size.height)
        selectivePost_TableView_Three.separatorColor = UIColor.green
        
        selectivePost_One.setTitle("Most Viewed", for: .normal)
        selectivePost_Two.setTitle("Trending", for: .normal)
        selectivePost_Three.setTitle("Fresh Updates", for: .normal)
        
        // call func to set layer decoration
        setSelectorTable_layer(table: self.selectivePost_TableView_One, btnView: self.selectivePost_One)
        setSelectorTable_layer(table: self.selectivePost_TableView_Two, btnView: self.selectivePost_Two)
        setSelectorTable_layer(table: self.selectivePost_TableView_Three, btnView: self.selectivePost_Three)
    }
    
    func implementationForViewDidLoad () {
        self.view.addSubview(topNaviView)
        // topNaviView subviews
        topNaviView.addSubview(topNaviTitle)
        topNaviView.addSubview(btnMenu)
        topNaviView.addSubview(btnSearch)
        self.view.addSubview(topSelectiveView)
        // topCatalogView subviews
        topSelectiveView.addSubview(selectivePost_One)
        topSelectiveView.addSubview(selectivePost_Two)
        topSelectiveView.addSubview(selectivePost_Three)
        self.view.addSubview(selectivePost_TableView_One)
        self.view.addSubview(selectivePost_TableView_Two)
        self.view.addSubview(selectivePost_TableView_Three)
        self.selectivePost_One.addTarget(self, action: #selector(updateSelectorTables), for: UIControlEvents.touchDown)
        self.selectivePost_Two.addTarget(self, action: #selector(updateSelectorTables), for: UIControlEvents.touchDown)
        self.selectivePost_Three.addTarget(self, action: #selector(updateSelectorTables), for: UIControlEvents.touchDown)
        
//        self.selectivePost_TableView_One.dataSource = self
//        self.selectivePost_TableView_Two.dataSource = self
//        self.selectivePost_TableView_Three.dataSource = self
    }
    // MARK: - UIButton actions
    
    func updateSelectorTables (sender : UIButton) {
        // updating selective post colors
        setDefaultColors_selectivePosts()
        sender.backgroundColor = UIColor.black
        sender.setTitleColor(UIColor.white, for: .normal)
        switch sender {
        case selectivePost_One:
            UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
                self.selectivePost_TableView_One.frame.origin.x = self.view.bounds.origin.x
                
                self.selectivePost_TableView_Two.frame.origin.x = self.view.bounds.origin.x + self.selectivePost_TableView_One.frame.size.width
                self.selectivePost_TableView_Three.frame.origin.x = self.view.bounds.origin.x + (self.selectivePost_TableView_One.frame.size.width * 2)
                }, completion: { (finished) in
                    
            })
            break
        case selectivePost_Two:
            UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
                self.selectivePost_TableView_Two.frame.origin.x = self.view.bounds.origin.x
                
                self.selectivePost_TableView_One.frame.origin.x = self.view.bounds.origin.x - self.selectivePost_TableView_One.frame.size.width
                self.selectivePost_TableView_Three.frame.origin.x = self.view.bounds.origin.x + self.selectivePost_TableView_One.frame.size.width
                }, completion: { (finished) in
                    
            })
            break
        case selectivePost_Three:
            UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
                self.selectivePost_TableView_Three.frame.origin.x = self.view.bounds.origin.x
                
                self.selectivePost_TableView_One.frame.origin.x = self.view.bounds.origin.x - self.selectivePost_TableView_One.frame.size.width
                self.selectivePost_TableView_Two.frame.origin.x = self.view.bounds.origin.x - (self.selectivePost_TableView_One.frame.size.width * 2)
                }, completion: { (finished) in
                    
            })
            break
        default:
            break
        }
    }
    
    // MARK: - Custom reusable functions
    
    func setDefaultColors_selectivePosts () {
        selectivePost_One.backgroundColor = UIColor.white
        selectivePost_One.setTitleColor(UIColor.black, for: .normal)
        selectivePost_Two.backgroundColor = UIColor.white
        selectivePost_Two.setTitleColor(UIColor.black, for: .normal)
        selectivePost_Three.backgroundColor = UIColor.white
        selectivePost_Three.setTitleColor(UIColor.black, for: .normal)
    }
    
    func setSelectorTable_layer (table : UITableView, btnView : UIButton) {
        switch btnView {
        case selectivePost_TableView_One:
            btnView.layer.cornerRadius = 5
            break
        case selectivePost_TableView_Two:
            btnView.layer.cornerRadius = 0
            break
        case selectivePost_TableView_Three:
            btnView.layer.cornerRadius = 5
            break
        default:
            break
        }
        btnView.backgroundColor = UIColor.white
        btnView.layer.borderColor = UIColor.black.cgColor
        btnView.layer.borderWidth = 1
        
        btnView.setTitleColor(UIColor.black, for: .normal)
        btnView.titleLabel?.textAlignment = .center
        btnView.titleLabel?.font = UIFont(name: "Menlo", size: 10)
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

