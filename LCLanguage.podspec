Pod::Spec.new do |spec|

  spec.name         = "LCLanguage"

  spec.version      = "1.0.3"
  
  spec.summary      = "LCLanguage is a Cocoa framework for quickly switching application languages!"
  
  spec.description  = <<-DESC
  LCLanguage is a Cocoa framework that allows you to quickly and easily switch the application language environment!
                   DESC
  
  spec.homepage     = "https://github.com/DevLiuSir/LCLanguage"
  
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  
  spec.author                = { "Marvin" => "93428739@qq.com" }
  
  spec.swift_versions        = ['5.0']
  
  spec.platform              = :osx
  
  spec.osx.deployment_target = "10.15"
  
  spec.source       = { :git => "https://github.com/DevLiuSir/LCLanguage.git", :tag => "#{spec.version}" }

  spec.source_files = "Sources/LCLanguage/**/*.{h,m,swift}"
  
  spec.resource     = 'Sources/LCLanguage/Resources/**/*.strings'

end
