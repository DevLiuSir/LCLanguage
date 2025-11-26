//
//  SettingsLanguageController.swift
//
//  Created by DevLiuSir on 2023/3/2.
//

import Foundation
import Cocoa




public func localizeString(_ key: String) -> String {
#if SWIFT_PACKAGE
    // 如果是通过 Swift Package Manager 使用
    return Bundle.module.localizedString(forKey: key, value: "", table: "LCLanguage")
#else
    // 使用指定的键从bundle中获取本地化字符串
    return Bundle(for: LCLanguage.self).localizedString(forKey: key, value: "", table: "LCLanguage")
#endif
}




/// 设置语言控制器
public class SettingsLanguageController: NSViewController {
    
    /// 当前选择的语言索引
    public var index: Int = 0
    
    // MARK: - UI 元素
    
    /// 背景视觉效果视图
    private let visualEffectView: NSVisualEffectView = {
        let view = NSVisualEffectView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.blendingMode = .behindWindow       // 设置模糊效果为背景模式
        view.material = .popover                // 设置视觉效果材质
        view.state = .active                    // 激活视觉效果
        return view
    }()
    
    /// 图标视图
    private let iconImageView: NSImageView = {
        let imageView = NSImageView()
        imageView.image = NSApplication.shared.applicationIconImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        return imageView
    }()
    
    /// 主提示标签
    private let primaryLabel: NSTextField = {
        createLabel(withText: localizeString("label_language_change.messageText"), fontSize: 14)
    }()
    
    /// 次提示标签
    private let secondaryLabel: NSTextField = {
        createLabel(withText: localizeString("label_language_change.informativeText"), fontSize: 13)
    }()
    
    /// 重启按钮
    private let restartButton: NSButton = {
        createButton(withTitle: localizeString("button_restart.title"), action: #selector(restartApp))
    }()
    
    /// 取消按钮
    private let cancelButton: NSButton = {
        createButton(withTitle: localizeString("button_cancel.title"), action: #selector(cancel))
    }()
    
    // MARK: - 生命周期方法
    public override func loadView() {
        self.view = NSView()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
        setupUI()
    }
    
    public override func viewDidAppear() {
        super.viewDidAppear()
        configureWindow()
    }
    
    // MARK: - UI 布局
    private func setupUI() {
        // 添加背景视觉效果视图
        view.addSubview(visualEffectView)
        
        // 垂直布局视图：图标 + 主提示 + 次提示
        let verticalStack = NSStackView(views: [iconImageView, primaryLabel, secondaryLabel])
        verticalStack.orientation = .vertical
        verticalStack.alignment = .centerX
        verticalStack.spacing = 10
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(verticalStack)
        
        // 水平布局视图：取消按钮 + 重启按钮
        let horizontalStack = NSStackView(views: [cancelButton, restartButton])
        horizontalStack.orientation = .horizontal
        horizontalStack.alignment = .centerY
        horizontalStack.spacing = 15
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(horizontalStack)
        
        // 设置约束
        NSLayoutConstraint.activate([
            // 视觉效果视图填充整个窗口
            visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            visualEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // 垂直布局
            verticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            
            // 图标尺寸
            iconImageView.widthAnchor.constraint(equalToConstant: 80),
            iconImageView.heightAnchor.constraint(equalToConstant: 80),
            
            // 按钮水平布局
            horizontalStack.topAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: 20),
            horizontalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // 按钮尺寸
            restartButton.widthAnchor.constraint(equalToConstant: 100),
            restartButton.heightAnchor.constraint(equalToConstant: 30),
            cancelButton.widthAnchor.constraint(equalToConstant: 100),
            cancelButton.heightAnchor.constraint(equalToConstant: 30),
            
            // 标签宽度限制
            primaryLabel.widthAnchor.constraint(equalToConstant: 200),
            secondaryLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    // MARK: - 私有方法
    
    /// 配置窗口
    private func configureWindow() {
        view.window?.setContentSize(NSSize(width: 280, height: 280))
        view.window?.styleMask.remove(.resizable) // 禁止调整窗口大小
    }
    
    /// 保存语言设置
    private func saveLanguage() {
        let language = LCLanguage.supportedLanguagesModel[index]
        UserDefaults.standard.set([language.code], forKey: "AppleLanguages")
    }
    
    /// 重启应用程序
    private func relaunchApp() {
        let task = Process()
        task.launchPath = "/usr/bin/open"
        task.arguments = ["-n", Bundle.main.bundlePath]
        task.launch()
        exit(0)
    }
    
    // MARK: - 按钮操作
    @objc private func restartApp() {
        saveLanguage()
        // 判断是否外部控制重启
        if LCLanguage.shouldExternalRestartControl {
            // 发送 Combine 事件，通知语言动作为取消
            LCLanguage.actionPublisher.send(.restart)
        }else {
            relaunchApp()
        }
    }
    
    @objc private func cancel() {
        dismiss(self)
        // 发送 Combine 事件，通知语言动作为取消
        LCLanguage.actionPublisher.send(.cancel)
    }
}

// MARK: - 辅助创建按钮、标签
private extension SettingsLanguageController {
    /// 创建标签
    static func createLabel(withText text: String, fontSize: CGFloat) -> NSTextField {
        let label = NSTextField(labelWithString: text)
        label.font = NSFont.systemFont(ofSize: fontSize)
        label.alignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.maximumNumberOfLines = 0
        return label
    }
    
    /// 创建按钮
    static func createButton(withTitle title: String, action: Selector) -> NSButton {
        let button = NSButton(title: title, target: nil, action: action)
        button.bezelStyle = .regularSquare
        button.setButtonType(.momentaryPushIn)
        button.isBordered = true
        button.alignment = .center
        let restartTitle = localizeString("button_restart.title")
        button.bezelColor = title == restartTitle ? .controlAccentColor : .controlColor // 高亮按钮使用不同的样式
        return button
    }
    
}
