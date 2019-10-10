//
//  CVCBreed.m
//  Dogs_ObjC
//
//  Created by Landon Epps on 10/9/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

#import "CVCBreed.h"

@implementation CVCBreed

- (instancetype)initWithName:(NSString *)name
                   subbreeds:(NSArray<CVCSubbreed *> *)subbreeds {

    if (self == [super init]) {
        _name = name;
        _subbreeds = subbreeds;
    }
    
    return self;
}

@end
