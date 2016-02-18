//
// Created by David Clark on 15/02/2016.
// Copyright (c) 2016 David Clark. All rights reserved.
//

#import "NSURLRequest+HotelsCombined.h"
#import "NSURL+HotelsCombined.h"


@implementation NSURLRequest (HotelsCombined)

- (BOOL)isHomePage {
	return [self.URL isEquivalentTo:[[NSURL alloc] initWithString:@"https://www.hotelscombined.com/"]];
}

@end
