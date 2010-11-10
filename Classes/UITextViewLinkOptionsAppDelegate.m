//
//  UITextViewLinkOptionsAppDelegate.m
//  UITextViewLinkOptions
//
//  Created by Mark Sands on 7/29/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "UITextViewLinkOptionsAppDelegate.h"
#import "RootViewController.h"
#import <objc/runtime.h>

@implementation UIApplication (Private)

- (BOOL)customOpenURL:(NSURL*)url
{
  UITextViewLinkOptionsAppDelegate *MyWatcher = [[UIApplication sharedApplication] delegate];
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

// This is key for method swizzling to re-swizzle when an app returns from the background
- (void)applicationDidBecomeActive:(UIApplication *)application {  
  Method customOpenUrl = class_getInstanceMethod([UIApplication class], @selector(customOpenURL:));
  Method openUrl = class_getInstanceMethod([UIApplication class], @selector(openURL:));
  
  method_exchangeImplementations(openUrl, customOpenUrl);	
}


- (void)dealloc
{
  [navigationController release];
  [window release];
  [super dealloc];
}


@end

