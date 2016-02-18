//
// Created by David Clark on 15/02/2016.
// Copyright (c) 2016 David Clark. All rights reserved.
//

#import "WebViewController.h"
#import "NSURLRequest+HotelsCombined.h"
#import "WKWebView+HotelsCombined.h"

@interface WebViewController () <WKNavigationDelegate>
@end

// TODO: I will redo the views separately with a base class for handling the basic functionality of the webview, this is to fix up the mess that is the view stack messaging, the load/reload/init/reinit rubbish

@implementation WebViewController {
	WKWebView *_loadingWebView;
	WKWebView *_webView;
}

- (void)loadView {
	[self setView:[[UIView alloc] init]];
	[self.view setBackgroundColor:[UIColor whiteColor]];

	_webView = [[WKWebView alloc] init];
	[_webView setTranslatesAutoresizingMaskIntoConstraints:NO];
	[_webView setNavigationDelegate:self];
	[self.view addSubview:_webView];
	[[_webView topAnchor] constraintEqualToAnchor:self.view.topAnchor].active = YES; // the website is doing something funky to mode the site down under the bar, it should probably not
	[[_webView bottomAnchor] constraintEqualToAnchor:self.bottomLayoutGuide.topAnchor].active = YES;
	[[_webView leadingAnchor] constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
	[[_webView trailingAnchor] constraintEqualToAnchor:self.view.trailingAnchor].active = YES;

	_loadingWebView = [[WKWebView alloc] init];
	[_loadingWebView setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self.view addSubview:_loadingWebView];
	[[_loadingWebView topAnchor] constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor].active = YES;
	[[_loadingWebView bottomAnchor] constraintEqualToAnchor:self.bottomLayoutGuide.topAnchor].active = YES;
	[[_loadingWebView leadingAnchor] constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
	[[_loadingWebView trailingAnchor] constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
	[_loadingWebView loadLoadingPage];
}

- (void)viewDidDisappear:(BOOL)animated {
	// this stuff is not valid for disappearing going to the provider controller, okay for demo
	[_webView loadBlankPage];
	[_loadingWebView setAlpha:1];
}

- (void)load:(NSString *)uri {
	NSURL *url = [[NSURL alloc] initWithString:uri];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[_webView loadRequest:request];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
	if([[navigationAction request] isHomePage]) {
		[self.navigationController popViewControllerAnimated:YES];
		decisionHandler(WKNavigationActionPolicyCancel);
	}
	else {
		decisionHandler(WKNavigationActionPolicyAllow);
	}
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
	if(![webView.URL.scheme isEqualToString:@"about"]) {
		[UIView animateWithDuration:0.2 animations:^{
			[_loadingWebView setAlpha:0];
		}];
	}
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
}

@end
