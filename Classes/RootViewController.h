//
//  RootViewController.h
//  UITextViewLinkOptions
//
//  Created by Mark Sands on 7/29/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController
{
  UITextView *textView;
}

@property (nonatomic, retain) UITextView *textView;

- (void) handleURL:(NSURL *)url;

@end
