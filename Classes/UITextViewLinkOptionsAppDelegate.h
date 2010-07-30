//
//  UITextViewLinkOptionsAppDelegate.h
//  UITextViewLinkOptions
//
//  Created by Mark Sands on 7/29/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextViewLinkOptionsAppDelegate : NSObject <UIApplicationDelegate>
{
  UIWindow *window;
  UINavigationController *navigationController;

  id currentViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (nonatomic, assign) id currentViewController;
@end

