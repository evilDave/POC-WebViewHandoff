//
// Created by David Clark on 15/02/2016.
// Copyright (c) 2016 David Clark. All rights reserved.
//

#import "WebViewController.h"
#import "NSURLRequest+HotelsCombined.h"

@import WebKit;

@interface WebViewController () <WKNavigationDelegate>
@end

// TODO: I will redo the views separately with a base class for handling the basic functionality of the webview, this is to fix up the mess that is the view stack messaging, the load/reload/init/reinit rubbish

@implementation WebViewController {
	WKWebView *_webView;
}

- (void)loadView {
	[self setView:[[UIView alloc] init]];
	[self.view setBackgroundColor:[UIColor whiteColor]];

	_webView = [[WKWebView alloc] init];
	[_webView setTranslatesAutoresizingMaskIntoConstraints:NO];
	[_webView setNavigationDelegate:self];
	[self.view addSubview:_webView];
	[[_webView leadingAnchor] constraintEqualToAnchor:[self.view leadingAnchor]].active = YES;
	[[_webView trailingAnchor] constraintEqualToAnchor:[self.view trailingAnchor]].active = YES;
	[[_webView topAnchor] constraintEqualToAnchor:[self.view topAnchor]].active = YES;
	[[_webView bottomAnchor] constraintEqualToAnchor:[self.view bottomAnchor]].active = YES;
}

- (void)load:(NSString *)uri {
	self.view; // TODO: don't do this
	NSURL *url = [[NSURL alloc] initWithString:uri];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[_webView loadRequest:request];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
	if([[navigationAction request] isHomePage]) {
		[_webView loadHTMLString:@"" baseURL:[NSURL URLWithString:@""]];
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
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
}

@end
