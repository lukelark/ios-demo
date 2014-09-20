//
//  PendingOperations.m
//  ClassicPhotos
//
//  Created by chenjiang on 14-9-20.
//  Copyright (c) 2014年 wind. All rights reserved.
//

#import "PendingOperations.h"

@implementation PendingOperations

@synthesize downloadsInProgress = _downloadsInProgress;
@synthesize downloadQueue = _downloadQueue;

@synthesize filtrationQueue = _filtrationQueue;
@synthesize filtrationsInProgress = _filtrationsInProgress;

- (NSMutableDictionary *)downloadsInProgress
{
    if (!_downloadsInProgress)
    {
        _downloadsInProgress = [[NSMutableDictionary alloc] init];
    }
    return _downloadsInProgress;
}

- (NSOperationQueue *)downloadQueue
{
    if (!_downloadQueue)
    {
        _downloadQueue = [[NSOperationQueue alloc] init];
        _downloadQueue.name = @"Download Queue";
        _downloadQueue.maxConcurrentOperationCount = 1;
    }
    return _downloadQueue;
}

- (NSMutableDictionary *)filtrationsInProgress
{
    if (!_filtrationsInProgress) {
        _filtrationsInProgress = [[NSMutableDictionary alloc] init];
    }
    return _filtrationsInProgress;
}

- (NSOperationQueue *)filtrationQueue
{
    if (!_filtrationQueue) {
        _filtrationQueue = [[NSOperationQueue alloc] init];
        _filtrationQueue.name = @"Image filtration Queue";
        _filtrationQueue.maxConcurrentOperationCount = 1;
    }
    return _filtrationQueue;
}

@end
