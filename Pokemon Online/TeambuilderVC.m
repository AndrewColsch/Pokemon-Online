//
//  TeambuilderVC.m
//  Pokemon Online
//
//  Created by Andrew Colsch on 11/14/12.
//  Copyright (c) 2012 Andrew Colsch. All rights reserved.
//

#import "TeambuilderVC.h"
#import "EditPokeVC.h"
#import "EditMoreVC.h"

@interface TeambuilderVC ()

@end

@implementation TeambuilderVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(swapToPoke:) name:@"swapToPoke" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(swapToMore:) name:@"swapToMore" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePoke:) name:@"updatePoke" object:nil];
}

-(void)swapToPoke:(NSNotification *)notis{
    NSDictionary *dict = notis.userInfo;
    Pokemon *passedPoke = (Pokemon *)[dict objectForKey:@"poketopass"];
	NSNumber *passedInd = (NSNumber *)[dict objectForKey:@"indtopass"];
	EditPokeVC *epvc = [[EditPokeVC alloc] initWithPokemon:passedPoke fromIndex:passedInd.intValue];
    [self presentViewController:epvc animated:YES completion:NULL];
}

-(void)swapToMore:(NSNotification *)notis{
    NSDictionary *dict = notis.userInfo;
    Pokemon *passedPoke = (Pokemon *)[dict objectForKey:@"poketopass"];
	NSNumber *passedInd = (NSNumber *)[dict objectForKey:@"indtopass"];
	EditMoreVC *emvc = [[EditMoreVC alloc] initWithPokemon:passedPoke fromIndex:passedInd.intValue];
    [self presentViewController:emvc animated:YES completion:NULL];
}

-(void)updatePoke:(NSNotification *)notis{
	NSDictionary *dict = notis.userInfo;
    Pokemon *passedPoke = (Pokemon *)[dict objectForKey:@"poketopass"];
	NSNumber *passedInd = (NSNumber *)[dict objectForKey:@"indtopass"];
	[mydelegate.activeTeam replaceObjectAtIndex:passedInd.integerValue withObject:passedPoke];
	[self refreshInterface];
}

- (IBAction)handlePokeTap:(UITapGestureRecognizer *)sender
{
	if (sender.state==UIGestureRecognizerStateEnded) {
		// Find which Pokemon was tapped
		CGPoint point = [sender locationInView:self.teamView];
		int x = point.x;
		int y = point.y;
		
		// First column
		if (x>=10&&x<=159) {
			if (y>=10&&y<=83) {
				EditPokeVC *epvc = [[EditPokeVC alloc] initWithPokemon:[mydelegate.activeTeam objectAtIndex:0] fromIndex:0];
				[self presentViewController:epvc animated:YES completion:NULL];
			}
			if (y>=93&&y<=166) {
				EditPokeVC *epvc = [[EditPokeVC alloc] initWithPokemon:[mydelegate.activeTeam objectAtIndex:2] fromIndex:2];
				[self presentViewController:epvc animated:YES completion:NULL];
			}
			if (y>=176&&y<=249) {
				EditPokeVC *epvc = [[EditPokeVC alloc] initWithPokemon:[mydelegate.activeTeam objectAtIndex:4] fromIndex:4];
				[self presentViewController:epvc animated:YES completion:NULL];
			}
		}
		if (x>=168&&x<=317) {
			if (y>=10&&y<=83) {
				EditPokeVC *epvc = [[EditPokeVC alloc] initWithPokemon:[mydelegate.activeTeam objectAtIndex:1] fromIndex:1];
				[self presentViewController:epvc animated:YES completion:NULL];
			}
			if (y>=93&&y<=166) {
				EditPokeVC *epvc = [[EditPokeVC alloc] initWithPokemon:[mydelegate.activeTeam objectAtIndex:3] fromIndex:3];
				[self presentViewController:epvc animated:YES completion:NULL];
			}
			if (y>=176&&y<=249) {
				EditPokeVC *epvc = [[EditPokeVC alloc] initWithPokemon:[mydelegate.activeTeam objectAtIndex:5] fromIndex:5];
				[self presentViewController:epvc animated:YES completion:NULL];
			}
		}
	}
}

- (IBAction)loadTeam:(id)sender
{
	[mydelegate.activeTeam removeAllObjects];
	NSString *path = [[NSBundle mainBundle] pathForResource:@"Whump" ofType:@"tp"];
	//NSString *path = [NSString stringWithFormat:@"%@/Teams/Team1.tp",mydelegate.basePath];
	NSString *fullcontent = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
	NSString *content = [[NSString alloc] initWithString:fullcontent];
	NSString *temp = [[NSString alloc] init];
	NSRange ranger;
	
	// Generation
	ranger = [content rangeOfString:@"gen="];
	content = [content substringFromIndex:ranger.location+5];
	ranger = [content rangeOfString:@"\""];
	temp = [content substringToIndex:ranger.location];
	mydelegate.activeGen = [temp intValue];
	
	// Default Tier
	ranger = [content rangeOfString:@"defaultTier="];
	content = [content substringFromIndex:ranger.location+13];
	ranger = [content rangeOfString:@"\""];
	temp = [content substringToIndex:ranger.location];
	mydelegate.activeTier = temp;
	
	// Sub-Generation
	ranger = [content rangeOfString:@"subgen="];
	content = [content substringFromIndex:ranger.location+8];
	ranger = [content rangeOfString:@"\""];
	temp = [content substringToIndex:ranger.location];
	mydelegate.activeSubgen = [temp intValue];
	
	// Pokemon
	NSRange pokefound = [content rangeOfString:@"<Pokemon"];
	int pokecount = 1;
	while (pokefound.location!=NSNotFound) {
		Pokemon *newpoke = [[Pokemon alloc] init];
		
		// Item
		int item = 0;
		ranger = [content rangeOfString:@"Item="];
		content = [content substringFromIndex:ranger.location+6];
		ranger = [content rangeOfString:@"\""];
		temp = [content substringToIndex:ranger.location];
		item = [temp intValue];
		newpoke.item = item;
		
		// Ability
		int abil = 0;
		ranger = [content rangeOfString:@"Ability="];
		content = [content substringFromIndex:ranger.location+9];
		ranger = [content rangeOfString:@"\""];
		temp = [content substringToIndex:ranger.location];
		abil = [temp intValue];
		newpoke.ability = abil;
		
		// Species
		int spec = 0;
		ranger = [content rangeOfString:@"Num="];
		content = [content substringFromIndex:ranger.location+5];
		ranger = [content rangeOfString:@"\""];
		temp = [content substringToIndex:ranger.location];
		spec = [temp intValue];
		newpoke.number = spec;
		
		// Nature
		int nat = 0;
		ranger = [content rangeOfString:@"Nature="];
		content = [content substringFromIndex:ranger.location+8];
		ranger = [content rangeOfString:@"\""];
		temp = [content substringToIndex:ranger.location];
		nat = [temp intValue];
		newpoke.nature = nat;
		
		// Shiny
		int shiny = 0;
		ranger = [content rangeOfString:@"Shiny="];
		content = [content substringFromIndex:ranger.location+7];
		ranger = [content rangeOfString:@"\""];
		temp = [content substringToIndex:ranger.location];
		shiny = [temp intValue];
		newpoke.shiny = shiny;
		
		// Nickname
		NSString *name;
		ranger = [content rangeOfString:@"Nickname="];
		content = [content substringFromIndex:ranger.location+10];
		ranger = [content rangeOfString:@"\""];
		temp = [content substringToIndex:ranger.location];
		name = temp;
		newpoke.nickname = name;
		
		// Generation
		int gen = 0;
		ranger = [content rangeOfString:@"Gen="];
		content = [content substringFromIndex:ranger.location+5];
		ranger = [content rangeOfString:@"\""];
		temp = [content substringToIndex:ranger.location];
		gen = [temp intValue];
		newpoke.generation = gen;
		
		// Forme
		int forme = 0;
		ranger = [content rangeOfString:@"Forme="];
		content = [content substringFromIndex:ranger.location+7];
		ranger = [content rangeOfString:@"\""];
		temp = [content substringToIndex:ranger.location];
		forme = [temp intValue];
		newpoke.forme = forme;
		
		// Happiness
		int happy = 0;
		ranger = [content rangeOfString:@"Happiness="];
		content = [content substringFromIndex:ranger.location+11];
		ranger = [content rangeOfString:@"\""];
		temp = [content substringToIndex:ranger.location];
		happy = [temp intValue];
		newpoke.happiness = happy;
		
		// Level
		int lvl = 0;
		ranger = [content rangeOfString:@"Lvl="];
		content = [content substringFromIndex:ranger.location+5];
		ranger = [content rangeOfString:@"\""];
		temp = [content substringToIndex:ranger.location];
		lvl = [temp intValue];
		newpoke.level = lvl;
		
		// Gender
		int sex = 0;
		ranger = [content rangeOfString:@"Gender="];
		content = [content substringFromIndex:ranger.location+8];
		ranger = [content rangeOfString:@"\""];
		temp = [content substringToIndex:ranger.location];
		sex = [temp intValue];
		newpoke.gender = sex;
		
		// Sub-Generation
		int subgen = 0;
		ranger = [content rangeOfString:@"SubGen="];
		content = [content substringFromIndex:ranger.location+8];
		ranger = [content rangeOfString:@"\""];
		temp = [content substringToIndex:ranger.location];
		subgen = [temp intValue];
		newpoke.subgeneration = subgen;
		
		// Moves
		ranger = [content rangeOfString:@"</Pokemon>"];
		NSString *pokecontent = [content substringToIndex:ranger.location];
		NSString *moveset = @"Moveset:";
		NSRange movefound = [pokecontent rangeOfString:@"<Move"];
		int ind = 1;
		while (movefound.location!=NSNotFound) {
			pokecontent = [pokecontent substringFromIndex:movefound.location+6];
			ranger = [pokecontent rangeOfString:@"</Move"];
			int move = [[pokecontent substringToIndex:ranger.location] intValue];
			moveset = [NSString stringWithFormat:@"%@ %d",moveset,move];
			movefound = [pokecontent rangeOfString:@"<Move"];
			switch (ind) {
				case 1:
					newpoke.move1 = move;
					break;
				case 2:
					newpoke.move2 = move;
					break;
				case 3:
					newpoke.move3 = move;
					break;
				case 4:
					newpoke.move4 = move;
					break;
				default:
					break;
			}
			ind++;
		}
		
		// DVs
		ranger = [content rangeOfString:@"</Pokemon>"];
		pokecontent = [content substringToIndex:ranger.location];
		NSString *dvset = @"DVs:";
		NSRange dvfound = [pokecontent rangeOfString:@"<DV"];
		ind = 1;
		while (dvfound.location!=NSNotFound) {
			pokecontent = [pokecontent substringFromIndex:dvfound.location+4];
			ranger = [pokecontent rangeOfString:@"</DV"];
			int dv = [[pokecontent substringToIndex:ranger.location] intValue];
			dvset = [NSString stringWithFormat:@"%@ %d",dvset,dv];
			dvfound = [pokecontent rangeOfString:@"<DV"];
			switch (ind) {
				case 1:
					newpoke.dv1 = dv;
					break;
				case 2:
					newpoke.dv2 = dv;
					break;
				case 3:
					newpoke.dv3 = dv;
					break;
				case 4:
					newpoke.dv4 = dv;
					break;
				case 5:
					newpoke.dv5 = dv;
					break;
				case 6:
					newpoke.dv6 = dv;
					break;
				default:
					break;
			}
			ind++;
		}
		
		// EVs
		ranger = [content rangeOfString:@"</Pokemon>"];
		pokecontent = [content substringToIndex:ranger.location];
		NSString *evset = @"EVs:";
		NSRange evfound = [pokecontent rangeOfString:@"<EV"];
		ind = 1;
		while (evfound.location!=NSNotFound) {
			pokecontent = [pokecontent substringFromIndex:evfound.location+4];
			ranger = [pokecontent rangeOfString:@"</EV"];
			int ev = [[pokecontent substringToIndex:ranger.location] intValue];
			evset = [NSString stringWithFormat:@"%@ %d",evset,ev];
			evfound = [pokecontent rangeOfString:@"<EV"];
			switch (ind) {
				case 1:
					newpoke.ev1 = ev;
					break;
				case 2:
					newpoke.ev2 = ev;
					break;
				case 3:
					newpoke.ev3 = ev;
					break;
				case 4:
					newpoke.ev4 = ev;
					break;
				case 5:
					newpoke.ev5 = ev;
					break;
				case 6:
					newpoke.ev6 = ev;
					break;
				default:
					break;
			}
			ind++;
		}
		
		content = [content substringFromIndex:ranger.location];
		pokefound = [content rangeOfString:@"<Pokemon"];
		[mydelegate.activeTeam addObject:newpoke];
		NSString *namelist;
		NSString *typelist;
		NSRange nameSpot;
		NSRange typeSpot;
		NSString *tempname;
		NSString *temptype;
		switch (pokecount) {
			case 1:
				// Image
				[self.pokeView1.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/%d.png",mydelegate.basePath,newpoke.number]]];
				if (newpoke.shiny) {
					[self.pokeView1.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/shiny/%d.png",mydelegate.basePath,newpoke.number]]];
				}
				// Level
				self.pokeView1.level.text = [NSString stringWithFormat:@"Lv. %d",newpoke.level];
				// Nickname
				self.pokeView1.nickname.text = newpoke.nickname;
				// Species
				namelist = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/released_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
				nameSpot = [namelist rangeOfString:[NSString stringWithFormat:@"%d:%d",newpoke.number,newpoke.forme]];
				if (nameSpot.location==NSNotFound) {
					UIAlertView *badspec = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"File contains invalid species or forme." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
					[badspec show];
					return;
				}
				else {
					tempname = [namelist substringFromIndex:nameSpot.location];
					nameSpot = [tempname rangeOfString:@" "];
					tempname = [tempname substringFromIndex:nameSpot.location+1];
					nameSpot = [tempname rangeOfString:@"\n"];
					newpoke.species = [tempname substringToIndex:nameSpot.location];
					self.pokeView1.species.text = newpoke.species;
				}
				// Types
				typelist = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/type1_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
				typeSpot = [typelist rangeOfString:[NSString stringWithFormat:@"%d:%d",newpoke.number,newpoke.forme]];
				if (typeSpot.location==NSNotFound) {
					UIAlertView *badspec = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Invalid species or forme specified." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
					[badspec show];
					return;
				}
				else {
					temptype = [typelist substringFromIndex:typeSpot.location];
					typeSpot = [temptype rangeOfString:@" "];
					temptype = [temptype substringFromIndex:typeSpot.location+1];
					typeSpot = [temptype rangeOfString:@"\n"];
					newpoke.type1 = [[temptype substringToIndex:typeSpot.location] intValue];
				}
				typelist = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/type2_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
				typeSpot = [typelist rangeOfString:[NSString stringWithFormat:@"%d:%d",newpoke.number,newpoke.forme]];
				if (typeSpot.location==NSNotFound) {
					UIAlertView *badspec = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Invalid species or forme specified." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
					[badspec show];
					return;
				}
				else {
					temptype = [typelist substringFromIndex:typeSpot.location];
					typeSpot = [temptype rangeOfString:@" "];
					temptype = [temptype substringFromIndex:typeSpot.location+1];
					typeSpot = [temptype rangeOfString:@"\n"];
					newpoke.type2 = [[temptype substringToIndex:typeSpot.location] intValue];
				}
				// Item
				if (newpoke.item>=8000) {
					// Berries are given their own set of item numbers starting at 8000, but the images for them still start at 1.png
					[self.pokeView1.item setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Berries/%d.png",mydelegate.basePath,(newpoke.item-7999)]]];
				} else {
					[self.pokeView1.item setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Items/%d.png",mydelegate.basePath,newpoke.item]]];
				}
				break;
			case 2:
				// Image
				[self.pokeView2.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/%d.png",mydelegate.basePath,newpoke.number]]];
				if (newpoke.shiny) {
					[self.pokeView2.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/shiny/%d.png",mydelegate.basePath,newpoke.number]]];
				}
				// Level
				self.pokeView2.level.text = [NSString stringWithFormat:@"Lv. %d",newpoke.level];
				// Nickname
				self.pokeView2.nickname.text = newpoke.nickname;
				// Species
				namelist = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/released_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
				nameSpot = [namelist rangeOfString:[NSString stringWithFormat:@"%d:%d",newpoke.number,newpoke.forme]];
				if (nameSpot.location==NSNotFound) {
					UIAlertView *badspec = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"File contains invalid species or forme." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
					[badspec show];
					return;
				}
				else {
					tempname = [namelist substringFromIndex:nameSpot.location];
					nameSpot = [tempname rangeOfString:@" "];
					tempname = [tempname substringFromIndex:nameSpot.location+1];
					nameSpot = [tempname rangeOfString:@"\n"];
					newpoke.species = [tempname substringToIndex:nameSpot.location];
					self.pokeView2.species.text = newpoke.species;
				}
				// Types
				typelist = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/type1_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
				typeSpot = [typelist rangeOfString:[NSString stringWithFormat:@"%d:%d",newpoke.number,newpoke.forme]];
				if (typeSpot.location==NSNotFound) {
					UIAlertView *badspec = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Invalid species or forme specified." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
					[badspec show];
					return;
				}
				else {
					temptype = [typelist substringFromIndex:typeSpot.location];
					typeSpot = [temptype rangeOfString:@" "];
					temptype = [temptype substringFromIndex:typeSpot.location+1];
					typeSpot = [temptype rangeOfString:@"\n"];
					newpoke.type1 = [[temptype substringToIndex:typeSpot.location] intValue];
				}
				typelist = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/type2_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
				typeSpot = [typelist rangeOfString:[NSString stringWithFormat:@"%d:%d",newpoke.number,newpoke.forme]];
				if (typeSpot.location==NSNotFound) {
					UIAlertView *badspec = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Invalid species or forme specified." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
					[badspec show];
					return;
				}
				else {
					temptype = [typelist substringFromIndex:typeSpot.location];
					typeSpot = [temptype rangeOfString:@" "];
					temptype = [temptype substringFromIndex:typeSpot.location+1];
					typeSpot = [temptype rangeOfString:@"\n"];
					newpoke.type2 = [[temptype substringToIndex:typeSpot.location] intValue];
				}
				// Item
				if (newpoke.item>=8000) {
					// Berries are given their own set of item numbers starting at 8000, but the images for them still start at 1.png
					[self.pokeView2.item setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Berries/%d.png",mydelegate.basePath,(newpoke.item-7999)]]];
				} else {
					[self.pokeView2.item setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Items/%d.png",mydelegate.basePath,newpoke.item]]];
				}
				break;
			case 3:
				// Image
				[self.pokeView3.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/%d.png",mydelegate.basePath,newpoke.number]]];
				if (newpoke.shiny) {
					[self.pokeView3.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/shiny/%d.png",mydelegate.basePath,newpoke.number]]];
				}
				// Level
				self.pokeView3.level.text = [NSString stringWithFormat:@"Lv. %d",newpoke.level];
				// Nickname
				self.pokeView3.nickname.text = newpoke.nickname;
				// Species
				namelist = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/released_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
				nameSpot = [namelist rangeOfString:[NSString stringWithFormat:@"%d:%d",newpoke.number,newpoke.forme]];
				if (nameSpot.location==NSNotFound) {
					UIAlertView *badspec = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"File contains invalid species or forme." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
					[badspec show];
					return;
				}
				else {
					tempname = [namelist substringFromIndex:nameSpot.location];
					nameSpot = [tempname rangeOfString:@" "];
					tempname = [tempname substringFromIndex:nameSpot.location+1];
					nameSpot = [tempname rangeOfString:@"\n"];
					newpoke.species = [tempname substringToIndex:nameSpot.location];
					self.pokeView3.species.text = newpoke.species;
				}
				// Types
				typelist = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/type1_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
				typeSpot = [typelist rangeOfString:[NSString stringWithFormat:@"%d:%d",newpoke.number,newpoke.forme]];
				if (typeSpot.location==NSNotFound) {
					UIAlertView *badspec = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Invalid species or forme specified." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
					[badspec show];
					return;
				}
				else {
					temptype = [typelist substringFromIndex:typeSpot.location];
					typeSpot = [temptype rangeOfString:@" "];
					temptype = [temptype substringFromIndex:typeSpot.location+1];
					typeSpot = [temptype rangeOfString:@"\n"];
					newpoke.type1 = [[temptype substringToIndex:typeSpot.location] intValue];
				}
				typelist = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/type2_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
				typeSpot = [typelist rangeOfString:[NSString stringWithFormat:@"%d:%d",newpoke.number,newpoke.forme]];
				if (typeSpot.location==NSNotFound) {
					UIAlertView *badspec = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Invalid species or forme specified." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
					[badspec show];
					return;
				}
				else {
					temptype = [typelist substringFromIndex:typeSpot.location];
					typeSpot = [temptype rangeOfString:@" "];
					temptype = [temptype substringFromIndex:typeSpot.location+1];
					typeSpot = [temptype rangeOfString:@"\n"];
					newpoke.type2 = [[temptype substringToIndex:typeSpot.location] intValue];
				}
				// Item
				if (newpoke.item>=8000) {
					// Berries are given their own set of item numbers starting at 8000, but the images for them still start at 1.png
					[self.pokeView3.item setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Berries/%d.png",mydelegate.basePath,(newpoke.item-7999)]]];
				} else {
					[self.pokeView3.item setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Items/%d.png",mydelegate.basePath,newpoke.item]]];
				}
				break;
			case 4:
				// Image
				[self.pokeView4.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/%d.png",mydelegate.basePath,newpoke.number]]];
				if (newpoke.shiny) {
					[self.pokeView4.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/shiny/%d.png",mydelegate.basePath,newpoke.number]]];
				}
				// Level
				self.pokeView4.level.text = [NSString stringWithFormat:@"Lv. %d",newpoke.level];
				// Nickname
				self.pokeView4.nickname.text = newpoke.nickname;
				// Species
				namelist = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/released_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
				nameSpot = [namelist rangeOfString:[NSString stringWithFormat:@"%d:%d",newpoke.number,newpoke.forme]];
				if (nameSpot.location==NSNotFound) {
					UIAlertView *badspec = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"File contains invalid species or forme." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
					[badspec show];
					return;
				}
				else {
					tempname = [namelist substringFromIndex:nameSpot.location];
					nameSpot = [tempname rangeOfString:@" "];
					tempname = [tempname substringFromIndex:nameSpot.location+1];
					nameSpot = [tempname rangeOfString:@"\n"];
					newpoke.species = [tempname substringToIndex:nameSpot.location];
					self.pokeView4.species.text = newpoke.species;
				}
				// Types
				typelist = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/type1_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
				typeSpot = [typelist rangeOfString:[NSString stringWithFormat:@"%d:%d",newpoke.number,newpoke.forme]];
				if (typeSpot.location==NSNotFound) {
					UIAlertView *badspec = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Invalid species or forme specified." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
					[badspec show];
					return;
				}
				else {
					temptype = [typelist substringFromIndex:typeSpot.location];
					typeSpot = [temptype rangeOfString:@" "];
					temptype = [temptype substringFromIndex:typeSpot.location+1];
					typeSpot = [temptype rangeOfString:@"\n"];
					newpoke.type1 = [[temptype substringToIndex:typeSpot.location] intValue];
				}
				typelist = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/type2_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
				typeSpot = [typelist rangeOfString:[NSString stringWithFormat:@"%d:%d",newpoke.number,newpoke.forme]];
				if (typeSpot.location==NSNotFound) {
					UIAlertView *badspec = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Invalid species or forme specified." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
					[badspec show];
					return;
				}
				else {
					temptype = [typelist substringFromIndex:typeSpot.location];
					typeSpot = [temptype rangeOfString:@" "];
					temptype = [temptype substringFromIndex:typeSpot.location+1];
					typeSpot = [temptype rangeOfString:@"\n"];
					newpoke.type2 = [[temptype substringToIndex:typeSpot.location] intValue];
				}
				// Item
				if (newpoke.item>=8000) {
					// Berries are given their own set of item numbers starting at 8000, but the images for them still start at 1.png
					[self.pokeView4.item setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Berries/%d.png",mydelegate.basePath,(newpoke.item-7999)]]];
				} else {
					[self.pokeView4.item setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Items/%d.png",mydelegate.basePath,newpoke.item]]];
				}
				break;
			case 5:
				// Image
				[self.pokeView5.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/%d.png",mydelegate.basePath,newpoke.number]]];
				if (newpoke.shiny) {
					[self.pokeView5.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/shiny/%d.png",mydelegate.basePath,newpoke.number]]];
				}
				// Level
				self.pokeView5.level.text = [NSString stringWithFormat:@"Lv. %d",newpoke.level];
				// Nickname
				self.pokeView5.nickname.text = newpoke.nickname;
				// Species
				namelist = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/released_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
				nameSpot = [namelist rangeOfString:[NSString stringWithFormat:@"%d:%d",newpoke.number,newpoke.forme]];
				if (nameSpot.location==NSNotFound) {
					UIAlertView *badspec = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"File contains invalid species or forme." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
					[badspec show];
					return;
				}
				else {
					tempname = [namelist substringFromIndex:nameSpot.location];
					nameSpot = [tempname rangeOfString:@" "];
					tempname = [tempname substringFromIndex:nameSpot.location+1];
					nameSpot = [tempname rangeOfString:@"\n"];
					newpoke.species = [tempname substringToIndex:nameSpot.location];
					self.pokeView5.species.text = newpoke.species;
				}
				// Types
				typelist = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/type1_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
				typeSpot = [typelist rangeOfString:[NSString stringWithFormat:@"%d:%d",newpoke.number,newpoke.forme]];
				if (typeSpot.location==NSNotFound) {
					UIAlertView *badspec = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Invalid species or forme specified." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
					[badspec show];
					return;
				}
				else {
					temptype = [typelist substringFromIndex:typeSpot.location];
					typeSpot = [temptype rangeOfString:@" "];
					temptype = [temptype substringFromIndex:typeSpot.location+1];
					typeSpot = [temptype rangeOfString:@"\n"];
					newpoke.type1 = [[temptype substringToIndex:typeSpot.location] intValue];
				}
				typelist = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/type2_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
				typeSpot = [typelist rangeOfString:[NSString stringWithFormat:@"%d:%d",newpoke.number,newpoke.forme]];
				if (typeSpot.location==NSNotFound) {
					UIAlertView *badspec = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Invalid species or forme specified." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
					[badspec show];
					return;
				}
				else {
					temptype = [typelist substringFromIndex:typeSpot.location];
					typeSpot = [temptype rangeOfString:@" "];
					temptype = [temptype substringFromIndex:typeSpot.location+1];
					typeSpot = [temptype rangeOfString:@"\n"];
					newpoke.type2 = [[temptype substringToIndex:typeSpot.location] intValue];
				}
				// Item
				if (newpoke.item>=8000) {
					// Berries are given their own set of item numbers starting at 8000, but the images for them still start at 1.png
					[self.pokeView5.item setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Berries/%d.png",mydelegate.basePath,(newpoke.item-7999)]]];
				} else {
					[self.pokeView5.item setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Items/%d.png",mydelegate.basePath,newpoke.item]]];
				}
				break;
			case 6:
				// Image
				[self.pokeView6.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/%d.png",mydelegate.basePath,newpoke.number]]];
				if (newpoke.shiny) {
					[self.pokeView6.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/shiny/%d.png",mydelegate.basePath,newpoke.number]]];
				}
				// Level
				self.pokeView6.level.text = [NSString stringWithFormat:@"Lv. %d",newpoke.level];
				// Nickname
				self.pokeView6.nickname.text = newpoke.nickname;
				// Species
				namelist = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/released_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
				nameSpot = [namelist rangeOfString:[NSString stringWithFormat:@"%d:%d",newpoke.number,newpoke.forme]];
				if (nameSpot.location==NSNotFound) {
					UIAlertView *badspec = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"File contains invalid species or forme." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
					[badspec show];
					return;
				}
				else {
					tempname = [namelist substringFromIndex:nameSpot.location];
					nameSpot = [tempname rangeOfString:@" "];
					tempname = [tempname substringFromIndex:nameSpot.location+1];
					nameSpot = [tempname rangeOfString:@"\n"];
					newpoke.species = [tempname substringToIndex:nameSpot.location];
					self.pokeView6.species.text = newpoke.species;
				}
				// Types
				typelist = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/type1_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
				typeSpot = [typelist rangeOfString:[NSString stringWithFormat:@"%d:%d",newpoke.number,newpoke.forme]];
				if (typeSpot.location==NSNotFound) {
					UIAlertView *badspec = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Invalid species or forme specified." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
					[badspec show];
					return;
				}
				else {
					temptype = [typelist substringFromIndex:typeSpot.location];
					typeSpot = [temptype rangeOfString:@" "];
					temptype = [temptype substringFromIndex:typeSpot.location+1];
					typeSpot = [temptype rangeOfString:@"\n"];
					newpoke.type1 = [[temptype substringToIndex:typeSpot.location] intValue];
				}
				typelist = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/type2_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
				typeSpot = [typelist rangeOfString:[NSString stringWithFormat:@"%d:%d",newpoke.number,newpoke.forme]];
				if (typeSpot.location==NSNotFound) {
					UIAlertView *badspec = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Invalid species or forme specified." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
					[badspec show];
					return;
				}
				else {
					temptype = [typelist substringFromIndex:typeSpot.location];
					typeSpot = [temptype rangeOfString:@" "];
					temptype = [temptype substringFromIndex:typeSpot.location+1];
					typeSpot = [temptype rangeOfString:@"\n"];
					newpoke.type2 = [[temptype substringToIndex:typeSpot.location] intValue];
				}
				// Item
				if (newpoke.item>=8000) {
					// Berries are given their own set of item numbers starting at 8000, but the images for them still start at 1.png
					[self.pokeView6.item setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Berries/%d.png",mydelegate.basePath,(newpoke.item-7999)]]];
				} else {
					[self.pokeView6.item setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Items/%d.png",mydelegate.basePath,newpoke.item]]];
				}
				break;
			default:
				break;
		}
		pokecount++;
	}
}

- (void)refreshInterface
{
	// POKE 1
	Pokemon *temppoke = [mydelegate.activeTeam objectAtIndex:0];
	// Image
	[self.pokeView1.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/%d.png",mydelegate.basePath,temppoke.number]]];
	if (temppoke.shiny) {
		[self.pokeView1.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/shiny/%d.png",mydelegate.basePath,temppoke.number]]];
	}
	// Level
	self.pokeView1.level.text = [NSString stringWithFormat:@"Lv. %d",temppoke.level];
	// Nickname
	self.pokeView1.nickname.text = temppoke.nickname;
	// Species
	self.pokeView1.species.text = temppoke.species;
	// Item
	if (temppoke.item>=8000) {
		// Berries are given their own set of item numbers starting at 8000, but the images for them still start at 1.png
		[self.pokeView1.item setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Berries/%d.png",mydelegate.basePath,(temppoke.item-7999)]]];
	} else {
		[self.pokeView1.item setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Items/%d.png",mydelegate.basePath,temppoke.item]]];
	}
	// POKE 2
	temppoke = [mydelegate.activeTeam objectAtIndex:1];
	// Image
	[self.pokeView2.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/%d.png",mydelegate.basePath,temppoke.number]]];
	if (temppoke.shiny) {
		[self.pokeView2.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/shiny/%d.png",mydelegate.basePath,temppoke.number]]];
	}
	// Level
	self.pokeView2.level.text = [NSString stringWithFormat:@"Lv. %d",temppoke.level];
	// Nickname
	self.pokeView2.nickname.text = temppoke.nickname;
	// Species
	self.pokeView2.species.text = temppoke.species;
	// Item
	if (temppoke.item>=8000) {
		// Berries are given their own set of item numbers starting at 8000, but the images for them still start at 1.png
		[self.pokeView2.item setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Berries/%d.png",mydelegate.basePath,(temppoke.item-7999)]]];
	} else {
		[self.pokeView2.item setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Items/%d.png",mydelegate.basePath,temppoke.item]]];
	}
	// POKE 3
	temppoke = [mydelegate.activeTeam objectAtIndex:2];
	// Image
	[self.pokeView3.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/%d.png",mydelegate.basePath,temppoke.number]]];
	if (temppoke.shiny) {
		[self.pokeView3.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/shiny/%d.png",mydelegate.basePath,temppoke.number]]];
	}
	// Level
	self.pokeView3.level.text = [NSString stringWithFormat:@"Lv. %d",temppoke.level];
	// Nickname
	self.pokeView3.nickname.text = temppoke.nickname;
	// Species
	self.pokeView3.species.text = temppoke.species;
	// Item
	if (temppoke.item>=8000) {
		// Berries are given their own set of item numbers starting at 8000, but the images for them still start at 1.png
		[self.pokeView3.item setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Berries/%d.png",mydelegate.basePath,(temppoke.item-7999)]]];
	} else {
		[self.pokeView3.item setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Items/%d.png",mydelegate.basePath,temppoke.item]]];
	}
	// POKE 4
	temppoke = [mydelegate.activeTeam objectAtIndex:3];
	// Image
	[self.pokeView4.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/%d.png",mydelegate.basePath,temppoke.number]]];
	if (temppoke.shiny) {
		[self.pokeView4.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/shiny/%d.png",mydelegate.basePath,temppoke.number]]];
	}
	// Level
	self.pokeView4.level.text = [NSString stringWithFormat:@"Lv. %d",temppoke.level];
	// Nickname
	self.pokeView4.nickname.text = temppoke.nickname;
	// Species
	self.pokeView4.species.text = temppoke.species;
	// Item
	if (temppoke.item>=8000) {
		// Berries are given their own set of item numbers starting at 8000, but the images for them still start at 1.png
		[self.pokeView4.item setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Berries/%d.png",mydelegate.basePath,(temppoke.item-7999)]]];
	} else {
		[self.pokeView4.item setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Items/%d.png",mydelegate.basePath,temppoke.item]]];
	}
	// POKE 5
	temppoke = [mydelegate.activeTeam objectAtIndex:4];
	// Image
	[self.pokeView5.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/%d.png",mydelegate.basePath,temppoke.number]]];
	if (temppoke.shiny) {
		[self.pokeView5.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/shiny/%d.png",mydelegate.basePath,temppoke.number]]];
	}
	// Level
	self.pokeView5.level.text = [NSString stringWithFormat:@"Lv. %d",temppoke.level];
	// Nickname
	self.pokeView5.nickname.text = temppoke.nickname;
	// Species
	self.pokeView5.species.text = temppoke.species;
	// Item
	if (temppoke.item>=8000) {
		// Berries are given their own set of item numbers starting at 8000, but the images for them still start at 1.png
		[self.pokeView5.item setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Berries/%d.png",mydelegate.basePath,(temppoke.item-7999)]]];
	} else {
		[self.pokeView5.item setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Items/%d.png",mydelegate.basePath,temppoke.item]]];
	}
	// POKE 6
	temppoke = [mydelegate.activeTeam objectAtIndex:5];
	// Image
	[self.pokeView6.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/%d.png",mydelegate.basePath,temppoke.number]]];
	if (temppoke.shiny) {
		[self.pokeView6.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/shiny/%d.png",mydelegate.basePath,temppoke.number]]];
	}
	// Level
	self.pokeView6.level.text = [NSString stringWithFormat:@"Lv. %d",temppoke.level];
	// Nickname
	self.pokeView6.nickname.text = temppoke.nickname;
	// Species
	self.pokeView6.species.text = temppoke.species;
	// Item
	if (temppoke.item>=8000) {
		// Berries are given their own set of item numbers starting at 8000, but the images for them still start at 1.png
		[self.pokeView6.item setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Berries/%d.png",mydelegate.basePath,(temppoke.item-7999)]]];
	} else {
		[self.pokeView6.item setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Items/%d.png",mydelegate.basePath,temppoke.item]]];
	}
}

- (IBAction)saveTeam:(id)sender
{
	Pokemon *poke;
	NSString *path = [NSString stringWithFormat:@"%@/Teams/Team1.tp",mydelegate.basePath];
	// Team
	NSString *ostr = [NSString stringWithFormat:@"<Team version=\"%d\" gen=\"%d\" defaultTier=\"%@\" subgen=\"%d\">\n",1,mydelegate.activeGen,mydelegate.activeTier,mydelegate.activeSubgen];
	
	// Pokemon
	for (int x=0; x<6; x++) {
		poke = [mydelegate.activeTeam objectAtIndex:x];
		ostr = [NSString stringWithFormat:@"%@<Pokemon Item=\"%d\" Ability=\"%d\" Num=\"%d\" Nature=\"%d\" Shiny=\"%d\" Nickname=\"%@\" Gen=\"%d\" Forme=\"%d\" Happiness=\"%d\" Lvl=\"%d\" Gender=\"%d\" SubGen=\"%d\">\n",ostr,poke.item,poke.ability,poke.number,poke.nature,poke.shiny,poke.nickname,poke.generation,poke.forme,poke.happiness,poke.level,poke.gender,poke.subgeneration];
		ostr = [NSString stringWithFormat:@"%@<Move>%d</Move>\n",ostr,poke.move1];
		ostr = [NSString stringWithFormat:@"%@<Move>%d</Move>\n",ostr,poke.move2];
		ostr = [NSString stringWithFormat:@"%@<Move>%d</Move>\n",ostr,poke.move3];
		ostr = [NSString stringWithFormat:@"%@<Move>%d</Move>\n",ostr,poke.move4];
		ostr = [NSString stringWithFormat:@"%@<DV>%d</DV>\n",ostr,poke.dv1];
		ostr = [NSString stringWithFormat:@"%@<DV>%d</DV>\n",ostr,poke.dv2];
		ostr = [NSString stringWithFormat:@"%@<DV>%d</DV>\n",ostr,poke.dv3];
		ostr = [NSString stringWithFormat:@"%@<DV>%d</DV>\n",ostr,poke.dv4];
		ostr = [NSString stringWithFormat:@"%@<DV>%d</DV>\n",ostr,poke.dv5];
		ostr = [NSString stringWithFormat:@"%@<DV>%d</DV>\n",ostr,poke.dv6];
		ostr = [NSString stringWithFormat:@"%@<EV>%d</EV>\n",ostr,poke.ev1];
		ostr = [NSString stringWithFormat:@"%@<EV>%d</EV>\n",ostr,poke.ev2];
		ostr = [NSString stringWithFormat:@"%@<EV>%d</EV>\n",ostr,poke.ev3];
		ostr = [NSString stringWithFormat:@"%@<EV>%d</EV>\n",ostr,poke.ev4];
		ostr = [NSString stringWithFormat:@"%@<EV>%d</EV>\n",ostr,poke.ev5];
		ostr = [NSString stringWithFormat:@"%@<EV>%d</EV>\n",ostr,poke.ev6];
		ostr = [NSString stringWithFormat:@"%@</Pokemon>\n",ostr];
	}
	ostr = [NSString stringWithFormat:@"%@</Team>\n",ostr];
	
	[ostr writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

