# UITextView Links with User Options

This application demonstrates how to detect links within a `UITextView` which open in a custom `UIWebView` controller. With the custom controller providing the user the option to open the url in mobile Safari.

## Detecting Links

There is surprisingly little to no information on the Internet regarding this solution. Detecting links within a UITextView is the easy part.

    textView = [[UITextView alloc] init];
    textView.text = @"Visit http://www.google.com for great good.";

    textView.dataDetectorTypes = UIDataDetectorTypeLink;
    textView.editable = NO;

URLs are detected by setting the `dataDectorTypes` parameter to `UIDataDetectorTypeLink`, optionally set it to `UIDataDetectorTypeAll` to detect all data types. This will highlight the URL allowing the user to touch the link, which will open in Safari. The caveat is having to set `editable = NO`.

## Creating the Custom UIWebView Controller

I owe a lot of my UIWebView code to the open sourced version of [TwitterFon](http://github.com/jpick/twitterfon/blob/master/Classes/Controllers/WebViewController.m). I added a UIToolbar to the bottom to hold a back button, forward button, refresh button, and the action button. I made it as Tweetie-like as I could for granularity. When you invoke the action button a `UIActionSheet` will pop up asking the user if they want to open the page in Safari.

## But how do we open our links in our custom UIWebView controller in the first place?

This part was hard to figure out, initially. I eventually found [this post](http://stackoverflow.com/questions/1889262/iphone-sdk-opening-links-in-a-uitextview-in-a-web-view/2251898#2251898) on stackoverflow. What they say to do is basically create a UIApplication category to override `openURL`. You would also need some sort of watcher to keep track of your current view controller. I threw something [hacky](http://github.com/marksands/UITextViewLinkOptions/blob/master/Classes/UITextViewLinkOptionsAppDelegate.m#L14-22) together and found that it worked.

    @implementation UIApplication (Private)

    - (BOOL)customOpenURL:(NSURL*)url
    {
      AppDelegate *watcher = [[UIApplication sharedApplication] delegate];
      if (watcher.currentViewController) {
        [watcher.currentViewController handleURL:url];
        return YES;
    	}
      return NO;
    }
    
    @end

This solution works, but it's win/lose. You have the ability to open all links in your custom webview, but now it's impossible to invoke UIApplication's `openURL` which opens Safari since you are overriding the method.

One fix is actually to subclass UIApplication. Then, inside your category you can invoke `[super openURL:url]` if your watcher is nil, for instance. But subclassing UIApplication can be somewhat [funky](http://stackoverflow.com/questions/1399202).

The solution I ended up with was much cooler anyway.

## Method Swizzling

I had never heard of method swizzling before, but it sounded insane so I figured why not try it out. There's [plenty](http://stackoverflow.com/questions/1637604/method-swizzle-on-iphone-device) of [resources](http://samsoff.es/posts/customize-uikit-with-method-swizzling) on the [Internet](http://www.cocoadev.com/index.pl?MethodSwizzling) to hold your hand through this part. Basically, method swizzling is just a way to swap method implementations.

It's very hacky and somewhat dangerous, so I don't necessarily recommend it, but it works and does a swell job at it. Here's what swizzling looks like in a nutshell.

    #import <objc/runtime.h>
    ..
  
    Method customOpenUrl = class_getInstanceMethod([UIApplication class], @selector(customOpenURL:));
    Method openUrl = class_getInstanceMethod([UIApplication class], @selector(openURL:));
    method_exchangeImplementations(customOpenUrl, openUrl);

With method swizzling, you swap implementations between separate methods. For this to be possible with `OpenURL` I still had to create a `UIApplication (Private)` category, but I named my new method `customOpenURL:(NSURL*)url` instead. Now I could swizzle between `OpenURL` and `customOpenURL`. All I had to do now was swizzle the implementations on initialization and when the user is in the custom UIWebView controller I unswizzle them to open in Safari. Great success.

I understand this might be confusing, especially if you're new to Objective-C or iPhone development, but this is a really handy trick. I'm sure there's plenty of things out there that you can apply this solution to. But my main focus was getting URL detection to open in a custom UIWebView or Safari, and I found that solution. I hope this helps!\

### The Blog Post

[Can be found here](http://52apps.net/post/879106231/method-swizzling-uitextview-and-safari)