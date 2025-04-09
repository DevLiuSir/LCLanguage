//
//  LCLanguage.swift
//
//  Created by DevLiuSir on 2023/3/2.
//

import Foundation
import Combine

public func localizeString(_ key: String) -> String {
#if SWIFT_PACKAGE
    // 如果是通过 Swift Package Manager 使用
    return Bundle.module.localizedString(forKey: key, value: "", table: "LCLanguage")
#else
    // 如果是通过 CocoaPods 使用
    return Bundle(for: LCLanguage.self).localizedString(forKey: key, value: "", table: "LCLanguage")
#endif
}


public class LCLanguage {
    
    //MARK: - Private
    
    /// 当前语言
    private static let currentLang = LanguageManager.sharedManager.currentLang
    
    /// 持有多个 `AnyCancellable` 订阅，支持多个监听者
    private static var cancellables = Set<AnyCancellable>()
    
    //MARK: - Public
    
    // 视图模型，支持的语言列表
    public static var supportedLanguagesModel: [Language] = []
    
    // 配置支持的语言列表
    public static func configureSupportedLanguages(using options: [SupportedLanguageOption]) {
        supportedLanguagesModel = SupportedLanguages.getSupportedLanguages(using: options)
    }
    
    /// 1.获取系统当前语言 【English、简体中文 ...】
    public static let currentLanguageName = SupportedLanguages.getLangName(code: currentLang)
    
    /// 发布者，通知取消语言修改
    public static let cancelPublisher = PassthroughSubject<Void, Never>()
    
    /// 监听取消修改语言的事件，并执行回调
    /// - Parameter handler: 回调，`true` 代表调用 `setCurrentLanguage()`，`false` 代表只打印日志
    public static func observeLanguageCancel(_ handler: @escaping (Bool) -> Void) {
        cancelPublisher
            .sink { handler(true) }
            .store(in: &cancellables) // 订阅存入 Set，确保不会被释放
    }
    
}
