//
//  LoginView.swift
//  swift学习
//
//  Created by JGPeng on 16/11/8.
//  Copyright © 2016年 彭金光. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    /** 声明变量 */
    var nametf:UITextField?
    var pswtf:UITextField?
    var phonetf:UITextField?
    /** 声明闭包对象 */
    var getValueBlock: ((String,String,String) -> ())?
    /** 重写init方法画界面 */
    override init(frame: CGRect) {
        super.init(frame :frame)
        /** 创建label */
        let labelName     = UILabel.init(frame: CGRectMake(20, 100, 50, 30))
        let labelPassword = UILabel.init(frame: CGRectMake(20, 150, 50, 30))
        let phoneNumber   = UILabel.init(frame: CGRectMake(20, 200, 50, 30))
        labelName.textColor = UIColor.redColor()
        labelPassword.textColor = UIColor.redColor()
        phoneNumber.textColor = UIColor.redColor()
        labelName.font = FontSize(13)
        labelPassword.font = FontSize(13)
        phoneNumber.font = FontSize(13)
        labelName.text = "用户名："
        labelPassword.text = "密码："
        phoneNumber.text = "手机："
        self.addSubview(labelName)
        self.addSubview(labelPassword)
        self.addSubview(phoneNumber)
        
        /** 创建文本输入框   ！表示非nil */
        nametf = UITextField.init(frame: CGRectMake(70, 100, 200, 30))
        pswtf = UITextField.init(frame: CGRectMake(70, 150, 200, 30))
        phonetf = UITextField.init(frame: CGRectMake(70, 200, 200, 30))
        nametf!.placeholder = "用户名"
        pswtf!.placeholder = "密码"
        phonetf!.placeholder = "手机"
        self.addSubview(nametf!)
        self.addSubview(pswtf!)
        self.addSubview(phonetf!)
        
         /** 创建登录按钮 */
        let loginBtn = UIButton.init(frame: CGRectMake(0, 0, 40, 30))
        loginBtn.backgroundColor = UIColor.redColor()
        loginBtn.setTitle("登录", forState: UIControlState.Normal)
        loginBtn.addTarget(self, action: #selector(LoginAction), forControlEvents: UIControlEvents.TouchUpInside)
        loginBtn.center = self.center
        self.addSubview(loginBtn)
}
    /** 点击登录按钮的事件 */
    func LoginAction(){
        if nametf?.text == "" || pswtf?.text == "" || phonetf?.text == ""{
            DDLog("输入信息不完整，请重新输入")
        }else{
        /** 闭包方法 */
        getValueBlock!((nametf?.text)!,(pswtf?.text)!,(phonetf?.text)!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}