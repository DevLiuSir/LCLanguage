//
//  ViewController.swift
//  LCLanguageDemo
//
//

import Cocoa
import LCLanguage

class ViewController: NSViewController {
    
    
    /// `选择语言环境`下拉列表按钮
    @IBOutlet weak var selectLanguageEnvironmentPopUpBtn: NSPopUpButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        /// 获取所有的国际化语言
        getAllSupportedLanguages()
    }



}



//MARK: - Configure
extension ViewController {
  
    /// 获取所有支持的语言
    private func getAllSupportedLanguages() {
        // 0.配置需要支持的多种语言
        LCLanguage.configureSupportedLanguages(using: [
            .english, .simplifiedChinese, .traditionalChinese,
            .japanese, .korean, .french, .spanish, .german, .portuguese
            // ... 这里添加想要的更多语言
        ])
        
        // 1.遍历所有支持语言的数组。添加到 NSPopUpButton 下拉列表中
        LCLanguage.supportedLanguagesModel.forEach { lang in
            print("所有支持的语言：\(lang.name)")
            selectLanguageEnvironmentPopUpBtn.addItems(withTitles: [lang.name])
        }
        
        // 2.设置 下拉列表 默认选择项 为 当前语言
        setCurrentLanguage()
        
        // 3.监听取消修改语言
        LCLanguage.observeLanguageCancel { shouldReset in
            guard shouldReset else {
                print("取消修改语言，但未重置语言选择")
                return
            }
            // 4.取消修改语言，还原之前的当前语言选择项
            self.setCurrentLanguage()
        }
    }
    
    /// 将`语言选择下拉菜单`的选项设置为`当前语言`
    public func setCurrentLanguage() {
        print("将`语言选择下拉菜单`的选项设置为`当前语言`")
        selectLanguageEnvironmentPopUpBtn.selectItem(withTitle: LCLanguage.currentLanguageName)
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
        
        print("当前选择的下拉列表title: \(title)")
        print("当前app语言环境：\(LCLanguage.currentLanguageName)")
        
        // 判断 下拉列表当前选择项，与当前app语言环境是否一致
        if !title.contains(LCLanguage.currentLanguageName) {   // 不一致，更改语言
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
