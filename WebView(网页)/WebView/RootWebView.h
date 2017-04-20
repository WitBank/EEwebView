//
//  RootWebView.h
//  WebView
//
//  Created by Easy on 2017/3/23.
//  Copyright © 2017年 Easy. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface RootWebView : WKWebView

@property(nonatomic,copy)void(^webViewDidStartProvisionalNavigationBlock)(WKWebView *webView);
@property(nonatomic,copy)void(^webViewDidFinishNavigationBlock)(WKWebView *webView);
@property(nonatomic,copy)void(^scriptMessageHandlerBlock)(NSString *funcName ,id body);

//获取到标题
@property(nonatomic,copy)void(^webViewGetTitleBlock)(NSString *title);

//js调oc方法名Block
- (void)setScriptMessageHandlerNames:(NSArray *)names HandlerBlock:(void(^)(NSString*,id))handlerBlock;

//显示进度 ,默认true
@property(nonatomic,assign)BOOL showProgress;



/*
 oc调用js方法
 [self evaluateJavaScript:@"callJsConfirm()" completionHandler:^(id _Nullable data, NSError * _Nullable error) {
 }];
 */

@end
