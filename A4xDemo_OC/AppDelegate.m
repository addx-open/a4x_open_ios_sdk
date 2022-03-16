//
//  AppDelegate.m
//  A4xDemo_OC
//
//  Created by 郭建恒 on 2022/2/17.
//

#import "AppDelegate.h"
#import "ViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    UINavigationController *nav = [[UINavigationController alloc] init];
    ViewController *rootVC = [[ViewController alloc] init];
    [nav pushViewController: rootVC animated: true];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}





@end
