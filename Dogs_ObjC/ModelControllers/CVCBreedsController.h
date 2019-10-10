//
//  CVCBreedsController.h
//  Dogs_ObjC
//
//  Created by Landon Epps on 10/9/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CVCBreed.h"
#import "CVCSubbreed.h"

NS_ASSUME_NONNULL_BEGIN

@interface CVCBreedsController : NSObject

+ (void)fetchBreeds:(void (^)(NSArray<CVCBreed *> * _Nullable))completion;

+ (void)fetchImageURLsForBreed:(CVCBreed *)breed
             completionHandler:(void (^)(NSArray<NSURL *> * _Nullable))completion;

+ (void)fetchImageURLsForSubbreed:(CVCSubbreed *)subbreed
                            breed:(CVCBreed *)breed
                completionHandler:(void (^)(NSArray<NSURL *> * _Nullable))completion;

+ (void)fetchImageFor:(NSURL *)url
        completionHandler:(void (^)(UIImage * _Nullable))completion;

@end

NS_ASSUME_NONNULL_END
