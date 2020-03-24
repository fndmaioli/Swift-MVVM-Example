//
//  APIService.h
//  mvvm-movies
//
//  Created by Fernando Locatelli Maioli on 23/03/20.
//  Copyright © 2020 Guilherme Piccoli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"

@interface APIService : NSObject

- (void)getPopularMovies:(void (^)(NSMutableArray<Movie *>*))completionHandler;
- (void)getNowPlayingMovies:(void (^)(NSMutableArray<Movie *>*))completionHandler;
- (void)getMoviesGenres:(void (^)(NSString *))completionHandler movieIDs:(NSArray<NSNumber *> *) movieIds;
- (void)getMovieDetail:(void (^)(Movie *))completionHandler movieID:(NSNumber *)movieID;
- (void)getMoviesBySearch:(void (^)(NSMutableArray<Movie *>*))completionHandler searchString:(NSString *)string;

@end
