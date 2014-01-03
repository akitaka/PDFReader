//
//  ViewController.m
//  PDFReader
//
//  Created by Tom HU on 14-1-2.
//  Copyright (c) 2014年 Tom HU. All rights reserved.
//

#import "ViewController.h"
#import "PDFReadViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)OpenPDF:(id)sender {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PDF" ofType:@"pdf"];
    PDFReadViewController *page = [[PDFReadViewController alloc] initWithPDFAtPath:path];
    [self presentViewController:page animated:YES completion:NULL];

}
@end
