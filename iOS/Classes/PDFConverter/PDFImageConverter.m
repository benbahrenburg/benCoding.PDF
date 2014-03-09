//
//  PDFImageConverter.m
//
//  Created by Sorin Nistor on 4/21/11.
//  Copyright 2011 iPDFdev.com. All rights reserved.
//

#import "PDFImageConverter.h"


static CGFloat const kDefaultDPI = 72;

@implementation PDFImageConverter

+ (NSData *)convertImageToPDF:(UIImage *)image{
    return [PDFImageConverter convertImageToPDF:image withDPI:96];
}

+ (NSData *)convertImageToPDF:(UIImage *)image withDPI:(CGFloat)DPI{
    CGSize A4PageSize = CGSizeMake(8.5 * kDefaultDPI, 11 * kDefaultDPI);
    if(image.size.width > image.size.height){
        A4PageSize = CGSizeMake(11 * kDefaultDPI, 8.5 * kDefaultDPI);
    }
    return [PDFImageConverter convertImageToPDF:image withDPI:DPI andMaxSize:A4PageSize];
}

+ (NSData *)convertImageToPDF:(UIImage *)image withDPI:(CGFloat)DPI andMaxSize:(CGSize)maxSize{
    if(DPI <= 0){
        return nil;
    }

    CGFloat imageWidth = image.size.width*image.scale*kDefaultDPI/DPI;
    CGFloat imageHeight = image.size.height*image.scale*kDefaultDPI/DPI;
    CGFloat sx = imageWidth/maxSize.width;
    CGFloat sy = imageHeight/maxSize.height;

    if(sx > 1 || sy > 1){
        CGFloat maxScale = sx > sy ? sx :sy;
        imageWidth = imageWidth / maxScale;
        imageHeight = imageHeight / maxScale;
    }

    CGRect mediaBox = (CGRect){CGPointZero, round(imageWidth), round(imageHeight)};
    NSMutableData *pdfFile = [[NSMutableData alloc] init];
    CGDataConsumerRef pdfConsumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)pdfFile);
    CGContextRef pdfContext = CGPDFContextCreate(pdfConsumer, &mediaBox, NULL);
    CGContextBeginPage(pdfContext, &mediaBox);
    CGContextDrawImage(pdfContext, mediaBox, [image CGImage]);
    CGContextEndPage(pdfContext);
    CGContextRelease(pdfContext);
    CGDataConsumerRelease(pdfConsumer);

    return pdfFile;
}
@end
