//
//  APIService.m
//  mvvm-movies
//
//  Created by Fernando Locatelli Maioli on 23/03/20.
//  Copyright © 2020 Guilherme Piccoli. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "APIService.h"

@interface APIService ()

@end

@implementation APIService

- (void)getPopularMovies: (void (^) (NSMutableArray<Movie *> *))completionHandler {
    
    NSString *urlString = @"https://api.themoviedb.org/3/movie/popular?api_key=0d437200fbd8b26a306c3dc5f9bbbaca&language=en-US&page=1";
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
        NSError *err;
        NSDictionary *parsedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSLog(@"Failed to serialize into JSON: %@", err);
            return;
        }
        
        NSMutableArray<Movie *> *array = NSMutableArray.new;
        for (NSDictionary *popularMovie in parsedData[@"results"]) {
            Movie *movieAux = Movie.new;
            
            movieAux.name = popularMovie[@"original_title"];
            movieAux.descriptiton = popularMovie[@"overview"];
            movieAux.rating = popularMovie[@"vote_average"];
            movieAux.image = popularMovie[@"poster_path"];
            movieAux.genres = popularMovie[@"genre_ids"];
            movieAux.id_movie = popularMovie[@"id"];
            [array addObject:movieAux];
        }
        
        if (completionHandler) {
            completionHandler(array);
        }
        NSLog(@"finished getting movies");
    }] resume];
}

-(void) getNowPlayingMovies:(void (^)(NSMutableArray<Movie *> *))completionHandler {
    NSString *urlString = @"https://api.themoviedb.org/3/movie/now_playing?api_key=0d437200fbd8b26a306c3dc5f9bbbaca&language=en-US&page=1";
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSDictionary *parsedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        
        if (err) {
            NSLog(@"Failed to serialize into JSON: %@", err);
            return;
        }
        
        NSMutableArray<Movie *> *array = NSMutableArray.new;
        for (NSDictionary *popularMovie in parsedData[@"results"]) {
            Movie *movieAux = Movie.new;
            
            movieAux.name = popularMovie[@"original_title"];
            movieAux.descriptiton = popularMovie[@"overview"];
            movieAux.rating = popularMovie[@"vote_average"];
            movieAux.image = popularMovie[@"poster_path"];
            movieAux.genres = popularMovie[@"genre_ids"];;
            movieAux.id_movie = popularMovie[@"id"];
            [array addObject:movieAux];
        }
        
        if (completionHandler) {
            completionHandler(array);
        }
        NSLog(@"finished getting movies");
    }] resume];
}

-(void)getMoviesGenres:(void (^)(NSString *))completionHandler movieIDs:(NSArray<NSNumber *> *)movieIds {
    NSString *urlString = @"https://api.themoviedb.org/3/genre/movie/list?api_key=edac55baa5247ecf4089bac4553ff6ed&language=en-US";
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
        NSError *err;
        NSDictionary *parsedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSLog(@"Failed to serialize into JSON: %@", err);
            return;
        }
        
        NSMutableString *genres = NSMutableString.new;
        for (NSDictionary *genreID in parsedData[@"genres"]){
            for (NSNumber *movieGenreID in movieIds) {
                NSString *string1 = [movieGenreID stringValue];
                NSString *string2 = [genreID[@"id"] stringValue];
                if (string1 == string2) {
                    [genres appendString:(genreID[@"name"])];
                    [genres appendString:(@", ")];
                }
            }
        }
        
        if (completionHandler) {
            completionHandler(genres);
        }
        NSLog(@"finished getting movies");
    }] resume];
}

@end


