//
//  SplitViewController.m
//  eBook
//
//  Created by Dan Lynch on 4/16/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import "SplitViewController.h"
#import "PolesZerosView.h"
#import "FilterDesign.h"


@implementation SplitViewController
@synthesize view1, view2, returnView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        CGRect rect = [[UIScreen mainScreen] bounds];
        
        CGRect rect1 = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height/4.0);
        CGRect rect2 = CGRectMake(rect.origin.x, rect.size.height/4.0, rect.size.width, rect.size.height/4.0);
        CGRect rect3 = CGRectMake(rect.origin.x, 2*rect.size.height/4.0, rect.size.width, rect.size.height/4.0);
        
  
        UIView * container = [[UIView alloc] initWithFrame:rect];
        
        [self setView:container];
        //        [container addSubview:[[GraphView alloc] initWithFrame:rect1]];
        
        //        [container addSubview:[[PolesZerosView alloc] initWithFrame:rect1]];
        //        [container addSubview:[[FilterDesign alloc] initWithFrame:rect2]];

        view1 = [[ConvolveDeltasView alloc] initWithFrame:rect1];
        view2 = [[ConvolveDeltasView alloc] initWithFrame:rect2];
        returnView =[[ConvolveDeltasView alloc] initWithFrame:rect3]; 
        [container addSubview:view1];
        [container addSubview:view2];
        [container addSubview:returnView];
        
        
        
        CGRect frame = CGRectMake(rect.origin.x, 3*rect.size.height/4.0, rect.size.width, rect.size.height/4.0);
        UISlider *slider = [[UISlider alloc] initWithFrame:frame];
        [slider addTarget:self action:@selector(convolve:) forControlEvents:UIControlEventValueChanged];
        [slider setBackgroundColor:[UIColor blackColor]];
        slider.minimumValue = 1.0;
        slider.maximumValue = 100.0;
        slider.continuous = YES;
        slider.value = 25.0;
        
        [container addSubview:slider];
        
        
        
        
        [view1 release];
        [view2 release];
        [returnView release];
        
        [container release];
        
        //        [self setView:[[PolesZerosView alloc] initWithFrame:rect1]];
        //        [self setView:[[PolesZerosView alloc] initWithFrame:rect2]];
        
    }
    return self;
}

- (void) convolve: (id) sender {
    
    UISlider * slider = (UISlider*) sender;
    float val = slider.value;
    
    NSLog(@"val is %f", val);
    
    [returnView clearAll];
    
    // perform convolution here!
    NSMutableArray * new = [[NSMutableArray alloc] init];
    for (int i = 0; i < [view1.points count]; i++) {
        for (int j=0; j < [view2.points count]; j++) {
            //a.set(i+j, a.get(i+j) + x[i] * h[j]);
            CGPoint x = [[view1.points objectAtIndex:i] CGPointValue];
            CGPoint h = [[view2.points objectAtIndex:j] CGPointValue];
            CGPoint newP;
            if ([new count] >= i+j) {
                CGPoint cur = [[new objectAtIndex:i+j] CGPointValue];
                newP = CGPointMake(x.x, cur.y + x.y * h.y);
            } else newP = CGPointMake(x.x, x.y * h.y);
            
            [new insertObject:[NSValue valueWithCGPoint:newP] atIndex:i+j];
        }
    }
    
//    [returnView.points release];
    returnView.points = new;
  //  [new release];
    
}

- (void)dealloc {
    [super dealloc];
    [view1 release];
    [view2 release];
    [returnView release];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
