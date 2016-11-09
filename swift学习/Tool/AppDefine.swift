//
//  AppDefine.swift
//  swift学习
//
//  Created by JGPeng on 16/11/8.
//  Copyright © 2016年 彭金光. All rights reserved.
//

import UIKit
import Foundation

/** debug下的打印 notice 需要在bulidSettings中设置 Debug */
func DDLog<D>(message:D,fileName:String = #file,methodName:String = #function,lineNumber:Int = #line){
    #if DEBUG
        print("\(fileName as NSString)\n方法:\(methodName)\n行号:\(lineNumber)\n打印信息\(message)");
    #endif
}
/** 屏幕宽度 */
let ScreenWidth  = UIScreen.mainScreen().bounds.size.width
/** 屏幕高度 */
let ScreenHeight = UIScreen.mainScreen().bounds.size.height
/** 屏幕宽度适配，高度适配采用scrollerView */
func MyWidth(width:CGFloat) -> CGFloat {
    return width * ScreenWidth/375.0;
}
/** 字体适配 */
func FontSize(fontSize: CGFloat) -> UIFont {
    return UIFont.systemFontOfSize(MyWidth(fontSize))
}
/** 选项形式as?和强制形式as 单类 */
let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
/** 网络请求头部 */
let HTTPRequestHead = "http://localhost:8888/thinkphp_3/Home/Suzhou/"


func Save(name:String, array : NSArray)  {
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask,true) as NSArray
    let path = paths.lastObject as! String;
    let path1 = path + name
    array.writeToFile(path1, atomically: true)
      DDLog("\(path)")
}


func Read(name:String)-> NSArray  {
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask,true) as NSArray
    let path = paths.lastObject as! String;
    let path1 = path + name
    DDLog("\(path)")
    return NSArray.init(contentsOfFile: path1)!
}



