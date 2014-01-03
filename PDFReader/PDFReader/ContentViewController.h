//
//  ContentViewController.h
//  PDFReader
//
//  Created by Tom HU on 14-1-2.
//  Copyright (c) 2014年 Tom HU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDFScrollView.h"

@class PDFScrollView;

@interface ContentViewController : UIViewController <UIScrollViewDelegate> {
    CGPDFDocumentRef thePDF;
    PDFScrollView *pdfScrollView;
}

-(id)initWithPDF:(CGPDFDocumentRef)pdf;

@property (nonatomic, strong) NSString *page;
@end
