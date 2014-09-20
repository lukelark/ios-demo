//
//  PhotoRecord.h
//  ClassicPhotos
//
//  Created by chenjiang on 14-9-20.
//  Copyright (c) 2014年 wind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoRecord : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) NSURL *URL;
@property(nonatomic, readonly) BOOL hasImage;
@property(nonatomic, getter = isFiltered) BOOL filtered;
@property(nonatomic, getter = isFailed) BOOL failed;

@end
