//
//  CVCBreedsController.m
//  Dogs_ObjC
//
//  Created by Landon Epps on 10/9/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

#import "CVCBreedsController.h"

static NSString * const kBaseURL = @"https://dog.ceo/api/";
static NSString * const kBreedsListComponent = @"breeds/list/all";
static NSString * const kBreedComponent = @"breed";
static NSString * const kImagesComponent = @"images";

@implementation CVCBreedsController

+ (void)fetchBreeds:(void (^)(NSArray<CVCBreed *> * _Nullable))completion {
    
    NSURL *url = [NSURL URLWithString:kBaseURL];
    url = [url URLByAppendingPathComponent:kBreedsListComponent];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error in dataTask: %@ \n---\n %@", error.localizedDescription, error);
            completion(nil);
            return;
        }
        
        if (data == nil) {
            NSLog(@"No data in response. %s", __PRETTY_FUNCTION__);
            completion(nil);
            return;
        }
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if (error) {
            NSLog(@"Error decoding JSON response: %@ \n---\n %@", error.localizedDescription, error);
            completion(nil);
            return;
        }
        
        NSDictionary *jsonBreeds = json[@"message"];
        
        NSMutableArray<CVCBreed *> *breeds = [NSMutableArray new];
        
        for (NSString *breedName in jsonBreeds) {
            
            NSMutableArray<CVCSubbreed *> *subbreeds = nil;
            NSArray *jsonSubbreeds = jsonBreeds[breedName];
            
            if (jsonSubbreeds.count > 0) {
                subbreeds = [NSMutableArray new];
                for (NSString *subbreedName in jsonSubbreeds) {
                    CVCSubbreed *subbreed = [[CVCSubbreed alloc] initWithName:subbreedName];
                    [subbreeds addObject:subbreed];
                }
            }
            
            CVCBreed *breed = [[CVCBreed alloc] initWithName:breedName subbreeds:subbreeds];
            [breeds addObject:breed];
        }
        
        completion(breeds);
        
    }] resume];
}

+ (void)fetchImageURLsForBreed:(CVCBreed *)breed
             completionHandler:(void (^)(NSArray<NSURL *> * _Nullable))completion {
    
    NSURL *url = [NSURL URLWithString:kBaseURL];
    url = [url URLByAppendingPathComponent:kBreedComponent];
    url = [url URLByAppendingPathComponent:breed.name];
    url = [url URLByAppendingPathComponent:kImagesComponent];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error fetching breed image URLs: %@ \n---\n %@", error.localizedDescription, error);
            completion(nil);
            return;
        }
        
        if (data == nil) {
            NSLog(@"No data in response. %s", __PRETTY_FUNCTION__);
            completion(nil);
            return;
        }
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if (error) {
            NSLog(@"Unable to parse breed image URLs json array.");
            completion(nil);
            return;
        }
        
        
        NSMutableArray *urls = [NSMutableArray new];
        
        for (NSString *urlString in json[@"message"]) {
            NSURL *url = [NSURL URLWithString:urlString];
        
            if (url != nil) {
                [urls addObject:url];
            }
        }
        
        completion([urls copy]);
        
    }] resume];
}

+ (void)fetchImageURLsForSubbreed:(CVCSubbreed *)subbreed
                            breed:(CVCBreed *)breed
                completionHandler:(void (^)(NSArray<NSURL *> * _Nullable))completion {
    
    NSURL *url = [NSURL URLWithString:kBaseURL];
    url = [url URLByAppendingPathComponent:kBreedComponent];
    url = [url URLByAppendingPathComponent:breed.name];
    url = [url URLByAppendingPathComponent:subbreed.name];
    url = [url URLByAppendingPathComponent:kImagesComponent];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error fetching subbreed image URLs: %@ \n---\n %@", error.localizedDescription, error);
            completion(nil);
            return;
        }
        
        if (data == nil) {
            NSLog(@"No data in response. %s", __PRETTY_FUNCTION__);
            completion(nil);
            return;
        }
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if (error) {
            NSLog(@"Unable to parse subbreed image URLs json array.");
            completion(nil);
            return;
        }
        
        NSMutableArray *urls = [NSMutableArray new];
        
        for (NSString *urlString in json[@"message"]) {
            NSURL *url = [NSURL URLWithString:urlString];
        
            if (url != nil) {
                [urls addObject:url];
            }
        }
        
        completion([urls copy]);
        
    }] resume];
}

+ (void)fetchImageFor:(NSURL *)url completionHandler:(void (^)(UIImage * _Nullable))completion {
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error in %s: %@ \n---\n %@", __PRETTY_FUNCTION__, error.localizedDescription, error);
            completion(nil);
            return;
        }
        
        if (data == nil) {
            NSLog(@"No image data");
            completion(nil);
            return;
        }
        
        completion([UIImage imageWithData:data]);
        
    }] resume];
}

@end
