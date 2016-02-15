//
//  ViewController.m
//  WebViewHandoff
//
//  Created by David Clark on 15/02/2016.
//  Copyright (c) 2016 David Clark. All rights reserved.
//


#import "ViewController.h"
#import "WebViewController.h"


@interface ViewController ()

@end

@implementation ViewController {
	UITextField *_placeTextField;
	UIButton *_searchButton;
	WebViewController *_webViewController;
}

- (void)loadView {
	[self setView:[[UIView alloc] init]];
    [self.view setBackgroundColor:[UIColor grayColor]];

	_placeTextField = [[UITextField alloc] init];
	[_placeTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
	[_placeTextField setBackgroundColor:[UIColor whiteColor]];
	[_placeTextField setFont:[UIFont fontWithName:@"ArialMT" size:22]];
	[_placeTextField setText:@"place:Sydney"];
	[self.view addSubview:_placeTextField];
	[[_placeTextField leadingAnchor] constraintEqualToAnchor:[self.view leadingAnchor]].active = YES;
	[[_placeTextField topAnchor] constraintEqualToAnchor:[self.topLayoutGuide bottomAnchor]].active = YES;
	[[_placeTextField widthAnchor] constraintEqualToAnchor:[self.view widthAnchor]].active = YES;

	_searchButton = [[UIButton alloc] init];
	[_searchButton setTranslatesAutoresizingMaskIntoConstraints:NO];
	[_searchButton setBackgroundColor:[UIColor greenColor]];
	[_searchButton setTitle:@"Search" forState:UIControlStateNormal];
	[_searchButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_searchButton];
	[[_searchButton topAnchor] constraintEqualToAnchor:[_placeTextField bottomAnchor]].active = YES;
	[[_searchButton centerXAnchor] constraintEqualToAnchor:[self.view centerXAnchor]].active = YES;
	[[_searchButton widthAnchor] constraintEqualToAnchor:[self.view widthAnchor]].active = YES;
}

- (void)search {
	// TODO: will need to checks which url to go in on (a_aid, history back etc etc)
	// TODO: will actually send a message to the webview with the data in it and let it set the url
	NSString *url = [NSString stringWithFormat:@"https://www.hotelscombined.com/Hotels/Search?destination=%@&checkin=2016-12-15&checkout=2016-12-16&Rooms=1&adults_1=2", [_placeTextField.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];

	if(!_webViewController) {
		_webViewController = [[WebViewController alloc] init];
	}
	[_webViewController load:url]; // TODO: this is dodgy as the view is not loaded yet, this will be better when it's handled properly
	[self.navigationController pushViewController:_webViewController animated:YES];
}

@end
