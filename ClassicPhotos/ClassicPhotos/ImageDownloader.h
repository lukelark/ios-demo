//
//  ImageDownloader.h
//  ClassicPhotos
//
//  Created by chenjiang on 14-9-20.
//  Copyright (c) 2014年 wind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoRecord.h"

@class ImageDownloader;

@protocol ImageDownloaderDelegate <NSObject>

- (void)imageDownloaderDidFinish:(ImageDownloader *)downloader;

@end

@interface ImageDownloader : NSOperation

@property (nonatomic, assign)id<ImageDownloaderDelegate> delegate;

@property (nonatomic, readonly, strong) NSIndexPath *indexPathTableView;
@property (nonatomic, readonly, strong) PhotoRecord *photoRecord;

- (id)initWithPhotoRecord:(PhotoRecord *)record atIndexPath:(NSIndexPath *)indexPath delegate:(id<ImageDownloaderDelegate>)theDelegate;

@end
