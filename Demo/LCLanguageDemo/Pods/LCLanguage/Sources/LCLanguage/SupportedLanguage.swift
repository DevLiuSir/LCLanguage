//
//  SupportedLanguage.swift
//
//  Created by DevLiuSir on 2023/3/2.
//

import Foundation


public struct Language: Hashable {
    public let name: String    // 名称
    public let code: String    // code代码
}


/// 支持语言
public struct SupportedLanguages {
    internal static let english = Language(name: "English", code: "en")
    internal static let simplifiedChinese = Language(name: "简体中文", code: "zh-Hans")
    internal static let traditionalChinese = Language(name: "繁体中文", code: "zh-Hant")
    internal static let russian = Language(name: "Русский", code: "ru")      // 俄国
    internal static let japanese = Language(name: "日本語", code: "ja")       // 日本
    internal static let korean = Language(name: "한국어", code: "ko")          // 韩语
    internal static let french = Language(name: "Français", code: "fr")      // 法语
    internal static let spanish = Language(name: "Español", code: "es")      // 西班牙
    internal static let german = Language(name: "Deutsch", code: "de")       // 德语
    internal static let portuguese = Language(name: "Português", code: "pt") // 葡萄牙
    internal static let ukrainian = Language(name: "Українська", code: "uk") // 乌克兰
    internal static let croatian = Language(name: "Hrvatski", code: "hr")    // 克罗地亚人
    internal static let turkish = Language(name: "Türkçe", code: "tr")       // 土耳其
    internal static let polish = Language(name: "Polski", code: "pl")        // 波兰
    internal static let filipino = Language(name: "Filipino", code: "fil")   // 菲律宾
    internal static let dutch = Language(name: "Nederlands", code: "nl")     // 荷兰
    internal static let italian = Language(name: "Italiano", code: "it")     // 意大利
    internal static let somali = Language(name: "Somali", code: "so")        // 索马里
    internal static let slovak = Language(name: "Slovenský", code: "sk")     // 斯洛伐克语
    
    /// 语言列表
    internal static let langList = [
                           SupportedLanguages.english,
                           SupportedLanguages.simplifiedChinese,
                           SupportedLanguages.traditionalChinese,
                           SupportedLanguages.german,
                           SupportedLanguages.croatian,
                           SupportedLanguages.turkish,
                           SupportedLanguages.polish,
                           SupportedLanguages.filipino,
                           SupportedLanguages.dutch,
                           SupportedLanguages.italian,
                           SupportedLanguages.russian,
                           SupportedLanguages.somali,
                           SupportedLanguages.spanish,
                           SupportedLanguages.japanese,
                           SupportedLanguages.korean,
                           SupportedLanguages.french,
                           SupportedLanguages.portuguese
    ]
    
    /// 获取语言名称
    /// - Parameter code: 根据传入的code
    /// - Returns: 语言名称字符串
    internal static func getLangName(code: String) -> String {
        let lang = SupportedLanguages.langList.filter { $0.code == code }.first
        return lang?.name ?? "English"
    }
    
    /// 获取语言code
    /// - Parameter code: 根据传入的code
    /// - Returns: 语言code字符串
    internal static func getLangCode(code: String) -> String {
        let lang = SupportedLanguages.langList.filter { $0.code == code }.first
        return lang?.code ?? "en"
    }
    
    /// 根据传入的语言选项，动态返回支持的语言列表
    /// - Parameter options: 一个 `SupportedLanguageOption` 数组，表示所需的语言选项
    /// - Returns: 返回包含对应语言的 `Language` 数组
    internal static func getSupportedLanguages(using options: [SupportedLanguageOption]) -> [Language] {
        var languages: [Language] = []
        // 遍历传入的选项，根据每个选项添加对应的语言
        for option in options {
            switch option {
            case .english:
                languages.append(english)
            case .simplifiedChinese:
                languages.append(simplifiedChinese)
            case .traditionalChinese:
                languages.append(traditionalChinese)
            case .german:
                languages.append(german)
            case .croatian:
                languages.append(croatian)
            case .turkish:
                languages.append(turkish)
            case .polish:
                languages.append(polish)
            case .filipino:
                languages.append(filipino)
            case .dutch:
                languages.append(dutch)
            case .italian:
                languages.append(italian)
            case .russian:
                languages.append(russian)
            case .spanish:
                languages.append(spanish)
            case .japanese:
                languages.append(japanese)
            case .somali:
                languages.append(somali)
            case .korean:
                languages.append(korean)
            case .french:
                languages.append(french)
            case .ukrainian:
                languages.append(ukrainian)
            case .slovak:
                languages.append(slovak)
            case .portuguese:
                languages.append(portuguese)
            }
        }
        return languages
    }
}
