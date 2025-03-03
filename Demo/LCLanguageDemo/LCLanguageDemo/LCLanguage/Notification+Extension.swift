//
//  Notification+Extension.swift
//
//  Created by DevLiuSir on 2023/3/2.
//


import Foundation


public extension Notification.Name {
    /// 修改设置
    static let changeSettings = Notification.Name("changeSettingNotification")
    
    /// 显示弹窗
    static let showPopover = Notification.Name("showPopover")
    
    /// 语言已取消修改
    static let LanguageIsCancelChanged = Notification.Name("LanguageIsCancelChanged")
}
