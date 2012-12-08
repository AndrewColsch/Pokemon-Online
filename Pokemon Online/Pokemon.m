//
//  Pokemon.m
//  Pokemon Online
//
//  Created by Andrew Colsch on 11/14/12.
//  Copyright (c) 2012 Andrew Colsch. All rights reserved.
//

#import "Pokemon.h"

@implementation Pokemon

- (id)init
{
	self.item = 0;
	self.ability = 0;
	self.number = 0;
	self.nature = 0;
	self.shiny = 0;
	self.nickname = @"Missingno";
	self.species = @"Missingno";
	self.generation = 0;
	self.forme = 0;
	self.happiness = 0;
	self.level = 0;
	self.gender = 0;
	self.subgeneration = 0;
	self.type1 = 0;
	self.type1 = 0;
	self.move1 = 0;
	self.move2 = 0;
	self.move3 = 0;
	self.move4 = 0;
	self.dv1 = 0;
	self.dv2 = 0;
	self.dv3 = 0;
	self.dv4 = 0;
	self.dv5 = 0;
	self.dv6 = 0;
	self.ev1 = 0;
	self.ev2 = 0;
	self.ev3 = 0;
	self.ev4 = 0;
	self.ev5 = 0;
	self.ev6 = 0;
	
	return self;
}

- (id)initWithItem:(int)it Ability:(int)ab Number:(int)nu Nature:(int)na Shiny:(int)sh Name:(NSString *)nm Species:(NSString *)sp Gen:(int)ge Forme:(int)fo Happiness:(int)ha Level:(int)le Gender:(int)se SubGen:(int)su Type1:(int)t1 Type2:(int)t2 Move1:(int)m1 Move2:(int)m2 Move3:(int)m3 Move4:(int)m4 DV1:(int)d1 DV2:(int)d2 DV3:(int)d3 DV4:(int)d4 DV5:(int)d5 DV6:(int)d6 EV1:(int)e1 EV2:(int)e2 EV3:(int)e3 EV4:(int)e4 EV5:(int)e5 EV6:(int)e6
{
	self.item = it;
	self.ability = ab;
	self.number = nu;
	self.nature = na;
	self.shiny = sh;
	self.nickname = nm;
	self.species = sp;
	self.generation = ge;
	self.forme = fo;
	self.happiness = ha;
	self.level = le;
	self.gender = se;
	self.subgeneration = su;
	self.type1 = t1;
	self.type2 = t2;
	self.move1 = m1;
	self.move2 = m2;
	self.move3 = m3;
	self.move4 = m4;
	self.dv1 = d1;
	self.dv2 = d2;
	self.dv3 = d3;
	self.dv4 = d4;
	self.dv5 = d5;
	self.dv6 = d6;
	self.ev1 = e1;
	self.ev2 = e2;
	self.ev3 = e3;
	self.ev4 = e4;
	self.ev5 = e5;
	self.ev6 = e6;
	
	return self;
}

- (id)initWithPokemon:(Pokemon *)oldPoke
{
	self.item = oldPoke.item;
	self.ability = oldPoke.ability;
	self.number = oldPoke.number;
	self.nature = oldPoke.nature;
	self.shiny = oldPoke.shiny;
	self.nickname = oldPoke.nickname;
	self.species = oldPoke.species;
	self.generation = oldPoke.generation;
	self.forme = oldPoke.forme;
	self.happiness = oldPoke.happiness;
	self.level = oldPoke.level;
	self.gender = oldPoke.gender;
	self.subgeneration = oldPoke.subgeneration;
	self.type1 = oldPoke.type1;
	self.type2 = oldPoke.type2;
	self.move1 = oldPoke.move1;
	self.move2 = oldPoke.move2;
	self.move3 = oldPoke.move3;
	self.move4 = oldPoke.move4;
	self.dv1 = oldPoke.dv1;
	self.dv2 = oldPoke.dv2;
	self.dv3 = oldPoke.dv3;
	self.dv4 = oldPoke.dv4;
	self.dv5 = oldPoke.dv5;
	self.dv6 = oldPoke.dv6;
	self.ev1 = oldPoke.ev1;
	self.ev2 = oldPoke.ev2;
	self.ev3 = oldPoke.ev3;
	self.ev4 = oldPoke.ev4;
	self.ev5 = oldPoke.ev5;
	self.ev6 = oldPoke.ev6;
	
	return self;
}

@end
