//
//  NavigationController.m
//  UITextViewLinkOption
//
//  Created by Mark Sands on 7/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <objc/runtime.h>
#import "UITextViewLinkOptionAppDelegate.h"

#import "NavigationController.h"
#import "WebViewController.h"

@implementation NavigationController

@synthesize textView;

- (id) init
{
  if ( self = [super init] ) {
    textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 100, 300, 300)];

    textView.text = @"Check out my GitHub page http://github.com/marksands or go to http://www.google.com instead.";
    textView.font = [UIFont systemFontOfSize:16.0];

    textView.dataDetectorTypes = UIDataDetectorTypeLink;
    textView.editable = NO;

    [self.view addSubview:textView];
  }
  return self;
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  UITextViewLinkOptionAppDelegate	*MyWatcher = [[UIApplication sharedApplication] delegate];
  MyWatcher.currentViewController = self;

  Method customOpenUrl = class_getInstanceMethod([UIApplication class], @selector(customOpenURL:));
  Method openUrl = class_getInstanceMethod([UIApplication class], @selector(openURL:));
  method_exchangeImplementations(customOpenUrl, openUrl);
}

- (void)handleURL:(NSURL*)url
{
  WebViewController *controller = [[[WebViewController alloc] initWithURL:url] autorelease];
  [controller setHidesBottomBarWhenPushed:YES];
  [self pushViewController:controller animated:YES];
}

- (void)dealloc
{
  [textView release];
  [super dealloc];
}

@end