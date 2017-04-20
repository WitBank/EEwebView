//
//  RootWebViewController.m
//  WebView
//
//  Created by Easy on 2017/3/23.
//  Copyright © 2017年 Easy. All rights reserved.
//

#import "RootWebViewController.h"
#import "RootWebView.h"

@interface RootWebViewController ()
@property(nonatomic,copy)NSString *url;
@end

@implementation RootWebViewController


- (instancetype)initWithUrl:(NSString *)url
{
    self = [super init];
    if (self) {
        self.url = url;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout =  UIRectEdgeNone;
    }
    // Do any additional setup after loading the view.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"xml"];
    [self.webView loadHTMLString:[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil] baseURL:[NSURL URLWithString:@"https://www.baidu.com/"]];
    
    //[NSURLRequest requestWithURL:[NSURL URLWithString:@""] cachePolicy:_cachePolicy timeoutInterval:10];
    
}

- (RootWebView *)webView{
    if (_webView == nil) {
        __weak RootWebViewController *weakSelf = self;
        _webView = [[RootWebView alloc] initWithFrame:self.view.bounds];
        
        [_webView setWebViewGetTitleBlock:^(NSString *title) {
            weakSelf.title = title;
        }];
        
        [_webView setScriptMessageHandlerNames:@[@"pushPaintDetailVC"] HandlerBlock:^(NSString *name, id body) {
            NSLog(@"%@---%@",name,body);
        }];
        
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
