//
//  RootViewController.m
//  UITextViewLinkOptions
//
//  Created by Mark Sands on 7/29/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <objc/runtime.h>
#import "UITextViewLinkOptionsAppDelegate.h"

#import "RootViewController.h"
#import "WebViewController.h"

@implementation RootViewController

@synthesize textView;

- (void) viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];

  textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 100, 300, 300)];

  textView.text = @"Check out my GitHub page http://github.com/marksands or go to http://www.google.com instead.";
  textView.font = [UIFont systemFontOfSize:16.0];

  // this will autodetect urls and allow the user to respond
  textView.dataDetectorTypes = UIDataDetectorTypeLink;
  textView.editable = NO;

  [self.view addSubview:textView];

  // swap implementation, we want to go to our custom WebViewController from this view
  UITextViewLinkOptionsAppDelegate *MyWatcher = [[UIApplication sharedApplication] delegate];
  MyWatcher.currentViewController = self;

  Method customOpenUrl = class_getInstanceMethod([UIApplication class], @selector(customOpenURL:));
  Method openUrl = class_getInstanceMethod([UIApplication class], @selector(openURL:));
  method_exchangeImplementations(customOpenUrl, openUrl);
}

// called by our customOpenURL method
- (void)handleURL:(NSURL*)url
{
  WebViewController *controller = [[[WebViewController alloc] initWithURL:url] autorelease];
  [controller setHidesBottomBarWhenPushed:YES];
  [self.navigationController pushViewController:controller animated:YES];
}

- (void)dealloc {
  [textView release];
  [super dealloc];
}


@end

