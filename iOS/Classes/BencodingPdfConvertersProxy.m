/**
 * benCoding.PDF Titanium Project
 * Copyright (c) 2009-2013 by Benjamin Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "BencodingPdfConvertersProxy.h"
#import "TiBlob.h"
#import "TiFile.h"
#import "TiUtils.h"
#import "PDFImageConverter.h"
#import "TiUIViewProxy.h"
#import <QuartzCore/QuartzCore.h>
@implementation BencodingPdfConvertersProxy


-(TiBlob*) convertImageToPDF : (id)args
{
    enum Args {
		kArgBlob = 0,
        kArgCount,
        kArgResolution = kArgCount
	};
    
	ENSURE_ARG_COUNT(args, kArgCount);
    
	id blob = [args objectAtIndex:kArgBlob];
	ENSURE_TYPE(blob,TiBlob);
	UIImage* image = [(TiBlob*)blob image];
    int resolution = [TiUtils intValue:[args objectAtIndex:kArgResolution] def:96];
    
    CGSize pageSize = CGSizeMake(612, 792);
    CGRect imageBoundsRect = CGRectMake(50, 50, 512, 692);
    
    NSData *pdfData = [PDFImageConverter convertImageToPDF: image
                                            withResolution: resolution maxBoundsRect: imageBoundsRect pageSize: pageSize];
    
	TiBlob *result = [[[TiBlob alloc] initWithData:pdfData mimetype:@"application/octet-stream"] autorelease];
    return result;
}

@end