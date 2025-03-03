//
//  SupportedLanguage.swift
//
//  Created by DevLiuSir on 2023/3/2.
//

import Foundation


public struct Language: Hashable {
    let name: String    // 名称
    let code: String    // code代码
}

/// 支持语言
public struct SupportedLanguages {
    
    public static let english = Language(name: "English", code: "en")
    public static let simplifiedChinese = Language(name: "简体中文", code: "zh-Hans")
    public static let german = Language(name: "Deutsch", code: "de")       // 德语
    public static let croatian = Language(name: "Hrvatski", code: "hr")    // 克罗地亚人
    public static let turkish = Language(name: "Türkçe", code: "tr")       // 土耳其
    public static let polish = Language(name: "Polski", code: "pl")        // 波兰
    public static let filipino = Language(name: "Filipino", code: "fil")   // 菲律宾
    public static let dutch = Language(name: "Nederlands", code: "nl")     // 荷兰
    public static let italian = Language(name: "Italiano", code: "it")     // 意大利
    public static let russian = Language(name: "Русский", code: "ru")      // 俄国
    public static let spanish = Language(name: "Español", code: "es")      // 西班牙
    public static let japanese = Language(name: "日本語", code: "ja")       // 日本
    public static let somali = Language(name: "Somali", code: "so")        // 索马里
    public static let korean = Language(name: "한국어", code: "ko")          // 韩语
    public static let french = Language(name: "Français", code: "fr")      // 法语
    public static let ukrainian = Language(name: "Українська", code: "uk") // 乌克兰
    public static let slovak = Language(name: "Slovenský", code: "sk")     // 斯洛伐克语
    public static let portuguese = Language(name: "Português", code: "pt")// 葡萄牙
    
    /// 语言列表
    public static let langList = [
                           SupportedLanguages.english,
                           SupportedLanguages.simplifiedChinese,
                           SupportedLanguages.german,
//                           SupportedLanguages.croatian,
//                           SupportedLanguages.turkish,
//                           SupportedLanguages.polish,
//                           SupportedLanguages.filipino,
//                           SupportedLanguages.dutch,
//                           SupportedLanguages.italian,
//                           SupportedLanguages.russian,
//                           SupportedLanguages.somali,
                           SupportedLanguages.spanish,
                           SupportedLanguages.japanese,
                           SupportedLanguages.korean,
                           SupportedLanguages.french,
                           SupportedLanguages.portuguese
    ]
    
    
    /// 获取语言名称
    /// - Parameter code: 根据传入的code
    /// - Returns: 语言名称字符串
    public static func getLangName(code: String) -> String {
        let lang = SupportedLanguages.langList.filter { $0.code == code }.first
        return lang?.name ?? "English"
    }
    
    /// 获取语言code
    /// - Parameter code: 根据传入的code
    /// - Returns: 语言code字符串
    public static func getLangCode(code: String) -> String {
        let lang = SupportedLanguages.langList.filter { $0.code == code }.first
        return lang?.code ?? "en"
    }
    
    
    
}
