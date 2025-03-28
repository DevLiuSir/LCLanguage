//
//  LanguageManager.swift
//
//  Created by DevLiuSir on 2023/3/2.
//


import Foundation

/// 语言管理员
class LanguageManager {
    
    /// 单列模式
    static let sharedManager = LanguageManager()
    
    /// 系统优先级
    var systemLangPriority: Bool {
        get {
            UserDefaults.standard.bool(forKey: UserDefaults.Key.systemLangPriority)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaults.Key.systemLangPriority)
            UserDefaults.standard.synchronize()
            //print("systemLangPriority:\(newValue)")
        }
    }
    
    /// 当前语言(更改，设置语言，并发送通知)
    var currentLang: String {
        didSet {
            Bundle.setLanguage(lang: currentLang)
        }
    }
    
    
    init() {
        let _systemLangPriority = UserDefaults.standard.bool(forKey: UserDefaults.Key.systemLangPriority)
        currentLang = _systemLangPriority ? Bundle.systemLanguage() : Bundle.currentLanguage()
    }
    
    
    /// 设置系统语言为优先。
    ///
    /// 这个方法将系统语言设置为当前语言，并将系统语言优先标志设置为 true。
    func setSystemLangPriority() {
        // 调用Bundle的systemLanguage方法来获取系统当前的语言并设置为当前语言
        self.currentLang = Bundle.systemLanguage()
        
        // 将系统语言优先标志设置为true
        systemLangPriority = true
    }

    /// 设置特定的语言。
    ///
    /// 这个方法允许你设置一个特定的语言作为当前语言，并将系统语言优先标志设置为 false。
    /// - Parameter lang: 一个字符串值，代表要设置的特定语言的代码。
    func setCertainLang(_ lang: String) {
        // 设置当前语言为传入的lang参数
        self.currentLang = lang
        
        // 将系统语言优先标志设置为false
        self.systemLangPriority = false
    }
    
}
