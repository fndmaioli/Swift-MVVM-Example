//
//  Movie.h
//  mvvm-movies
//
//  Created by Fernando Locatelli Maioli on 23/03/20.
//  Copyright © 2020 Guilherme Piccoli. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Movie : NSObject

@property (strong, nonatomic) NSString *id_movie;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *descriptiton;
@property (strong, nonatomic) NSNumber *rating;
@property (strong, nonatomic) NSMutableArray<NSNumber *> *genres;
@property (strong, nonatomic) NSString *image;

@end

NS_ASSUME_NONNULL_END
