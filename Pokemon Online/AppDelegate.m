//
//  AppDelegate.m
//  Pokemon Online
//
//  Created by Andrew Colsch on 11/14/12.
//  Copyright (c) 2012 Andrew Colsch. All rights reserved.
//

#import "AppDelegate.h"
#import "Pokemon.h"

@implementation AppDelegate

@synthesize activeGen;
@synthesize activeSubgen;
@synthesize activeTier;
@synthesize activeTeam;
@synthesize basePath;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
	self.activeTeam = [[NSMutableArray alloc] initWithObjects:[[Pokemon alloc] init],[[Pokemon alloc] init],[[Pokemon alloc] init],[[Pokemon alloc] init],[[Pokemon alloc] init],[[Pokemon alloc] init],nil];
	self.activeGen = 0;
	self.activeSubgen = 0;
	self.activeTier = @"No Tier Selected";
	NSString *zipPath = [[NSBundle mainBundle] pathForResource:@"sprites_5g" ofType:@"zip"];
	NSRange lastslash = [zipPath rangeOfString:@"/" options:NSBackwardsSearch];
	self.basePath = [zipPath substringToIndex:lastslash.location+1];
	[SSZipArchive unzipFileAtPath:zipPath toDestination:self.basePath];
	
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
