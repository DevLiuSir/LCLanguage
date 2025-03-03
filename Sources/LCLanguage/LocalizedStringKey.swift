//
//  LocalizedStringKey.swift
//
//  Created by DevLiuSir on 2023/3/2.
//


import Foundation


extension Bundle {
    
    /// 用来存储当前语言资源包的静态变量。
    private static var bundle: Bundle!
    
    /// 支持的语言数组
    private static var supportLangs = ["en", "zh", "de", "hr", "tr","pl", "fil", "nl", "it", "ru", "es","ja", "so","ko","fr","uk","sk", "pt"]
    
    
    /// 获取当前已设置语言的本地化资源包。
    ///
    /// 如果 `bundle` 未被初始化，则尝试加载用户偏好设置的语言资源包。
    /// 如果找不到用户设置的语言资源包，或者用户未设置语言，则默认加载英语资源包。
    /// - Returns: 当前语言对应的 `Bundle` 对象。
    public static func localizedBundle() -> Bundle! {
        if bundle == nil {
            // 获取用户偏好设置的语言，如果没有则默认为英语
            let appLang = UserDefaults.standard.string(forKey: UserDefaults.Key.AppLanguage) ?? "en"
            // 尝试加载对应的本地化资源包
            let path = Bundle.main.path(forResource: appLang, ofType: "lproj")
            if let path = path {
                bundle = Bundle(path: path)
            } else {    // 如果无法加载对应的资源，则加载默认的英语资源包
                let path = Bundle.main.path(forResource: "en", ofType: "lproj")
                bundle = Bundle(path: path!)
            }
        }
        // 返回当前的bundle，如果上述条件都未满足，则这里会返回nil
        // 但在实际应用中，应该保证至少有默认语言的资源包
        return bundle
    }
    
    
    /// 设置应用程序的语言。(使用语言代码)
    ///
    /// 根据传入的语言代码更改应用程序的语言。如果指定的语言资源不存在，
    /// 则默认回退到英语。
    /// - Parameter lang: 语言代码，例如 "en" 表示英语，"zh-Hans" 表示简体中文。
    public static func setLanguage(lang: String) {
        // 将用户选择的语言保存到 UserDefaults 中
        UserDefaults.standard.set(lang, forKey: UserDefaults.Key.AppLanguage)
        
        // 尝试获取对应语言的资源包路径
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        
        // 如果找到了对应的语言资源，则更新 bundle
        if let path = path {
            bundle = Bundle(path: path)
        } else {
            // 如果没有找到，则回退到英语资源包
            let path = Bundle.main.path(forResource: "en", ofType: "lproj")
            bundle = Bundle(path: path!)
        }
    }
    
    /// 获取当前应用程序所使用的语言。
    ///
    /// 首先尝试从 UserDefaults 中读取用户设置的语言，如果没有设置，则返回系统语言。
    /// - Returns: 返回一个字符串，代表当前使用的语言代码，例如 "en" 或 "zh-Hans"。
    public static func currentLanguage() -> String {
        guard let lang = UserDefaults.standard.string(forKey: UserDefaults.Key.AppLanguage) else {
            return systemLanguage()
        }
        return lang
    }
    
    /// 获取系统默认语言。
    ///
    /// - Returns: 返回一个字符串，代表系统默认使用的语言代码。
    public static func systemLanguage() -> String {
        guard let sysLang = Locale.current.languageCode else { return "en"}
        if supportLangs.contains(sysLang) {
            if sysLang == "zh" {
                return "zh-Hans"
            }
            return sysLang
        }
        return "en"
    }
}
