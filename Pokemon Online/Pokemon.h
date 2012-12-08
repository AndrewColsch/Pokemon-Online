//
//  Pokemon.h
//  Pokemon Online
//
//  Created by Andrew Colsch on 11/14/12.
//  Copyright (c) 2012 Andrew Colsch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pokemon : NSObject

@property (readwrite) int item;
@property (readwrite) int ability;
@property (readwrite) int number;
@property (readwrite) int nature;
@property (readwrite) int shiny;
@property (nonatomic, retain) NSString *nickname;
@property (nonatomic, retain) NSString *species;
@property (readwrite) int generation;
@property (readwrite) int forme;
@property (readwrite) int happiness;
@property (readwrite) int level;
@property (readwrite) int gender;
@property (readwrite) int subgeneration;
@property (readwrite) int type1;
@property (readwrite) int type2;

@property (readwrite) int move1;
@property (readwrite) int move2;
@property (readwrite) int move3;
@property (readwrite) int move4;

@property (readwrite) int dv1;
@property (readwrite) int dv2;
@property (readwrite) int dv3;
@property (readwrite) int dv4;
@property (readwrite) int dv5;
@property (readwrite) int dv6;

@property (readwrite) int ev1;
@property (readwrite) int ev2;
@property (readwrite) int ev3;
@property (readwrite) int ev4;
@property (readwrite) int ev5;
@property (readwrite) int ev6;

- (id)initWithItem:(int)it Ability:(int)ab Number:(int)nu Nature:(int)na Shiny:(int)sh Name:(NSString *)nm Species:(NSString *)sp Gen:(int)ge Forme:(int)fo Happiness:(int)ha Level:(int)le Gender:(int)se SubGen:(int)su Type1:(int)t1 Type2:(int)t2 Move1:(int)m1 Move2:(int)m2 Move3:(int)m3 Move4:(int)m4 DV1:(int)d1 DV2:(int)d2 DV3:(int)d3 DV4:(int)d4 DV5:(int)d5 DV6:(int)d6 EV1:(int)e1 EV2:(int)e2 EV3:(int)e3 EV4:(int)e4 EV5:(int)e5 EV6:(int)e6;

- (id)initWithPokemon:(Pokemon *)oldPoke;

@end
