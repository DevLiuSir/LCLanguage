//
//  ViewController.swift
//  LCLanguageDemo
//
//

import Cocoa

class ViewController: NSViewController {
    
    
    /// `选择语言环境`下拉列表按钮
    @IBOutlet weak var selectLanguageEnvironmentPopUpBtn: NSPopUpButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        /// 获取所有的国际化语言
        getAllSupportedLanguages()
        
        // 监听取消修改语言
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: .LanguageIsCancelChanged, object: nil)
    }



}
//MARK: - Handle notification
extension ViewController {
    
    /// 监听取消修改语言， 更新界面
    @objc func updateUI() {
        
        print("app语言更改完成。。开始刷新UI。。。")
        
        // 0.获取系统当前语言 【English、简体中文 ...】
        let currentLanguage = SupportedLanguages.getLangName(code: LCLanguage.currentLang)
        // 1.还原下拉列表当前选择项 为 当前语言
        selectLanguageEnvironmentPopUpBtn.selectItem(withTitle: currentLanguage)
    }
    
}

//MARK: - Configure
extension ViewController {
    
    /// 获取所有支持的语言
    private func getAllSupportedLanguages() {
        // 0.遍历所有支持语言的数组。添加到 NSPopUpButton 下拉列表中
        for i in LCLanguage.supportedLanguagesModel {
            print("所有支持的语言：\(i.name)")
            selectLanguageEnvironmentPopUpBtn.addItems(withTitles: [i.name])
        }
        
        /// 1.获取系统当前语言 【English、简体中文 ...】
        let currentLanguage = SupportedLanguages.getLangName(code: LCLanguage.currentLang)
        print("currentLanguage: \(currentLanguage)")
        // 2.设置 下拉列表 默认选择项 为 当前语言
        selectLanguageEnvironmentPopUpBtn.selectItem(withTitle: currentLanguage)
    }
    
}


//MARK: - Actions
extension ViewController {
    
    /// 选择当前语言环境
    @IBAction func chooseCurrentLocale(_ sender: NSPopUpButton) {
        
        /// 所有的语言环境的名称  ["English", "简体中文"]
        // let items = sender.itemTitles
        
        /// 0.当前选择的index: 0/1
        let index = sender.indexOfSelectedItem
        
        /// 用户选择的菜单项标题
        guard let title = sender.selectedItem?.title else { return }
        
        /// 获取系统当前语言 English
        let currentLanguage = SupportedLanguages.getLangName(code: LCLanguage.currentLang)
        
        print("当前选择的下拉列表title: \(title)")
        print("当前app语言环境：\(currentLanguage)")
        
        // 判断 下拉列表当前选择项，与当前app语言环境是否一致
        if !title.contains(currentLanguage) {   // 不一致，更改语言
            print("更换语言。")
            
            // 创建语言设置控制器
            let languageVC = SettingsLanguageController()
            
            // 传值 《当前选择的index》 设置语言控制器
            languageVC.index = index
            // 弹窗 -- 是否重启确认界面
            presentAsSheet(languageVC)
            
        }else {
            print("无需修改。。。。")
        }
    }
    
    
    
}
