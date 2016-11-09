//
//  UserModel.swift
//  swift学习
//
//  Created by JGPeng on 16/11/8.
//  Copyright © 2016年 彭金光. All rights reserved.
//

import UIKit

class UserModel: NSObject {
    /** 用户名 */
    var username:String?
    /** 密码 */
    var password:String?
    /** 手机号 */
    var telephone:String?
    /** 字典转模型的方法 */
    func InitWithDict(dict: NSDictionary!) -> UserModel {
        let model = UserModel.init()
        model.username = dict["username"] as? String
        model.password = dict["password"] as? String
        model.telephone = dict["telephone"] as? String
        return model
    }
}

