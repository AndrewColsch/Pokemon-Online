//
//  TeambuilderVC.m
//  Pokemon Online
//
//  Created by Andrew Colsch on 11/14/12.
//  Copyright (c) 2012 Andrew Colsch. All rights reserved.
//

#import "TeambuilderVC.h"

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
}

- (IBAction)loadTeam:(id)sender
{
	NSString *path = [[NSBundle mainBundle] pathForResource:@"Whump" ofType:@"tp"];
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
		NSRange nameSpot;
		NSString *tempname;
		switch (pokecount) {
			case 1:
				[self.pokeView1.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/black-white/%d.png",mydelegate.basePath,newpoke.number]]];
				if (newpoke.shiny) {
					[self.pokeView1.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/black-white/shiny/%d.png",mydelegate.basePath,newpoke.number]]];
				}
				self.pokeView1.level.text = [NSString stringWithFormat:@"Lv. %d",newpoke.level];
				self.pokeView1.nickname.text = newpoke.nickname;
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
					self.pokeView1.species.text = [tempname substringToIndex:nameSpot.location];
				}
				//[self.pokeView1.item setImage:[UIImage imageNamed:@"blah"]];
				break;
			case 2:
				[self.pokeView2.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/black-white/%d.png",mydelegate.basePath,newpoke.number]]];
				if (newpoke.shiny) {
					[self.pokeView2.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/black-white/shiny/%d.png",mydelegate.basePath,newpoke.number]]];
				}
				self.pokeView2.level.text = [NSString stringWithFormat:@"Lv. %d",newpoke.level];
				self.pokeView2.nickname.text = newpoke.nickname;
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
					self.pokeView2.species.text = [tempname substringToIndex:nameSpot.location];
				}
				break;
			case 3:
				[self.pokeView3.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/black-white/%d.png",mydelegate.basePath,newpoke.number]]];
				if (newpoke.shiny) {
					[self.pokeView3.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/black-white/shiny/%d.png",mydelegate.basePath,newpoke.number]]];
				}
				self.pokeView3.level.text = [NSString stringWithFormat:@"Lv. %d",newpoke.level];
				self.pokeView3.nickname.text = newpoke.nickname;
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
					self.pokeView3.species.text = [tempname substringToIndex:nameSpot.location];
				}
				break;
			case 4:
				[self.pokeView4.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/black-white/%d.png",mydelegate.basePath,newpoke.number]]];
				if (newpoke.shiny) {
					[self.pokeView4.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/black-white/shiny/%d.png",mydelegate.basePath,newpoke.number]]];
				}
				self.pokeView4.level.text = [NSString stringWithFormat:@"Lv. %d",newpoke.level];
				self.pokeView4.nickname.text = newpoke.nickname;
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
					self.pokeView4.species.text = [tempname substringToIndex:nameSpot.location];
				}
				break;
			case 5:
				[self.pokeView5.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/black-white/%d.png",mydelegate.basePath,newpoke.number]]];
				if (newpoke.shiny) {
					[self.pokeView5.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/black-white/shiny/%d.png",mydelegate.basePath,newpoke.number]]];
				}
				self.pokeView5.level.text = [NSString stringWithFormat:@"Lv. %d",newpoke.level];
				self.pokeView5.nickname.text = newpoke.nickname;
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
					self.pokeView5.species.text = [tempname substringToIndex:nameSpot.location];
				}
				break;
			case 6:
				[self.pokeView6.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/black-white/%d.png",mydelegate.basePath,newpoke.number]]];
				if (newpoke.shiny) {
					[self.pokeView6.image setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/black-white/shiny/%d.png",mydelegate.basePath,newpoke.number]]];
				}
				self.pokeView6.level.text = [NSString stringWithFormat:@"Lv. %d",newpoke.level];
				self.pokeView6.nickname.text = newpoke.nickname;
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
					self.pokeView6.species.text = [tempname substringToIndex:nameSpot.location];
				}
				break;
			default:
				break;
		}
		pokecount++;
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

