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
	else return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 2;
}

@end
