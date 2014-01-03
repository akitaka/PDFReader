//
//  PDFReadViewController.m
//  PDFReader
//
//  Created by Tom HU on 14-1-2.
//  Copyright (c) 2014年 Tom HU. All rights reserved.
//

#import "PDFReadViewController.h"
#import "ContentViewController.h"

@interface PDFReadViewController ()

@end

@implementation PDFReadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithPDFAtPath:(NSString *)path {
    NSURL *pdfUrl = [NSURL fileURLWithPath:path];
    PDFDocument = CGPDFDocumentCreateWithURL((__bridge CFURLRef)pdfUrl);
    totalPages = (int)CGPDFDocumentGetNumberOfPages(PDFDocument);
    self = [super initWithNibName:nil bundle:nil];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //modelArray holds the page numbers
    modelArray = [[NSMutableArray alloc] init];
    
    for (int index = 1; index <= totalPages; index++) {
        [modelArray addObject:[NSString stringWithFormat:@"%i", index]];
    }
    
    thePageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation: UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    thePageViewController.delegate = self;
    thePageViewController.dataSource = self;
    thePageViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    contentViewController = [[ContentViewController alloc] initWithPDF:PDFDocument];
    contentViewController.page = [modelArray objectAtIndex:0];
    contentViewController.wantsFullScreenLayout = YES;
    NSArray *viewControllers = [NSArray arrayWithObject:contentViewController];
    [thePageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:thePageViewController];
    [self.view addSubview:thePageViewController.view];
//    thePageViewController.view.frame = CGRectMake(0, IS_GREATER_IOS_7?20+44:44, self.view.frame.size.width, self.view.frame.size.height-(IS_GREATER_IOS_7?20+44:44));
    thePageViewController.view.frame = CGRectMake(0, IS_GREATER_IOS_7?20+44:44, self.view.frame.size.width, SCREENHEIGHT-64);
    [thePageViewController didMoveToParentViewController:self];
    self.view.backgroundColor = [UIColor underPageBackgroundColor];
    
    
    // customer Navigation Bar
    UIView *navigationBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, IS_GREATER_IOS_7?64:44)];
    [self.view addSubview:navigationBar];
    [navigationBar setBackgroundColor:[UIColor grayColor]];
    
    _myNavigationTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, IS_GREATER_IOS_7?20:0, 320, 44)];
    [_myNavigationTitle setTextAlignment:NSTextAlignmentCenter];
    _myNavigationTitle.backgroundColor=[UIColor clearColor];
    [_myNavigationTitle setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:19.0]];
    [_myNavigationTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:_myNavigationTitle];
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, IS_GREATER_IOS_7?20:0, 44, 44)];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [backButton setBackgroundColor:[UIColor redColor]];
}

- (IBAction)back:(id)sender
{
    if (![self.presentedViewController isBeingDismissed]) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPageViewControllerDataSource Methods

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController {
    contentViewController = [[ContentViewController alloc] initWithPDF:PDFDocument];
    currentIndex = [modelArray indexOfObject:[(ContentViewController *)viewController page]];
    if (currentIndex == 0) {
        return nil;
    }
    contentViewController.page = [modelArray objectAtIndex:currentIndex - 1];
    
    return contentViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController {
    
    contentViewController = [[ContentViewController alloc] initWithPDF:PDFDocument];
    
    //get the current page
    currentIndex = [modelArray indexOfObject:[(ContentViewController *)viewController page]];
    
    //detect if last page
    //remember that in an array, the first index is 0
    //so if there are three pages, the array will contain the following pages: 0, 1, 2
    //page 2 is the last page, so 3 - 1 = 2 (totalPages - 1 = last page)
    if (currentIndex == totalPages - 1) {
        return nil;
    }
    contentViewController.page = [modelArray objectAtIndex:currentIndex + 1];
    
    return contentViewController;
}

#pragma mark - UIPageViewControllerDelegate Methods

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController
                   spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    UIViewController *currentViewController = [thePageViewController.viewControllers objectAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:currentViewController];
    [thePageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    thePageViewController.doubleSided = NO;
    
    return UIPageViewControllerSpineLocationMin;
}
@end
