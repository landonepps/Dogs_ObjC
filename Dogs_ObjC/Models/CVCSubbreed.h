//
//  CVCSubbreed.h
//  Dogs_ObjC
//
//  Created by Landon Epps on 10/9/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CVCSubbreed : NSObject

@property (nonatomic, copy, readonly) NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
