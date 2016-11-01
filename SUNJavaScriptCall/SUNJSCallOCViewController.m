//
//  ViewController.m
//  SUNJavaScriptCall
//
//  Created by Elliekuri on 2016/11/1.
//  Copyright © 2016年 S.U.N. All rights reserved.
//

#import "SUNJSCallOCViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface SUNJSCallOCViewController () <UIWebViewDelegate>

@end

@implementation SUNJSCallOCViewController
@synthesize webView = _webView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
}

#pragma mark -- UIWebViewDelegate

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //js代码的方法名，可以传递N多参数
        context[@"printHello"] = ^(){
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"成功" message:@"OC方法被调用" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* confirm = [UIAlertAction
                                          actionWithTitle:@"好的"
                                          style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction * action)
                                          {
                                              [alert dismissViewControllerAnimated:YES completion:nil];
                                              
                                          }];
                [alert addAction:confirm];
                
                [self presentViewController:alert animated:YES completion:nil];
            });

    };
    //JSValue代表一个JavaScript实体，一个JSValue可以表示很多JavaScript原始类型例如boolean, integers, doubles，甚至包括对象和函数。
    JSValue *function = context[@"printHello"];
    [function callWithArguments:@[]];

}

#pragma mark -- getter & setter

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.delegate = self;
        NSString * path = [[NSBundle mainBundle]pathForResource:@"index" ofType:@"html"];
        NSURL * url = [NSURL fileURLWithPath:path isDirectory:NO];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
    }
    return _webView;
}

@end
