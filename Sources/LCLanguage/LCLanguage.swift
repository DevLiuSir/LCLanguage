//
//  LCLanguage.swift
//
//  Created by DevLiuSir on 2023/3/2.
//

import Foundation


public func localizeString(_ key: String) -> String {
    #if SWIFT_PACKAGE
    // 如果是通过 Swift Package Manager 使用
    return Bundle.module.localizedString(forKey: key, value: "", table: "LCLanguage")
    #else
    // 如果是通过 CocoaPods 使用
    struct StaticBundle {
        static let bundle: Bundle = {
            return Bundle(for: LCLanguage.self)
        }()
    }
    return StaticBundle.bundle.localizedString(forKey: key, value: "", table: "LCLanguage")
    #endif
}


public class LCLanguage {
    
    /// 当前语言
    public static let currentLang = LanguageManager.sharedManager.currentLang
    
    /// 视图模型，支持的语言列表
    public static let supportedLanguagesModel = SupportedLanguages.langList
}
