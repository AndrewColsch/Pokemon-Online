//
//  EditMoreVC.m
//  Pokemon Online
//
//  Created by Andrew Colsch on 11/27/12.
//  Copyright (c) 2012 Andrew Colsch. All rights reserved.
//

#import "EditMoreVC.h"

@interface EditMoreVC ()

@end

@implementation EditMoreVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithPokemon:(Pokemon *)poke fromIndex:(int)ind
{
	self.thePokemon = [[Pokemon alloc] initWithPokemon:poke];
	self.theIndex = [[NSNumber alloc] initWithInt:ind];
	
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSpecies:) name:@"updateSpecies" object:nil];
	
	// set up the header cell for the move table
	self.headerCell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 462, 40)];
	UISegmentedControl *topBar = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 462, 40)];
	[topBar addTarget:self action:@selector(changeSort:) forControlEvents:UIControlEventValueChanged];
	[topBar setSegmentedControlStyle:UISegmentedControlStyleBar];
	[topBar insertSegmentWithTitle:@"Type" atIndex:0 animated:NO];
	[topBar setWidth:48.0 forSegmentAtIndex:0];
	[topBar insertSegmentWithTitle:@"Name" atIndex:1 animated:NO];
	[topBar setWidth:120.0 forSegmentAtIndex:1];
	[topBar insertSegmentWithTitle:@"Learn" atIndex:2 animated:NO];
	[topBar setWidth:65.0 forSegmentAtIndex:2];
	[topBar insertSegmentWithTitle:@"PP" atIndex:3 animated:NO];
	[topBar setWidth:42.0 forSegmentAtIndex:3];
	[topBar insertSegmentWithTitle:@"Power" atIndex:4 animated:NO];
	[topBar setWidth:50.0 forSegmentAtIndex:4];
	[topBar insertSegmentWithTitle:@"Accuracy" atIndex:5 animated:NO];
	[topBar setWidth:60.0 forSegmentAtIndex:5];
	[topBar insertSegmentWithTitle:@"Category" atIndex:6 animated:NO];
	[topBar setWidth:70.0 forSegmentAtIndex:6];
	[self.headerCell addSubview:topBar];
	[topBar setSelectedSegmentIndex:1];
	
	// setting up the movelist
	self.moveList = [[NSMutableArray alloc] init];
	NSMutableArray *movenums = [[NSMutableArray alloc] init];
	
	// LEVEL UP MOVES
	NSString *text = [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/level_moves_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	NSRange ranger = [text rangeOfString:[NSString stringWithFormat:@"%d:%d",self.thePokemon.number,self.thePokemon.forme]];
	text = [text substringFromIndex:ranger.location];
	ranger = [text rangeOfString:@" "];
	text = [text substringFromIndex:ranger.location+1];
	ranger = [text rangeOfString:@"\n"];
	text = [text substringToIndex:ranger.location];
	
	ranger = [text rangeOfString:@" "];
	while (ranger.location!=NSNotFound) {
		NSNumber *newnum = [[NSNumber alloc] initWithInt:[[text substringToIndex:ranger.location] intValue]];
		[movenums addObject:newnum];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@" "];
	}
	NSNumber *newnum = [[NSNumber alloc] initWithInt:[[text substringToIndex:text.length] intValue]];
	[movenums addObject:newnum];
	
	for (int x=0; x<movenums.count; x++) {
		Move *newmove = [Move MoveFromNumber:[[movenums objectAtIndex:x] intValue]];
		newmove.learned = @"Level Up";
		[self.moveList addObject:newmove];
	}
	
	// TM/HM MOVES
	text = [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/tm_and_hm_moves_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [text rangeOfString:[NSString stringWithFormat:@"%d:%d",self.thePokemon.number,self.thePokemon.forme]];
	text = [text substringFromIndex:ranger.location];
	ranger = [text rangeOfString:@" "];
	text = [text substringFromIndex:ranger.location+1];
	ranger = [text rangeOfString:@"\n"];
	text = [text substringToIndex:ranger.location];
	
	ranger = [text rangeOfString:@" "];
	while (ranger.location!=NSNotFound) {
		NSNumber *newnum = [[NSNumber alloc] initWithInt:[[text substringToIndex:ranger.location] intValue]];
		[movenums addObject:newnum];
		text = [text substringFromIndex:ranger.location+1];
		ranger = [text rangeOfString:@" "];
	}
	newnum = [[NSNumber alloc] initWithInt:[[text substringToIndex:text.length] intValue]];
	[movenums addObject:newnum];
	
	for (int x=0; x<movenums.count; x++) {
		Move *newmove = [Move MoveFromNumber:[[movenums objectAtIndex:x] intValue]];
		newmove.learned = @"TM/HM";
		[self.moveList addObject:newmove];
	}
	
	[self setupInterface];
}

- (IBAction)cycleIVs:(id)sender // for cycling between HP, ATK, etc.
{
	self.currentIV++;
	if (self.currentIV>5) {
		self.currentIV = 0;
	}
	
	switch (self.currentIV) {
		case 0:
			[self.IVButton setTitle:[NSString stringWithFormat:@"HP: %d",self.thePokemon.dv1] forState:UIControlStateNormal];
			[self.IVStepper setValue:self.thePokemon.dv1];
			break;
		case 1:
			[self.IVButton setTitle:[NSString stringWithFormat:@"ATK: %d",self.thePokemon.dv2] forState:UIControlStateNormal];
			[self.IVStepper setValue:self.thePokemon.dv2];
			break;
		case 2:
			[self.IVButton setTitle:[NSString stringWithFormat:@"DEF: %d",self.thePokemon.dv3] forState:UIControlStateNormal];
			[self.IVStepper setValue:self.thePokemon.dv3];
			break;
		case 3:
			[self.IVButton setTitle:[NSString stringWithFormat:@"SPA: %d",self.thePokemon.dv4] forState:UIControlStateNormal];
			[self.IVStepper setValue:self.thePokemon.dv4];
			break;
		case 4:
			[self.IVButton setTitle:[NSString stringWithFormat:@"SPD: %d",self.thePokemon.dv5] forState:UIControlStateNormal];
			[self.IVStepper setValue:self.thePokemon.dv5];
			break;
		case 5:
			[self.IVButton setTitle:[NSString stringWithFormat:@"SPE: %d",self.thePokemon.dv6] forState:UIControlStateNormal];
			[self.IVStepper setValue:self.thePokemon.dv6];
			break;
		default:
			break;
	}
}

- (IBAction)changeIV:(id)sender // for changing the value of the currently displayed IV
{
	switch (self.currentIV) {
		case 0:
			self.thePokemon.dv1 = (int)self.IVStepper.value;
			[self.IVButton setTitle:[NSString stringWithFormat:@"HP: %d",self.thePokemon.dv1] forState:UIControlStateNormal];
			break;
		case 1:
			self.thePokemon.dv2 = (int)self.IVStepper.value;
			[self.IVButton setTitle:[NSString stringWithFormat:@"ATK: %d",self.thePokemon.dv2] forState:UIControlStateNormal];
			break;
		case 2:
			self.thePokemon.dv3 = (int)self.IVStepper.value;
			[self.IVButton setTitle:[NSString stringWithFormat:@"DEF: %d",self.thePokemon.dv3] forState:UIControlStateNormal];
			break;
		case 3:
			self.thePokemon.dv4 = (int)self.IVStepper.value;
			[self.IVButton setTitle:[NSString stringWithFormat:@"SPA: %d",self.thePokemon.dv4] forState:UIControlStateNormal];
			break;
		case 4:
			self.thePokemon.dv5 = (int)self.IVStepper.value;
			[self.IVButton setTitle:[NSString stringWithFormat:@"SPD: %d",self.thePokemon.dv5] forState:UIControlStateNormal];
			break;
		case 5:
			self.thePokemon.dv6 = (int)self.IVStepper.value;
			[self.IVButton setTitle:[NSString stringWithFormat:@"SPE: %d",self.thePokemon.dv6] forState:UIControlStateNormal];
			break;
		default:
			break;
	}
}

- (IBAction)cycleAbilities:(id)sender
{
	if ([self.abilityButton.titleLabel.text isEqualToString:self.ability1]) {
		if (![self.ability2 isEqualToString:@"NONE"]) {
			[self.abilityButton setTitle:self.ability2 forState:UIControlStateNormal];
			[self.abilityDesc setText:self.abdesc2];
			self.thePokemon.ability = self.ab2;
		} else if (![self.ability3 isEqualToString:@"NONE"]) {
			[self.abilityButton setTitle:self.ability3 forState:UIControlStateNormal];
			[self.abilityDesc setText:self.abdesc3];
			self.thePokemon.ability = self.ab3;
		}
	} else if ([self.abilityButton.titleLabel.text isEqualToString:self.ability2]) {
		if (![self.ability3 isEqualToString:@"NONE"]) {
			[self.abilityButton setTitle:self.ability3 forState:UIControlStateNormal];
			[self.abilityDesc setText:self.abdesc3];
			self.thePokemon.ability = self.ab3;
		} else if (![self.ability1 isEqualToString:@"NONE"]) {
			[self.abilityButton setTitle:self.ability1 forState:UIControlStateNormal];
			[self.abilityDesc setText:self.abdesc1];
			self.thePokemon.ability = self.ab1;
		}
	} else if ([self.abilityButton.titleLabel.text isEqualToString:self.ability3]) {
		if (![self.ability1 isEqualToString:@"NONE"]) {
			[self.abilityButton setTitle:self.ability1 forState:UIControlStateNormal];
			[self.abilityDesc setText:self.abdesc1];
			self.thePokemon.ability = self.ab1;
		} else if (![self.ability2 isEqualToString:@"NONE"]) {
			[self.abilityButton setTitle:self.ability2 forState:UIControlStateNormal];
			[self.abilityDesc setText:self.abdesc2];
			self.thePokemon.ability = self.ab2;
		}
	}
}

- (IBAction)goBack:(id)sender
{
	Pokemon *passPoke = self.thePokemon;
	NSNumber *passInd = self.theIndex;
	[self dismissViewControllerAnimated:YES completion:^{
		[[NSNotificationCenter defaultCenter] postNotificationName:@"swapToPoke" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:passPoke,@"poketopass",passInd,@"indtopass",nil]];}];
}

- (IBAction)editSpecies:(UITapGestureRecognizer *)sender
{
	if (sender.state==UIGestureRecognizerStateEnded) {
		PokePickView *ppv = [[PokePickView alloc] initWithPokemon:self.thePokemon];
		[self presentViewController:ppv animated:YES completion:nil];
	}
}

- (void)updateSpecies:(NSNotification *)notis
{
	NSDictionary *dict = notis.userInfo;
	self.thePokemon = [[Pokemon alloc] init];
	self.thePokemon.item = [[dict objectForKey:@"item"] intValue];
	self.thePokemon.number = [[dict objectForKey:@"number"] intValue];
	self.thePokemon.shiny = 0;
	self.thePokemon.nickname = self.thePokemon.species;
	self.thePokemon.species = [dict objectForKey:@"name"];
	self.thePokemon.generation = mydelegate.activeGen;
	self.thePokemon.forme = [[dict objectForKey:@"subnumber"] intValue];
	self.thePokemon.happiness = [[dict objectForKey:@"happy"] intValue];
	self.thePokemon.level = [[dict objectForKey:@"level"] intValue];
	self.thePokemon.gender = [[dict objectForKey:@"gender"] intValue];
	self.thePokemon.subgeneration = mydelegate.activeSubgen;
	
	NSString *nListFile = [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/type1_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	NSRange ranger = [nListFile rangeOfString:[NSString stringWithFormat:@"%d:%d",self.thePokemon.number,self.thePokemon.forme]];
	nListFile = [nListFile substringFromIndex:ranger.location];
	ranger = [nListFile rangeOfString:@" "];
	nListFile = [nListFile substringFromIndex:ranger.location+1];
	ranger = [nListFile rangeOfString:@"\n"];
	nListFile = [nListFile substringToIndex:ranger.location];
	self.thePokemon.type1 = [nListFile intValue];
	
	nListFile = [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/type2_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	ranger = [nListFile rangeOfString:[NSString stringWithFormat:@"%d:%d",self.thePokemon.number,self.thePokemon.forme]];
	nListFile = [nListFile substringFromIndex:ranger.location];
	ranger = [nListFile rangeOfString:@" "];
	nListFile = [nListFile substringFromIndex:ranger.location+1];
	ranger = [nListFile rangeOfString:@"\n"];
	nListFile = [nListFile substringToIndex:ranger.location];
	self.thePokemon.type2 = [nListFile intValue];
	
	[self setupInterface];
	[self.moveTable reloadData];
}

- (IBAction)editMove:(id)sender
{
	if (self.moveTable.hidden) {
		[self.moveTable setHidden:NO];
	} else {
		[self.moveTable setHidden:YES];
	}
}

- (IBAction)cancel:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)save:(id)sender
{
	Pokemon *passPoke = self.thePokemon;
	NSNumber *passInd = self.theIndex;
	[self dismissViewControllerAnimated:YES completion:^{
		[[NSNotificationCenter defaultCenter] postNotificationName:@"updatePoke" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:passPoke,@"poketopass",passInd,@"indtopass",nil]];}];
}

- (void)setupInterface
{
	[self.pokeImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/%d.png",mydelegate.basePath,self.thePokemon.number]]];
	if (self.thePokemon.shiny) {
		[self.pokeImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/shiny/%d.png",mydelegate.basePath,self.thePokemon.number]]];
	}
	if (self.thePokemon.item>=8000) {
		// Berries are given their own set of item numbers starting at 8000, but the images for them still start at 1.png
		[self.itemImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Berries/%d.png",mydelegate.basePath,(self.thePokemon.item-7999)]]];
		NSString *iListFile = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/berries.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
		NSRange itemSpot = [iListFile rangeOfString:[NSString stringWithFormat:@"%d",self.thePokemon.item-8000]];
		NSString *tempitem = [iListFile substringFromIndex:itemSpot.location];
		itemSpot = [tempitem rangeOfString:@" "];
		tempitem = [tempitem substringFromIndex:itemSpot.location+1];
		itemSpot = [tempitem rangeOfString:@"\n"];
	} else {
		[self.itemImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Items/%d.png",mydelegate.basePath,self.thePokemon.item]]];
		NSString *iListFile = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/items.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
		NSRange itemSpot = [iListFile rangeOfString:[NSString stringWithFormat:@"%d",self.thePokemon.item]];
		NSString *tempitem = [iListFile substringFromIndex:itemSpot.location];
		itemSpot = [tempitem rangeOfString:@" "];
		tempitem = [tempitem substringFromIndex:itemSpot.location+1];
		itemSpot = [tempitem rangeOfString:@"\n"];
	}
	
	self.currentIV = 0;
	[self.IVButton setTitle:[NSString stringWithFormat:@"HP: %d",self.thePokemon.dv1] forState:UIControlStateNormal];
	[self.IVStepper setValue:self.thePokemon.dv1];
	
	// find the poke's abilities
	NSString *abil1str = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/ability1_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	NSString *abil2str = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/ability2_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	NSString *abil3str = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/ability3_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	NSString *abilNames = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/abilities.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	NSString *abilDescs = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/ability_desc.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	
	NSString *tempabil;
	NSRange idspot = [abil1str rangeOfString:[NSString stringWithFormat:@"%d:",self.thePokemon.number]];
	
	abil1str = [abil1str substringFromIndex:idspot.location];
	idspot = [abil1str rangeOfString:@" "];
	abil1str = [abil1str substringFromIndex:idspot.location+1];
	idspot = [abil1str rangeOfString:@"\n"];
	abil1str = [abil1str substringToIndex:idspot.location];
	self.ab1 = [abil1str intValue];
	
	idspot = [abil2str rangeOfString:[NSString stringWithFormat:@"%d:",self.thePokemon.number]];
	abil2str = [abil2str substringFromIndex:idspot.location];
	idspot = [abil2str rangeOfString:@" "];
	abil2str = [abil2str substringFromIndex:idspot.location+1];
	idspot = [abil2str rangeOfString:@"\n"];
	abil2str = [abil2str substringToIndex:idspot.location];
	self.ab2 = [abil2str intValue];
	
	idspot = [abil3str rangeOfString:[NSString stringWithFormat:@"%d:",self.thePokemon.number]];
	abil3str = [abil3str substringFromIndex:idspot.location];
	idspot = [abil3str rangeOfString:@" "];
	abil3str = [abil3str substringFromIndex:idspot.location+1];
	idspot = [abil3str rangeOfString:@"\n"];
	abil3str = [abil3str substringToIndex:idspot.location];
	self.ab3 = [abil3str intValue];
	
	if (self.ab1==0) {
		self.ability1 = @"NONE";
		self.abdesc1 = @"This Pokemon does not have any abilities.";
	} else {
		idspot = [abilNames rangeOfString:[NSString stringWithFormat:@"%d ",self.ab1]];
		tempabil = [abilNames substringFromIndex:idspot.location+1];
		idspot = [tempabil rangeOfString:@" "];
		tempabil = [tempabil substringFromIndex:idspot.location+1];
		idspot = [tempabil rangeOfString:@"\n"];
		tempabil = [tempabil substringToIndex:idspot.location];
		self.ability1 = tempabil;
		idspot = [abilDescs rangeOfString:[NSString stringWithFormat:@"%d ",self.ab1]];
		tempabil = [abilDescs substringFromIndex:idspot.location+1];
		idspot = [tempabil rangeOfString:@" "];
		tempabil = [tempabil substringFromIndex:idspot.location+1];
		idspot = [tempabil rangeOfString:@"\n"];
		tempabil = [tempabil substringToIndex:idspot.location];
		self.abdesc1 = tempabil;
	}
	if (self.ab2==0) {
		self.ability2 = @"NONE";
		self.abdesc2 = @"This Pokemon does not have a second ability.";
	} else {
		idspot = [abilNames rangeOfString:[NSString stringWithFormat:@"%d ",self.ab2]];
		tempabil = [abilNames substringFromIndex:idspot.location+1];
		idspot = [tempabil rangeOfString:@" "];
		tempabil = [tempabil substringFromIndex:idspot.location+1];
		idspot = [tempabil rangeOfString:@"\n"];
		tempabil = [tempabil substringToIndex:idspot.location];
		self.ability2 = tempabil;
		idspot = [abilDescs rangeOfString:[NSString stringWithFormat:@"%d ",self.ab2]];
		tempabil = [abilDescs substringFromIndex:idspot.location+1];
		idspot = [tempabil rangeOfString:@" "];
		tempabil = [tempabil substringFromIndex:idspot.location+1];
		idspot = [tempabil rangeOfString:@"\n"];
		tempabil = [tempabil substringToIndex:idspot.location];
		self.abdesc2 = tempabil;
	}
	if (self.ab3==0) {
		self.ability3 = @"NONE";
		self.abdesc3 = @"This Pokemon does not have a third ability.";
	} else {
		idspot = [abilNames rangeOfString:[NSString stringWithFormat:@"%d ",self.ab3]];
		tempabil = [abilNames substringFromIndex:idspot.location+1];
		idspot = [tempabil rangeOfString:@" "];
		tempabil = [tempabil substringFromIndex:idspot.location+1];
		idspot = [tempabil rangeOfString:@"\n"];
		tempabil = [tempabil substringToIndex:idspot.location];
		self.ability3 = tempabil;
		idspot = [abilDescs rangeOfString:[NSString stringWithFormat:@"%d ",self.ab3]];
		tempabil = [abilDescs substringFromIndex:idspot.location+1];
		idspot = [tempabil rangeOfString:@" "];
		tempabil = [tempabil substringFromIndex:idspot.location+1];
		idspot = [tempabil rangeOfString:@"\n"];
		tempabil = [tempabil substringToIndex:idspot.location];
		self.abdesc3 = tempabil;
	}
	
	if (self.thePokemon.ability==(-1)) {
		// Is a default Pokemon, need to set ability to first on the list.
		self.thePokemon.ability=self.ab1;
	}
	
	if (self.thePokemon.ability==self.ab1) {
		[self.abilityButton setTitle:self.ability1 forState:UIControlStateNormal];
		[self.abilityDesc setText:self.abdesc1];
	} else if (self.thePokemon.ability==self.ab2) {
		[self.abilityButton setTitle:self.ability2 forState:UIControlStateNormal];
		[self.abilityDesc setText:self.abdesc2];
	} else if (self.thePokemon.ability==self.ab3) {
		[self.abilityButton setTitle:self.ability3 forState:UIControlStateNormal];
		[self.abilityDesc setText:self.abdesc3];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableView Methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row==0) {
		return self.headerCell;
	}
	
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	Move *m = [self.moveList objectAtIndex:indexPath.row-1]; // have to go back one, 0 is title row
	
	UIImageView *typeImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 12, 48, 18)];
	[typeImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/type%d.png",mydelegate.basePath,m.type]]];
	[cell addSubview:typeImage];
	
	UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 120, 40)];
	nameLabel.text = m.name;
	[nameLabel setAdjustsFontSizeToFitWidth:YES];
	[cell addSubview:nameLabel];
	
	UILabel *learnLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 0, 65, 40)];
	learnLabel.text = m.learned;
	[learnLabel setAdjustsFontSizeToFitWidth:YES];
	[cell addSubview:learnLabel];
	
	UILabel *ppLabel = [[UILabel alloc] initWithFrame:CGRectMake(242, 0, 42, 40)];
	ppLabel.text = [NSString stringWithFormat:@"%d",m.pp];
	[ppLabel setAdjustsFontSizeToFitWidth:YES];
	[cell addSubview:ppLabel];
	
	UILabel *powLabel = [[UILabel alloc] initWithFrame:CGRectMake(284, 0, 50, 40)];
	if (m.power%10!=0||m.power==0) {
		powLabel.text = @"--";
	}
	else {
		powLabel.text = [NSString stringWithFormat:@"%d",m.power];
	}
	[powLabel setAdjustsFontSizeToFitWidth:YES];
	[cell addSubview:powLabel];
	
	UILabel *accLabel = [[UILabel alloc] initWithFrame:CGRectMake(334, 0, 60, 40)];
	if (m.accuracy==101) {
		accLabel.text = @"--";
	}
	else {
		accLabel.text = [NSString stringWithFormat:@"%d",m.accuracy];
	}
	[accLabel setAdjustsFontSizeToFitWidth:YES];
	[cell addSubview:accLabel];
	
	UIImageView *catImage = [[UIImageView alloc] initWithFrame:CGRectMake(400, 12, 48, 18)];
	if (m.category==0) {
		[catImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/cat_physical.gif",mydelegate.basePath]]];
	}
	else if (m.category==1) {
		[catImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/cat_special.gif",mydelegate.basePath]]];
	}
	else {
		[catImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/cat_status.gif",mydelegate.basePath]]];
	}
	[cell addSubview:catImage];
	
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.moveList.count+1;
}

#pragma mark Table Header Actions
- (void)changeSort:(UISegmentedControl *)sender
{
	if (sender.selectedSegmentIndex==0) {
		UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Sorting" message:@"by Type." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
		[al show];
	}
	else if (sender.selectedSegmentIndex==1) {
		[self sortByName];
	}
	else if (sender.selectedSegmentIndex==3) {
		[self sortByPP];
	}
	else if (sender.selectedSegmentIndex==4) {
		[self sortByPower];
	}
	else if (sender.selectedSegmentIndex==5) {
		[self sortByAccuracy];
	}
}

- (void)sortByType
{
	
}

- (void)sortByName
{
	for (int x=0; x<self.moveList.count; x++) {
		for (int y=x+1; y<self.moveList.count; y++) {
			Move *m1 = [self.moveList objectAtIndex:x];
			Move *m2 = [self.moveList objectAtIndex:y];
			if ([m1.name caseInsensitiveCompare:m2.name]==NSOrderedDescending) {
				[self.moveList replaceObjectAtIndex:x withObject:m2];
				[self.moveList replaceObjectAtIndex:y withObject:m1];
			}
		}
	}
	
	[self.moveTable reloadData];
}

- (void)sortByPP
{
	for (int x=0; x<self.moveList.count; x++) {
		for (int y=x+1; y<self.moveList.count; y++) {
			Move *m1 = [self.moveList objectAtIndex:x];
			Move *m2 = [self.moveList objectAtIndex:y];
			if (m1.pp<m2.pp) {
				[self.moveList replaceObjectAtIndex:x withObject:m2];
				[self.moveList replaceObjectAtIndex:y withObject:m1];
			}
		}
	}
	
	[self.moveTable reloadData];
}

- (void)sortByPower
{
	for (int x=0; x<self.moveList.count; x++) {
		for (int y=x+1; y<self.moveList.count; y++) {
			Move *m1 = [self.moveList objectAtIndex:x];
			Move *m2 = [self.moveList objectAtIndex:y];
			if (m1.power<m2.power) {
				[self.moveList replaceObjectAtIndex:x withObject:m2];
				[self.moveList replaceObjectAtIndex:y withObject:m1];
			}
		}
	}
	
	[self.moveTable reloadData];
}

- (void)sortByAccuracy
{
	for (int x=0; x<self.moveList.count; x++) {
		for (int y=x+1; y<self.moveList.count; y++) {
			Move *m1 = [self.moveList objectAtIndex:x];
			Move *m2 = [self.moveList objectAtIndex:y];
			if (m1.accuracy<m2.accuracy) {
				[self.moveList replaceObjectAtIndex:x withObject:m2];
				[self.moveList replaceObjectAtIndex:y withObject:m1];
			}
		}
	}
	
	[self.moveTable reloadData];
}

@end
