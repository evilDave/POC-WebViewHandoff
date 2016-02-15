//
// Created by David Clark on 15/02/2016.
// Copyright (c) 2016 David Clark. All rights reserved.
//

#import "NSURL+HotelsCombined.h"


@implementation NSURL (HotelsCombined)

// TODO: could do better, http/https www/no-www, final slashes etc.
- (BOOL)isEquivalentTo:(NSURL *)url {
	return [self.absoluteString caseInsensitiveCompare:url.absoluteString] == NSOrderedSame;
}

@end
