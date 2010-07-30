//
//  NavigationController.h
//  UITextViewLinkOption
//
//  Created by Mark Sands on 7/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationController : UINavigationController {
  UITextView *textView;
}

@property (nonatomic, retain) UITextView *textView;

- (void) handleURL:(NSURL *)url;

@end