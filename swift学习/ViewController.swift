//
//  ViewController.swift
//  swift学习
//
//  Created by JGPeng on 16/11/8.
//  Copyright © 2016年 彭金光. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginView = LoginView.init(frame: self.view.bounds)
        self.view.addSubview(loginView)
        /**
         *  闭包数值的传递
         */
        loginView.getValueBlock = {(name:String,password:String,phone:String) in
            DDLog("姓名：\(name)密码：\(password)手机号：\(phone)")
            let dict = NSMutableDictionary()
            dict["username"] = name
            dict["password"] = password
            dict["telephone"] = phone
            DDLog("\(dict)")
            NetWorkSessionManger.GET(HTTPRequestHead+"userInsert", params: dict as [NSObject : AnyObject], progress: nil, successBlock: { (json) in
            DDLog("\(json)")
                }, failBlock: { (error) in
                 DDLog("\(error)")
                }, end: { 
            })

        }
        
        
        NetWorkSessionManger.GET(HTTPRequestHead+"userSearch", params: nil , progress: nil, successBlock: { (json) in
            
            let userArray = (json.objectForKey("data")) as! NSArray
            let userMutArray = NSMutableArray()
            for dict in userArray {
                let model = UserModel.init()
                model.username = dict["username"] as? String
                model.password = dict["password"] as? String
                model.telephone = dict["telephone"] as? String
                userMutArray.addObject(model)
            }
            DDLog("\(userMutArray)")
            
            }, failBlock: { (error) in
             
            }, end: {
        })
        
        

    }
    


    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

