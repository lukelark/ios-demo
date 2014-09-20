//
//  ListViewController.h
//  ClassicPhotos
//
//  Created by chenjiang on 14-9-20.
//  Copyright (c) 2014年 wind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking/AFNetworking.h"
#import "PendingOperations.h"
#import "ImageDownloader.h"
#import "ImageFiltration.h"

#define kDatasourceURLString @"http://www.raywenderlich.com/downloads/ClassicPhotosDictionary.plist"

@interface ListViewController : UITableViewController<ImageFiltrationDelegate, ImageDownloaderDelegate>

@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) PendingOperations *pendingOperations;

@end
