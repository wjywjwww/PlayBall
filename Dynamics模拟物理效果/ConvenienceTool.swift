//
//  ConvenienceTool.swift
//  关于Block的深入了解
//
//  Created by sks on 17/5/31.
//  Copyright © 2017年 besttone. All rights reserved.
//

import UIKit

func DEBUGLOG<T>(_ message: T, file: NSString = #file, method: String = #function, line: Int = #line)
{
    #if DEBUG
        print("\(method)[\(line)]: \(message)")
    #endif
}

class ConvenienceTool: NSObject {
    //屏幕 Size 高 宽
    static let HSCREEN_WIDTH = UIScreen.main.responds(to: #selector(getter: UIScreen.nativeBounds)) ? UIScreen.main.nativeBounds.size.width/UIScreen.main.nativeScale : UIScreen.main.bounds.size.width
    static let HSCREENH_HEIGHT = UIScreen.main.responds(to: #selector(getter: UIScreen.nativeBounds)) ? UIScreen.main.nativeBounds.size.height/UIScreen.main.nativeScale : UIScreen.main.bounds.size.height
    static let HSCREEN_SIZE = UIScreen.main.responds(to: #selector(getter: UIScreen.nativeBounds)) ? CGSize(width: UIScreen.main.nativeBounds.width / UIScreen.main.nativeScale, height: UIScreen.main.nativeBounds.height / UIScreen.main.nativeScale) : UIScreen.main.bounds.size
    
    static let SCREEN_WIDTH = UIScreen.main.bounds.width
    static let SCREENH_HEIGHT = UIScreen.main.bounds.height
    static let SCREEN_SIZE = UIScreen.main.bounds.size
    // 随机颜色
    static var JYRandomColor : UIColor {
        get{
            return UIColor(red: CGFloat(arc4random() % 256) / 255.0, green: CGFloat(arc4random() % 256) / 255.0, blue: CGFloat(arc4random() % 256) / 255.0, alpha: 1.0)
        }
    }
    //设置 RGBA Color 颜色
    class func colorFromRGBA(red : CGFloat , green : CGFloat , blue : CGFloat , alpha : CGFloat) -> UIColor{
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    // 通过 十六进制 设置颜色
    class func colorFrom16(rgbValue: UInt, alpha: CGFloat) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    //软件版本
    static let jyVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    
    //系统版本
    static let jySystemVersion:String = UIDevice.current.systemVersion
    
    //设备类型型号
    static var jyPhoneModel : String {
        get{
            let modelName = UIDevice.current.model
            switch modelName {
            case "iPod touch":
                return "iPod"
            case "iPhone":
                return "iPhone"
            case "iPad":
                return "iPad"
            default:
                return "iPhone"
            }
        }
    }
}
//添加 GCD once
public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    public class func once(token: String, block:()->Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}











