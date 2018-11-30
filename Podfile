# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'iOS-ShareCup' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
   use_frameworks!
  pod 'MBProgressHUD' # 提示框
  pod 'ReactiveCocoa', '2.3.1' # cocoa
  pod 'Masonry','1.1.0' #布局
  pod 'AFNetworking', '~> 3.0' # 网络请求
  pod 'IQKeyboardManager' # 键盘处理
#  pod 'SDWebImage' # 图片加载
  pod 'SDCAlertView', '2.5.2' #alertView
  pod 'SnapKit', '~> 4.0.0' #swift 布局
  pod 'YYKit' # yykit组件
  pod 'YTKNetwork' # git YY网络请求
  pod 'MJRefresh' # 刷新请求框架
#  pod 'MMDrawerController', '~> 0.5.7' # 抽箱式侧滑
#  pod 'lottie-ios', '~> 1.5.1' #动画
  pod 'BHBPopView' #微博动画
  pod 'MJExtension' #Json 解析
  pod 'BearSkill', '0.1.1' #菜单动画
  pod 'Qiniu' #七牛云
#  pod 'RongCloudIM/IMLib', '~> 2.8.3' #融云sdk
  pod 'RongCloudIM/IMKit', '~> 2.8.3'
#  pod "EFQRCode", '~> 1.2.0' #二维码
  pod 'mob_smssdk' #验证码
  pod "DKNightVersion" # 颜色切换
  #分享
#  pod 'UMengUShare/Social/ReducedWeChat'
#  pod 'UMengUShare/Social/ReducedQQ'
#  pod 'UMengUShare/Social/ReducedSina'

  
#  pod 'Cards' #app Stroe 动画效果
#  pod 'SDAutoLayout' #自动布局
#  pod 'CYLTabBarController' # tabbar三方
  # Pods for iOS-ShareCup

  target 'iOS-ShareCupTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'iOS-ShareCupUITests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  swift4 = ['SnapKit','EFQRCode']
  post_install do |installer|
      installer.pods_project.targets.each do |target|
          swift_version = nil
          if swift4.include?(target.name)
              print "set pod #{target.name} swift version to 4.0\n"
              swift_version = '4.0'
          end
          if swift_version
              target.build_configurations.each do |config|
                  config.build_settings['SWIFT_VERSION'] = swift_version
                  
              end
              
          end
      end
  end
end
