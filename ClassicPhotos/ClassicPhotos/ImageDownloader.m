//
//  ImageDownloader.m
//  ClassicPhotos
//
//  Created by chenjiang on 14-9-20.
//  Copyright (c) 2014年 wind. All rights reserved.
//

#import "ImageDownloader.h"

@interface ImageDownloader()

@property (nonatomic, readwrite, strong) NSIndexPath *indexPathTableView;
@property (nonatomic, readwrite, strong) PhotoRecord *photoRecord;

@end

@implementation ImageDownloader

@synthesize delegate = _delegate;
@synthesize indexPathTableView = _indexPathTableView;
@synthesize photoRecord = _photoRecord;

- (id)initWithPhotoRecord:(PhotoRecord *)record atIndexPath:(NSIndexPath *)indexPath delegate:(id<ImageDownloaderDelegate>)theDelegate
{
    if (self = [super init])
    {
        self.delegate = theDelegate;
        self.indexPathTableView = indexPath;
        self.photoRecord = record;
    }
    return self;
}

- (void)main
{
    @autoreleasepool {
        if (self.isCancelled) {
            return;
        }
        
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:self.photoRecord.URL];
        
        if (self.isCancelled) {
            imageData = nil;
            return;
        }
        
        if (imageData) {
            UIImage *downloadedImage = [UIImage imageWithData:imageData];
            self.photoRecord.image = downloadedImage;
        }
        else
        {
            self.photoRecord.failed = YES;
        }
        
        imageData = nil;
        
        if (self.isCancelled) {
            return;
        }
        
        //调到主线程
        [(NSObject *)self.delegate performSelectorOnMainThread:@selector(imageDownloaderDidFinish:) withObject:self waitUntilDone:NO];
    }
}

@end
