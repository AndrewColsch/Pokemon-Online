//
//  Move.h
//  Pokemon Online
//
//  Created by Andrew Colsch on 11/26/12.
//  Copyright (c) 2012 Andrew Colsch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Move : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *effect;
@property (readwrite) int number;
@property (readwrite) int accuracy;
@property (readwrite) int category;
@property (readwrite) int causedEffect;
@property (readwrite) int critRate;
@property (readwrite) int damageClass;
@property (readwrite) int effectNumber;
@property (readwrite) int effectChance;
@property (readwrite) int flags;
@property (readwrite) int flinchChance;
@property (readwrite) int healing;
@property (readwrite) int minTurns;
@property (readwrite) int maxTurns;
@property (readwrite) int minmaxhits;
@property (readwrite) int power;
@property (readwrite) int pp;
@property (readwrite) int priority;
@property (readwrite) int range;
@property (readwrite) int recoil;
@property (nonatomic, retain) NSString *specialEffect;
@property (readwrite) int statAffected;
@property (readwrite) int statBoost;
@property (readwrite) int statRate;
@property (readwrite) int status;
@property (readwrite) int type;
@property (readwrite) NSString *learned;

+(id)MoveFromNumber:(int)num;

@end
