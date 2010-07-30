//
//  UITextViewLinkOptionAppDelegate.m
//  UITextViewLinkOption
//
//  Created by Mark Sands on 7/29/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "UITextViewLinkOptionAppDelegate.h"

@implementation UIApplication (Private)

- (BOOL)customOpenURL:(NSURL*)url
{
	UITextViewLinkOptionAppDelegate	*MyWatcher = [[UIApplication sharedApplication] delegate];
  NSLog(@"MyWatcher: %@", MyWatcher.currentViewController);
	if (MyWatcher.currentViewController) {
		[MyWatcher.currentViewController handleURL:url];
		return YES;
	}
	return NO;
}

@end

@implementation UITextViewLinkOptionAppDelegate

@synthesize window, navigationController, currentViewController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [window addSubview:navigationController.view];  
  [window makeKeyAndVisible];
  
  return YES;
}

- (void)dealloc
{
  [navigationController release];
  [window release];
  [super dealloc];
}

@end
