//
//  AppDelegate.h
//  Pokemon Online
//
//  Created by Andrew Colsch on 11/14/12.
//  Copyright (c) 2012 Andrew Colsch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readwrite) int activeGen;
@property (readwrite) int activeSubgen;
@property (nonatomic, retain) NSString *activeTier;
@property (nonatomic, retain) NSMutableArray *activeTeam;
@property (nonatomic, retain) NSString *basePath;

@end
