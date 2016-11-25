//
//  AppDelegate.m
//  SDKTestDemo
//
//  Created by Agan on 16/10/21.
//  Copyright © 2016年 Agan. All rights reserved.
//

#import "AppDelegate.h"
#import "AuthViewController.h"
#import "CustomizeViewController.h"
#import "ShareViewController.h"
#import "WXApi.h"
#import "WeiboSDK.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  //    [ShareSDK registerApp:@"1780549e938d9"];
  [ShareSDK registerApp:@"1780549e938d9"];

  //添加新浪微博应用 注册网址 http://open.weibo.com
  [ShareSDK connectSinaWeiboWithAppKey:@"568898243"
                             appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                           redirectUri:@"http://www.sharesdk.cn"];

  // 2. 初始化社交平台
  [self initializePlat];

  //以下是Demo界面的相关代码
  //分享页面
  ShareViewController *share = [[ShareViewController alloc] init];
  share.tabBarItem.title = NSLocalizedString(@"Share", nil);
  share.tabBarItem.image = [UIImage imageNamed:@"tabbar_share"];
  share.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_share_sel"];

  //第三方登录页面
  AuthViewController *auth = [[AuthViewController alloc] init];
  auth.tabBarItem.title = NSLocalizedString(@"Auth", nil);
  auth.tabBarItem.image = [UIImage imageNamed:@"tabbar_auth"];
  auth.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_auth_sel"];

  //自定义界面页面
  CustomizeViewController *custom = [[CustomizeViewController alloc] init];
  custom.tabBarItem.title = NSLocalizedString(@"Custom", nil);
  custom.tabBarItem.image = [UIImage imageNamed:@"tabbar_cus"];
  custom.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_cus_sel"];

  UITabBarController *tabBarVc = [[UITabBarController alloc] init];
  tabBarVc.view.backgroundColor = [UIColor whiteColor];
  tabBarVc.viewControllers = @[ share, auth, custom ];

  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.rootViewController = tabBarVc;
  [self.window makeKeyAndVisible];

  return YES;
}

- (void)initializePlat {

  /**
   连接新浪微博开放平台应用以使用相关功能，此应用需要引用SinaWeiboConnection.framework
   http://open.weibo.com上注册新浪微博开放平台应用，并将相关信息填写到以下字段
   **/
  [ShareSDK connectSinaWeiboWithAppKey:@"568898243"
                             appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                           redirectUri:@"http://www.sharesdk.cn"
                           weiboSDKCls:[WeiboSDK class]];

  /**
   连接QQ空间应用以使用相关功能，此应用需要引用QZoneConnection.framework
   http://connect.qq.com/intro/login/上申请加入QQ登录，并将相关信息填写到以下字段

   如果需要实现SSO，需要导入TencentOpenAPI.framework,并引入QQApiInterface.h和TencentOAuth.h，将QQApiInterface和TencentOAuth的类型传入接口
   **/
  [ShareSDK connectQZoneWithAppKey:@"100371282"
                         appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
                 qqApiInterfaceCls:[QQApiInterface class]
                   tencentOAuthCls:[TencentOAuth class]];

  /**
   连接微信应用以使用相关功能，此应用需要引用WeChatConnection.framework和微信官方SDK
   http://open.weixin.qq.com上注册应用，并将相关信息填写以下字段
   **/
  //    [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885" wechatCls:[WXApi
  //    class]];
  [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885"
                         appSecret:@"64020361b8ec4c99936c0e3999a9f249"
                         wechatCls:[WXApi class]];
  /**
   连接QQ应用以使用相关功能，此应用需要引用QQConnection.framework和QQApi.framework库
   http://mobile.qq.com/api/上注册应用，并将相关信息填写到以下字段
   **/
  //旧版中申请的AppId（如：QQxxxxxx类型），可以通过下面方法进行初始化
  //    [ShareSDK connectQQWithAppId:@"QQ075BCD15" qqApiCls:[QQApi class]];
  [ShareSDK connectQQWithQZoneAppKey:@"100371282"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
}

#pragma mark - 如果使用SSO（可以简单理解成跳客户端授权），以下方法是必要的

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
  return [ShareSDK handleOpenURL:url wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
  return [ShareSDK handleOpenURL:url
               sourceApplication:sourceApplication
                      annotation:annotation
                      wxDelegate:self];
}
- (void)applicationWillResignActive:(UIApplication *)application {
 
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
 }

- (void)applicationWillEnterForeground:(UIApplication *)application {
 
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
 }

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
