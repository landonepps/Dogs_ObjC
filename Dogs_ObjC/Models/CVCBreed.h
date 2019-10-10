//
//  CVCBreed.h
//  Dogs_ObjC
//
//  Created by Landon Epps on 10/9/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CVCSubbreed.h"

NS_ASSUME_NONNULL_BEGIN

@interface CVCBreed : NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, strong, nullable) NSArray<CVCSubbreed *> *subbreeds;

- (instancetype)initWithName:(NSString *)name
                   subbreeds:(NSArray<CVCSubbreed *> * _Nullable)subbreeds ;

@end

NS_ASSUME_NONNULL_END
