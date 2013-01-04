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
	
	if (![[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/Teams.tp",self.basePath]]) {
		NSString *temp = @"{start}\n";
		[temp writeToFile:[NSString stringWithFormat:@"%@/Teams.tp",self.basePath] atomically:YES encoding:NSUTF8StringEncoding error:nil];
	}
	
	// alphabetizing the item arrays
	self.itemAlphaNum = [[NSMutableArray alloc] init];
	self.berryAlphaNum = [[NSMutableArray alloc] init];
	
	NSMutableArray *tempItems = [[NSMutableArray alloc] init];
	NSMutableArray *tempItems2 = [[NSMutableArray alloc] init];
	
	NSString *iListFile = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/items.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	
	for (int x=0; x<=304; x++) {
		NSString *searchString = [NSString stringWithFormat:@"%d",x];
		NSString *tempString = iListFile;
		NSRange findName = [tempString rangeOfString:searchString];
		tempString = [tempString substringFromIndex:findName.location];
		findName = [tempString rangeOfString:@" "];
		tempString = [tempString substringFromIndex:findName.location+1];
		findName = [tempString rangeOfString:@"\n"];
		tempString = [tempString substringToIndex:findName.location];
		
		[tempItems addObject:tempString];
		[tempItems2 addObject:tempString];
	}
	
	// This SHOULD be a one-line quick fix for alphabetizing the item list
	// but for some reason it doesn't work quite right
	// tempItems2 = [tempItems sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
	for (int x=1; x<=304; x++) {
		for (int y=0; y<x; y++) {
			NSString *s1 = [tempItems2 objectAtIndex:x];
			NSString *s2 = [tempItems2 objectAtIndex:y];
			if ([s1 localizedCaseInsensitiveCompare:s2]==NSOrderedAscending) {
				[tempItems2 replaceObjectAtIndex:x withObject:s2];
				[tempItems2 replaceObjectAtIndex:y withObject:s1];
			}
		}
	}
	
	
	for (int x=0; x<=304; x++) {
		bool found = NO;
		for (int y=0; y<=304 && !found; y++) {
			NSString *s1 = [tempItems2 objectAtIndex:x];
			NSString *s2 = [tempItems objectAtIndex:y];
			if ([s1 isEqualToString:s2]) {
				NSNumber *tempInt = [[NSNumber alloc] initWithInt:y];
				[self.itemAlphaNum addObject:tempInt];
				found = YES;
			}
		}
		if (!found) {
			[self.itemAlphaNum addObject:[[NSNumber alloc] initWithInt:0]];
		}
	}
	
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
