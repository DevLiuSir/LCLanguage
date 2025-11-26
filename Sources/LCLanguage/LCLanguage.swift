//
//  LCLanguage.swift
//
//  Created by DevLiuSir on 2023/3/2.
//

import Foundation
import Combine



public enum LanguageAction {
    case cancel
    case restart
}


public class LCLanguage {
    
    //MARK: - Private
    
    /// 当前语言
    private static let currentLang = LanguageManager.sharedManager.currentLang
    
    /// 持有多个 `AnyCancellable` 订阅，支持多个监听者
    private static var cancellables = Set<AnyCancellable>()
    
    
    
    //MARK: - Public
    
    /// 是否显示国旗 Emoji（全局控制）
    public static var showFlagEmoji: Bool = true
    
    /// 是否由外部统一控制重启（多子程序模式）
    public static var shouldExternalRestartControl: Bool = false
    
    /// 视图模型，支持的语言列表
    public static var supportedLanguagesModel: [Language] = []
    
    /// 配置支持的语言列表
    public static func configureSupportedLanguages(using options: [SupportedLanguageOption]) {
        supportedLanguagesModel = SupportedLanguages.getSupportedLanguages(using: options)
    }
    
    /// 获取系统当前语言 【English、简体中文 ...】
    public static let currentLanguageName = SupportedLanguages.getLangName(code: currentLang, showEmoji: showFlagEmoji)

    
    /// 发布者，通知语言相关动作事件（取消、重启等）
    public static let actionPublisher = PassthroughSubject<LanguageAction, Never>()
    
    /// 监听语言动作事件（取消或重启）
    ///
    /// - Parameter handler: 事件回调，`action` 表示触发的动作类型 (`.cancel` 或 `.restart`)
    public static func observeLanguageAction(_ handler: @escaping (LanguageAction) -> Void) {
        actionPublisher
            .sink { action in
                handler(action)
            }
            .store(in: &cancellables)
    }
    
}
