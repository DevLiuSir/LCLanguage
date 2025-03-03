//
//  UserDefaults+Extension.swift
//
//  Created by DevLiuSir on 2023/3/2.
//

import Foundation

/*
 扩展 `UserDefaults`，添加用于`存储` 和 `检索` 应用程序相关设置的键
 */
extension UserDefaults {
    
    struct Key {
        // ----- General -----
        
        /// app语言
        static let AppLanguage = "app_lang"
        /// 系统语言优先级
        static let systemLangPriority = "systemLangPriority"
    }
    
}
