//
//  ImageFiltration.h
//  ClassicPhotos
//
//  Created by chenjiang on 14-9-20.
//  Copyright (c) 2014年 wind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>
#import "PhotoRecord.h"

@protocol ImageFiltrationDelegate ;

@interface ImageFiltration : NSOperation

@property (nonatomic, weak) id<ImageFiltrationDelegate> delegate;
@property (nonatomic, readonly, strong) NSIndexPath *indexPathTableView;
@property (nonatomic, readonly, strong) PhotoRecord *photoRecord;

- (id) initWithPhotoRecord:(PhotoRecord *)record atIndexPath:(NSIndexPath *)indexPath delegate:(id<ImageFiltrationDelegate>)theDelegate;

@end

@protocol ImageFiltrationDelegate <NSObject>

- (void)imageFiltrationDidFinish:(ImageFiltration *)filtration;

@end
