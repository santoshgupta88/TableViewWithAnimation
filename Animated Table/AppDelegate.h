//
//  AppDelegate.h
//  Animated Table
//
//  Created by Santosh Gupta on 18/06/13.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (nonatomic,retain) UIImageView *splashScreen;
@property (nonatomic,retain) UIActivityIndicatorView *activityIndicator;
@end
