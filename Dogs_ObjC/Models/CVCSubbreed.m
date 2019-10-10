//
//  CVCSubbreed.m
//  Dogs_ObjC
//
//  Created by Landon Epps on 10/9/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

#import "CVCSubbreed.h"

@implementation CVCSubbreed

- (instancetype)initWithName:(NSString *)name {
    
    if (self == [super init]) {
        _name = name;
    }
    
    return self;
}

@end
