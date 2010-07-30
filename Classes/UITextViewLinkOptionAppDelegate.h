//
//  UITextViewLinkOptionAppDelegate.h
//  UITextViewLinkOption
//
//  Created by Mark Sands on 7/29/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextViewLinkOptionAppDelegate : NSObject <UIApplicationDelegate>
{
  UIWindow *window;
  UINavigationController *navigationController;

  id currentViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (nonatomic, assign) id currentViewController;

@end