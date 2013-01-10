//
//  Move.m
//  Pokemon Online
//
//  Created by Andrew Colsch on 11/26/12.
//  Copyright (c) 2012 Andrew Colsch. All rights reserved.
//

#import "Move.h"

@implementation Move

+(id)MoveFromNumber:(int)num
{
	Move *theMove = [[Move alloc] init];
	
	NSString *text = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/moves.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	NSRange ranger = [text rangeOfString:[NSString stringWithFormat:@"%d ",num]];
	if (ranger.location==NSNotFound) {
		theMove.name = @"NO NAME";
	}
	else {
		text = [text substringFromIndex:ranger.location];
		ranger = [text rangeOfString:@" "];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@"\n"];
		text = [text substringToIndex:ranger.location];
		theMove.name = [[NSString alloc] initWithString:text];
	}
	
	text = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/move_description.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [text rangeOfString:[NSString stringWithFormat:@"%d ",num]];
	if (ranger.location==NSNotFound) {
		theMove.description = @"NO DESCRIPTION";
	}
	else {
		text = [text substringFromIndex:ranger.location];
		ranger = [text rangeOfString:@" "];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@"\n"];
		text = [text substringToIndex:ranger.location];
		theMove.description = [[NSString alloc] initWithString:text];
	}
	
	text = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/move_effect.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [text rangeOfString:[NSString stringWithFormat:@"%d ",num]];
	if (ranger.location==NSNotFound) {
		theMove.effect = @"No Effect";
	}
	else {
		text = [text substringFromIndex:ranger.location];
		ranger = [text rangeOfString:@" "];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@"\n"];
		text = [text substringToIndex:ranger.location];
		theMove.effect = [[NSString alloc] initWithString:text];
	}
	
	text = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/accuracy_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [text rangeOfString:[NSString stringWithFormat:@"%d ",num]];
	if (ranger.location==NSNotFound) {
		theMove.accuracy = 101;
	}
	else {
		text = [text substringFromIndex:ranger.location];
		ranger = [text rangeOfString:@" "];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@"\n"];
		text = [text substringToIndex:ranger.location];
		theMove.accuracy = [text intValue];
	}
	
	text = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/category_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [text rangeOfString:[NSString stringWithFormat:@"%d ",num]];
	if (ranger.location==NSNotFound) {
		theMove.category = 0;
	}
	else {
		text = [text substringFromIndex:ranger.location];
		ranger = [text rangeOfString:@" "];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@"\n"];
		text = [text substringToIndex:ranger.location];
		theMove.category = [text intValue];
	}
	
	text = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/caused_effect_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [text rangeOfString:[NSString stringWithFormat:@"%d ",num]];
	if (ranger.location==NSNotFound) {
		theMove.causedEffect = 0;
	}
	else {
		text = [text substringFromIndex:ranger.location];
		ranger = [text rangeOfString:@" "];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@"\n"];
		text = [text substringToIndex:ranger.location];
		theMove.causedEffect = [text intValue];
	}
	
	text = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/crit_rate_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [text rangeOfString:[NSString stringWithFormat:@"%d ",num]];
	if (ranger.location==NSNotFound) {
		theMove.critRate = 0;
	}
	else {
		text = [text substringFromIndex:ranger.location];
		ranger = [text rangeOfString:@" "];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@"\n"];
		text = [text substringToIndex:ranger.location];
		theMove.critRate = [text intValue];
	}
	
	text = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/damage_class_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [text rangeOfString:[NSString stringWithFormat:@"%d ",num]];
	if (ranger.location==NSNotFound) {
		theMove.damageClass = 0;
	}
	else {
		text = [text substringFromIndex:ranger.location];
		ranger = [text rangeOfString:@" "];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@"\n"];
		text = [text substringToIndex:ranger.location];
		theMove.damageClass = [text intValue];
	}
	
	text = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/caused_effect_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [text rangeOfString:[NSString stringWithFormat:@"%d ",num]];
	if (ranger.location==NSNotFound) {
		theMove.effect = @"No Effect";
	}
	else {
		text = [text substringFromIndex:ranger.location];
		ranger = [text rangeOfString:@" "];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@"\n"];
		text = [text substringToIndex:ranger.location];
		theMove.effect = [[NSString alloc] initWithString:text];
	}
	
	text = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/effect_chance_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [text rangeOfString:[NSString stringWithFormat:@"%d ",num]];
	if (ranger.location==NSNotFound) {
		theMove.effectChance = 0;
	}
	else {
		text = [text substringFromIndex:ranger.location];
		ranger = [text rangeOfString:@" "];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@"\n"];
		text = [text substringToIndex:ranger.location];
		theMove.effectChance = [text intValue];
	}
	
	text = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/flags_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [text rangeOfString:[NSString stringWithFormat:@"%d ",num]];
	if (ranger.location==NSNotFound) {
		theMove.flags = 0;
	}
	else {
		text = [text substringFromIndex:ranger.location];
		ranger = [text rangeOfString:@" "];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@"\n"];
		text = [text substringToIndex:ranger.location];
		theMove.flags = [text intValue];
	}
	
	text = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/flinch_chance_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [text rangeOfString:[NSString stringWithFormat:@"%d ",num]];
	if (ranger.location==NSNotFound) {
		theMove.flinchChance = 0;
	}
	else {
		text = [text substringFromIndex:ranger.location];
		ranger = [text rangeOfString:@" "];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@"\n"];
		text = [text substringToIndex:ranger.location];
		theMove.flinchChance = [text intValue];
	}
	
	text = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/healing_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [text rangeOfString:[NSString stringWithFormat:@"%d ",num]];
	if (ranger.location==NSNotFound) {
		theMove.healing = 0;
	}
	else {
		text = [text substringFromIndex:ranger.location];
		ranger = [text rangeOfString:@" "];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@"\n"];
		text = [text substringToIndex:ranger.location];
		theMove.healing = [text intValue];
	}
	
	text = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/max_turns_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [text rangeOfString:[NSString stringWithFormat:@"%d ",num]];
	if (ranger.location==NSNotFound) {
		theMove.maxTurns = 0;
	}
	else {
		text = [text substringFromIndex:ranger.location];
		ranger = [text rangeOfString:@" "];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@"\n"];
		text = [text substringToIndex:ranger.location];
		theMove.maxTurns = [text intValue];
	}
	
	text = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/min_max_hits_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [text rangeOfString:[NSString stringWithFormat:@"%d ",num]];
	if (ranger.location==NSNotFound) {
		theMove.minmaxhits = 0;
	}
	else {
		text = [text substringFromIndex:ranger.location];
		ranger = [text rangeOfString:@" "];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@"\n"];
		text = [text substringToIndex:ranger.location];
		theMove.minmaxhits = [text intValue];
	}
	
	text = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/min_turns_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [text rangeOfString:[NSString stringWithFormat:@"%d ",num]];
	if (ranger.location==NSNotFound) {
		theMove.minTurns = 0;
	}
	else {
		text = [text substringFromIndex:ranger.location];
		ranger = [text rangeOfString:@" "];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@"\n"];
		text = [text substringToIndex:ranger.location];
		theMove.minTurns = [text intValue];
	}
	
	text = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/power_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [text rangeOfString:[NSString stringWithFormat:@"%d ",num]];
	if (ranger.location==NSNotFound) {
		theMove.power = 0;
	}
	else {
		text = [text substringFromIndex:ranger.location];
		ranger = [text rangeOfString:@" "];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@"\n"];
		text = [text substringToIndex:ranger.location];
		theMove.power = [text intValue];
	}
	
	text = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/pp_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [text rangeOfString:[NSString stringWithFormat:@"%d ",num]];
	if (ranger.location==NSNotFound) {
		theMove.pp = 0;
	}
	else {
		text = [text substringFromIndex:ranger.location];
		ranger = [text rangeOfString:@" "];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@"\n"];
		text = [text substringToIndex:ranger.location];
		theMove.pp = [text intValue];
	}
	
	text = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/priority_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [text rangeOfString:[NSString stringWithFormat:@"%d ",num]];
	if (ranger.location==NSNotFound) {
		theMove.priority = 0;
	}
	else {
		text = [text substringFromIndex:ranger.location];
		ranger = [text rangeOfString:@" "];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@"\n"];
		text = [text substringToIndex:ranger.location];
		theMove.priority = [text intValue];
	}
	
	text = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/range_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [text rangeOfString:[NSString stringWithFormat:@"%d ",num]];
	if (ranger.location==NSNotFound) {
		theMove.range = 0;
	}
	else {
		text = [text substringFromIndex:ranger.location];
		ranger = [text rangeOfString:@" "];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@"\n"];
		text = [text substringToIndex:ranger.location];
		theMove.range = [text intValue];
	}
	
	text = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/recoil_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [text rangeOfString:[NSString stringWithFormat:@"%d ",num]];
	if (ranger.location==NSNotFound) {
		theMove.recoil = 0;
	}
	else {
		text = [text substringFromIndex:ranger.location];
		ranger = [text rangeOfString:@" "];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@"\n"];
		text = [text substringToIndex:ranger.location];
		theMove.recoil = [text intValue];
	}
	
	text = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/special_effect_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [text rangeOfString:[NSString stringWithFormat:@"%d ",num]];
	if (ranger.location==NSNotFound) {
		theMove.specialEffect = @"#156 is free";
	}
	else {
		text = [text substringFromIndex:ranger.location];
		ranger = [text rangeOfString:@" "];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@"\n"];
		text = [text substringToIndex:ranger.location];
		theMove.specialEffect = [[NSString alloc] initWithString:text];
	}
	
	text = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/statboost_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [text rangeOfString:[NSString stringWithFormat:@"%d ",num]];
	if (ranger.location==NSNotFound) {
		theMove.statAffected = 0;
	}
	else {
		text = [text substringFromIndex:ranger.location];
		ranger = [text rangeOfString:@" "];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@"\n"];
		text = [text substringToIndex:ranger.location];
		theMove.statAffected = [text intValue];
	}
	
	text = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/statboost_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [text rangeOfString:[NSString stringWithFormat:@"%d ",num]];
	if (ranger.location==NSNotFound) {
		theMove.statBoost = 0;
	}
	else {
		text = [text substringFromIndex:ranger.location];
		ranger = [text rangeOfString:@" "];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@"\n"];
		text = [text substringToIndex:ranger.location];
		theMove.statBoost = [text intValue];
	}
	
	text = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/statrate_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [text rangeOfString:[NSString stringWithFormat:@"%d ",num]];
	if (ranger.location==NSNotFound) {
		theMove.statRate = 0;
	}
	else {
		text = [text substringFromIndex:ranger.location];
		ranger = [text rangeOfString:@" "];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@"\n"];
		text = [text substringToIndex:ranger.location];
		theMove.statRate = [text intValue];
	}
	
	text = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/status_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [text rangeOfString:[NSString stringWithFormat:@"%d ",num]];
	if (ranger.location==NSNotFound) {
		theMove.status = 0;
	}
	else {
		text = [text substringFromIndex:ranger.location];
		ranger = [text rangeOfString:@" "];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@"\n"];
		text = [text substringToIndex:ranger.location];
		theMove.status = [text intValue];
	}
	
	text = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/type_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [text rangeOfString:[NSString stringWithFormat:@"\n%d ",num]];
	if (ranger.location==NSNotFound) {
		theMove.type = 0;
	}
	else {
		text = [text substringFromIndex:ranger.location];
		ranger = [text rangeOfString:@" "];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@"\n"];
		text = [text substringToIndex:ranger.location];
		theMove.type = [text intValue];
	}
	
	
	return theMove;
}

@end
