//
//  SUNOCCallJSViewController.m
//  SUNJavaScriptCall
//
//  Created by Elliekuri on 2016/11/1.
//  Copyright © 2016年 S.U.N. All rights reserved.
//

/*
 * 深入了解JavaScriptCore请看->http://www.jianshu.com/p/02377c5d9478
 */

#import "SUNOCCallJSViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface SUNOCCallJSViewController () <UIWebViewDelegate>

@end

@implementation SUNOCCallJSViewController
@synthesize webView = _webView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
}

#pragma mark -- UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //JSContext代表JavaScript的运行环境，你需要用JSContext来执行JavaScript代码。所有的JSValue都是捆绑在一个JSContext上的。
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSString * runJS = @"alert('OC成功调用了JavaScript的方法')";
    [context evaluateScript:runJS];
}

#pragma mark -- getter & setter

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.delegate = self;
        NSURL * url = [NSURL URLWithString:@"http://www.baidu.com"];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
    }
    return _webView;
}

@end
