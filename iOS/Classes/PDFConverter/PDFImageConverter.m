//
//  PDFImageConverter.m
//
//  Created by Sorin Nistor on 4/21/11.
//  Copyright 2011 iPDFdev.com. All rights reserved.
//

#import "PDFImageConverter.h"


@implementation PDFImageConverter

+ (NSData *) convertImageToPDF: (UIImage *) image {
    return [PDFImageConverter convertImageToPDF: image withResolution: 96];
}

+ (NSData *) convertImageToPDF: (UIImage *) image withResolution: (double) resolution {
    return [PDFImageConverter convertImageToPDF: image withHorizontalResolution: resolution verticalResolution: resolution];
}

+ (NSData *) convertImageToPDF: (UIImage *) image withHorizontalResolution: (double) horzRes verticalResolution: (double) vertRes {
    if ((horzRes <= 0) || (vertRes <= 0)) {
        return nil;
    }
    
    double pageWidth = image.size.width * image.scale * 72 / horzRes;
    double pageHeight = image.size.height * image.scale * 72 / vertRes;
    
    NSMutableData *pdfFile = [[NSMutableData alloc] init];
    CGDataConsumerRef pdfConsumer = CGDataConsumerCreateWithCFData((CFMutableDataRef)pdfFile);
    // The page size matches the image, no white borders.
    CGRect mediaBox = CGRectMake(0, 0, pageWidth, pageHeight);
    CGContextRef pdfContext = CGPDFContextCreate(pdfConsumer, &mediaBox, NULL);
    
    CGContextBeginPage(pdfContext, &mediaBox);
    CGContextDrawImage(pdfContext, mediaBox, [image CGImage]);
    CGContextEndPage(pdfContext);
    CGContextRelease(pdfContext);
    CGDataConsumerRelease(pdfConsumer);
    
    [pdfFile autorelease];
    return pdfFile;
}

+ (NSData *) convertImageToPDF: (UIImage *) image withResolution: (double) resolution maxBoundsRect: (CGRect) boundsRect pageSize: (CGSize) pageSize {
    if (resolution <= 0) {
        return nil;
    }
    
    double imageWidth = image.size.width * image.scale * 72 / resolution;
    double imageHeight = image.size.height * image.scale * 72 / resolution;
    
    double sx = imageWidth / boundsRect.size.width;
    double sy = imageHeight / boundsRect.size.height;
    
    // At least one image edge is larger than maxBoundsRect
    if ((sx > 1) || (sy > 1)) {
        double maxScale = sx > sy ? sx : sy;
        imageWidth = imageWidth / maxScale;
        imageHeight = imageHeight / maxScale;
    }
    
    // Put the image in the top left corner of the bounding rectangle
    CGRect imageBox = CGRectMake(boundsRect.origin.x, boundsRect.origin.y + boundsRect.size.height - imageHeight, imageWidth, imageHeight);
    
    NSMutableData *pdfFile = [[NSMutableData alloc] init];
    CGDataConsumerRef pdfConsumer = CGDataConsumerCreateWithCFData((CFMutableDataRef)pdfFile);
    
    CGRect mediaBox = CGRectMake(0, 0, pageSize.width, pageSize.height);
    CGContextRef pdfContext = CGPDFContextCreate(pdfConsumer, &mediaBox, NULL);
    
    CGContextBeginPage(pdfContext, &mediaBox);
    CGContextDrawImage(pdfContext, imageBox, [image CGImage]);
    CGContextEndPage(pdfContext);
    CGContextRelease(pdfContext);
    CGDataConsumerRelease(pdfConsumer);
    
    [pdfFile autorelease];
    return pdfFile;
}

@end
