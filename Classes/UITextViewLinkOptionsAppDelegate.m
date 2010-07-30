//
//  UITextViewLinkOptionsAppDelegate.m
//  UITextViewLinkOptions
//
//  Created by Mark Sands on 7/29/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "UITextViewLinkOptionsAppDelegate.h"
#import "RootViewController.h"

@implementation UIApplication (Private)

- (BOOL)customOpenURL:(NSURL*)url
{
  UITextViewLinkOptionsAppDelegate	*MyWatcher = [[UIApplication sharedApplication] delegate];
  if (MyWatcher.currentViewController) {
    [MyWatcher.currentViewController handleURL:url];
    return YES;
	}
  return NO;
}

@end

@implementation UITextViewLinkOptionsAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize currentViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{        
  [window addSubview:navigationController.view];
  [window makeKeyAndVisible];

  return YES;
}

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

