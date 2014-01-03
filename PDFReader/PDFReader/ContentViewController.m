//
//  ContentViewController.m
//  PDFReader
//
//  Created by Tom HU on 14-1-2.
//  Copyright (c) 2014年 Tom HU. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithPDF:(CGPDFDocumentRef)pdf {
    thePDF = pdf;
    self = [super initWithNibName:nil bundle:nil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    CGPDFPageRef PDFPage = CGPDFDocumentGetPage(thePDF, [_page intValue]);
    
//    pdfScrollView = [[PDFScrollView alloc] initWithFrame:self.view.frame];
    pdfScrollView = [[PDFScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SCREENHEIGHT)];
    [pdfScrollView setPDFPage:PDFPage];
    [self.view addSubview:pdfScrollView];
    
    self.view.backgroundColor = [UIColor underPageBackgroundColor];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    pdfScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
