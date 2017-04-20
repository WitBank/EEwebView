//
//  RootWebViewController.h
//  WebView
//
//  Created by Easy on 2017/3/23.
//  Copyright © 2017年 Easy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootWebView;

@interface RootWebViewController : UIViewController

@property(nonatomic,assign)NSURLRequestCachePolicy cachePolicy;

@property(nonatomic,retain)RootWebView *webView;

- (instancetype)initWithUrl:(NSString *)url;
@end
