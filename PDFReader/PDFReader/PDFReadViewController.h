//
//  PDFReadViewController.h
//  PDFReader
//
//  Created by Tom HU on 14-1-2.
//  Copyright (c) 2014年 Tom HU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContentViewController;

@interface PDFReadViewController : UIViewController<UIPageViewControllerDelegate, UIPageViewControllerDataSource> {
    UIPageViewController  *thePageViewController;
    ContentViewController *contentViewController;
    NSMutableArray        *modelArray;
    CGPDFDocumentRef      PDFDocument;
    int currentIndex;
    int totalPages;
}

-(id)initWithPDFAtPath:(NSString *)path;

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (nonatomic, strong) UILabel              *myNavigationTitle;
@end
