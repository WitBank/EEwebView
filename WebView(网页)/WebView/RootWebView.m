//
//  RootWebView.m
//  WebView
//
//  Created by Easy on 2017/3/23.
//  Copyright © 2017年 Easy. All rights reserved.
//

#import "RootWebView.h"


@interface RootWebView ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property(nonatomic,retain)UIProgressView *progress;
@property(nonatomic,retain)NSArray *scriptNames;



@end
@implementation RootWebView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.navigationDelegate = self;
        self.UIDelegate = self;
        [self addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        self.showProgress = true;
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview == nil) {
        for (NSString *fname in _scriptNames) {
            [self.configuration.userContentController removeScriptMessageHandlerForName:fname];
        }
    }
}

#pragma mark-- WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler

//加载结束
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    if (self.webViewDidFinishNavigationBlock) {
        self.webViewDidFinishNavigationBlock(webView);
    }
    if (self.webViewGetTitleBlock) {
        self.webViewGetTitleBlock(self.title);
    }
}
//加载开始
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    if (self.webViewDidStartProvisionalNavigationBlock) {
        self.webViewDidStartProvisionalNavigationBlock(webView);
    }
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if (_scriptMessageHandlerBlock) {
        _scriptMessageHandlerBlock(message.name,message.body);
    }
}

- (void)setScriptMessageHandlerNames:(NSArray *)names HandlerBlock:(void(^)(NSString*,id))handlerBlock{
    self.scriptMessageHandlerBlock = handlerBlock;
    for (NSString *fname in _scriptNames) {
        [self.configuration.userContentController removeScriptMessageHandlerForName:fname];
    }
    for (NSString *fname in names ) {
        [self.configuration.userContentController addScriptMessageHandler:self name:fname];
    }
    self.scriptNames = names;
}

#pragma mark-- kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == nil && [keyPath isEqualToString:@"estimatedProgress"]) {
        if (_showProgress) {
            self.progress.progress = [change[@"new"] floatValue];
            self.progress.hidden = (self.progress.progress >= 1);
        }
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (UIProgressView *)progress{
    if (_progress == nil) {
        _progress = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        _progress.trackTintColor = [UIColor whiteColor];
        _progress.progressTintColor = [UIColor redColor];
        _progress.hidden = true;
        [self addSubview:_progress];
    }
    return _progress;
}

@end
