//
//  ImageFiltration.m
//  ClassicPhotos
//
//  Created by chenjiang on 14-9-20.
//  Copyright (c) 2014年 wind. All rights reserved.
//

#import "ImageFiltration.h"

@interface ImageFiltration()

@property (nonatomic, readwrite, strong) NSIndexPath *indexPathTableView;
@property (nonatomic, readwrite, strong) PhotoRecord *photoRecord;

@end

@implementation ImageFiltration

@synthesize indexPathTableView = _indexPathTableView;
@synthesize photoRecord = _photoRecord;
@synthesize delegate = _delegate;

- (id)initWithPhotoRecord:(PhotoRecord *)record atIndexPath:(NSIndexPath *)indexPath delegate:(id<ImageFiltrationDelegate>)theDelegate
{
    if (self = [super init])
    {
        self.photoRecord = record;
        self.indexPathTableView = indexPath;
        self.delegate = theDelegate;
    }
    return self;
}

- (void)main
{
    @autoreleasepool {
        if (self.isCancelled) {
            return;
        }
        
        if (!self.photoRecord.hasImage) {
            return;
        }
        
        UIImage *rawImage = self.photoRecord.image;
        UIImage *processedImage = [self applySepiaFilterToImage:rawImage];
        
        if (self.isCancelled) {
            return;
        }
        
        if (processedImage) {
            self.photoRecord.image = processedImage;
            self.photoRecord.filtered = YES;
            
            [(NSObject *)self.delegate performSelectorOnMainThread:@selector(imageFiltrationDidFinish:) withObject:self waitUntilDone:NO];
        }
    }
}

#pragma mark -
#pragma mark - Filtering image


- (UIImage *)applySepiaFilterToImage:(UIImage *)image {
    
    // This is expensive + time consuming
    CIImage *inputImage = [CIImage imageWithData:UIImagePNGRepresentation(image)];
    
    if (self.isCancelled)
        return nil;
    
    UIImage *sepiaImage = nil;
    CIContext *context = [CIContext contextWithOptions:nil];
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues: kCIInputImageKey, inputImage, @"inputIntensity", [NSNumber numberWithFloat:0.8], nil];
    CIImage *outputImage = [filter outputImage];
    
    if (self.isCancelled)
        return nil;
    
    // Create a CGImageRef from the context
    // This is an expensive + time consuming
    CGImageRef outputImageRef = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    if (self.isCancelled) {
        CGImageRelease(outputImageRef);
        return nil;
    }
    
    sepiaImage = [UIImage imageWithCGImage:outputImageRef];
    CGImageRelease(outputImageRef);
    return sepiaImage;
}

@end
