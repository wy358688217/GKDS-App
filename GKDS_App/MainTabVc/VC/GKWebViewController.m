//
//  GKWebViewController.m
//  GKDS_App
//
//  Created by apple on 16/4/3.
//  Copyright © 2016年 wang. All rights reserved.
//
@import WebKit;

#import "GKWebViewController.h"
#import "WebKit/WebKit.h"
@interface GKWebViewController ()<UIWebViewDelegate>

@end

@implementation GKWebViewController {
    
    IBOutlet UIWebView *webView;
    UIActivityIndicatorView *activityIndicatorView;
    UIView *opaqueView;
    WKWebView * wkWebView;
}

- (void)dealloc
{
    if (webView) {
        webView = nil;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

//    [webView setFrame:self.view.bounds];

    
    //加载网页的方式
    //1.创建并加载远程网页
//    NSURL *url = [NSURL URLWithString:@"http://www.qq.com/"];
//    NSURL *url = [[NSURL alloc]initWithString:@"https://developer.apple.com/"];

    //2.加载本地文件资源
    /* NSURL *url = [NSURL fileURLWithPath:filePath];
     NSURLRequest *request = [NSURLRequest requestWithURL:url];
     [webView loadRequest:request];*/
    //3.读入一个HTML，直接写入一个HTML代码
    //NSString *htmlPath = [[[NSBundle mainBundle]bundlePath]stringByAppendingString:@"webapp/loadar.html"];
    //NSString *htmlString = [NSString stringWithContentsOfURL:htmlPath encoding:NSUTF8StringEncoding error:NULL];
    //[webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:htmlPath]];
    
//    opaqueView = [[UIView alloc]initWithFrame:SCREEN_RECT];
//    activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:SCREEN_RECT];
//    [activityIndicatorView setCenter:opaqueView.center];
//    [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
//    [opaqueView setBackgroundColor:[UIColor grayColor]];
//    [opaqueView setAlpha:0.5];
//    [self.view addSubview:opaqueView];
//    [opaqueView addSubview:activityIndicatorView];

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    if (!webView) {
//        webView = [[UIWebView alloc]initWithFrame:SCREEN_RECT];
//        [self.view addSubview:webView];
//    }
//    [webView setUserInteractionEnabled:YES];//是否支持交互
//    [webView setDelegate:self];
//    [webView setOpaque:NO];//opaque是不透明的意思
//    [webView setScalesPageToFit:YES];//自动缩放以适应屏幕
//    NSURL *url = [[NSURL alloc]initWithString:@"https://www.baidu.com/"];
//    NSURLRequest * request = [NSURLRequest requestWithURL:url];
//    [webView loadRequest:request];
//    
//    
////    if (!wkWebView) {
////        wkWebView = [[WKWebView alloc]initWithFrame:SCREEN_RECT];
////        [self.view addSubview:wkWebView];
////    }
////    [wkWebView setUserInteractionEnabled:YES];//是否支持交互
//////    [wkWebView setDelegate:self];
////    [wkWebView setOpaque:NO];//opaque是不透明的意思
//////    [wkWebView setScalesPageToFit:YES];//自动缩放以适应屏幕
////    NSURL *url_ = [[NSURL alloc]initWithString:@"https://www.baidu.com/"];
////    NSURLRequest * request_ = [NSURLRequest requestWithURL:url_];
////    [wkWebView loadRequest:request_];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    if (webView) {
//        NSURL *url = [[NSURL alloc]initWithString:@""];
//        NSURLRequest * request = [NSURLRequest requestWithURL:url];
//        [webView loadRequest:request];
//        [webView stopLoading];
//        [webView setDelegate:nil];
//        [webView removeFromSuperview];
//        webView = nil;
//    }
////    if (wkWebView) {
////        NSURL *url = [[NSURL alloc]initWithString:@""];
////        NSURLRequest * request = [NSURLRequest requestWithURL:url];
////        [wkWebView loadRequest:request];
////        [wkWebView stopLoading];
////        [wkWebView removeFromSuperview];
////        wkWebView = nil;
////    }
//}
//
//-(void)webViewDidStartLoad:(UIWebView *)webView{
//    GKLog(@"webViewDidStartLoad");
//    [activityIndicatorView startAnimating];
//    opaqueView.hidden = NO;
//}
//
//-(void)webViewDidFinishLoad:(UIWebView *)webView{
//    GKLog(@"webViewDidFinishLoad");
//    [activityIndicatorView startAnimating];
//    opaqueView.hidden = YES;
//    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
//    // new for memory cleanup
//    [[NSURLCache sharedURLCache] setMemoryCapacity: 0];
//    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
//    [NSURLCache setSharedURLCache:sharedCache];
//}
//
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    GKLog(error);
//}
//
////UIWebView如何判断 HTTP 404 等错误
//-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
//    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
//    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//    if ((([httpResponse statusCode]/100) == 2)) {
//        // self.earthquakeData = [NSMutableData data];
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//        
//        [ webView loadRequest:[ NSURLRequest requestWithURL: url]];
//        webView.delegate = self;
//    } else {
//        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:
//                                  NSLocalizedString(@"HTTP Error",
//                                                    @"Error message displayed when receving a connection error.")
//                                                             forKey:NSLocalizedDescriptionKey];
//        NSError *error = [NSError errorWithDomain:@"HTTP" code:[httpResponse statusCode] userInfo:userInfo];
//        
//        if ([error code] == 404) {
//            NSLog(@"xx");
//            webView.hidden = YES;
//        }
//        
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
