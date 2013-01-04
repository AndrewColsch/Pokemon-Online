//
//  EditPokeVC.m
//  Pokemon Online
//
//  Created by Andrew Colsch on 11/16/12.
//  Copyright (c) 2012 Andrew Colsch. All rights reserved.
//

#import "EditPokeVC.h"

@interface EditPokeVC ()

@end

@implementation EditPokeVC

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
	[self setupInterface];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	if ([pickerView isEqual:self.natureList]) {
		// change nature
		self.thePokemon.nature = row;
		NSString *nListFile = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/nature.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
		NSRange natureSpot = [nListFile rangeOfString:[NSString stringWithFormat:@"%d",self.thePokemon.nature]];
		NSString *tempnature = [nListFile substringFromIndex:natureSpot.location];
		natureSpot = [tempnature rangeOfString:@" "];
		tempnature = [tempnature substringFromIndex:natureSpot.location+1];
		natureSpot = [tempnature rangeOfString:@"\n"];
		[self.natureButton setTitle:[tempnature substringToIndex:natureSpot.location] forState:UIControlStateNormal];
	}
	else if ([pickerView isEqual:self.itemList]) {
		if (row>=305) {
			// it's a berry
			self.thePokemon.item = row-305+8000;
			[self.itemImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Berries/%d.png",mydelegate.basePath,(self.thePokemon.item-7999)]]];
			NSString *iListFile = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/berries.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
			NSRange itemSpot = [iListFile rangeOfString:[NSString stringWithFormat:@"%d",self.thePokemon.item-8000]];
			NSString *tempitem = [iListFile substringFromIndex:itemSpot.location];
			itemSpot = [tempitem rangeOfString:@" "];
			tempitem = [tempitem substringFromIndex:itemSpot.location+1];
			itemSpot = [tempitem rangeOfString:@"\n"];
			[self.itemButton setTitle:[tempitem substringToIndex:itemSpot.location] forState:UIControlStateNormal];
		} else {
			// it's an item
			int ind = [[mydelegate.itemAlphaNum objectAtIndex:row] intValue];
			self.thePokemon.item = ind;
			[self.itemImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Items/%d.png",mydelegate.basePath,self.thePokemon.item]]];
			NSString *iListFile = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/items.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
			NSRange itemSpot = [iListFile rangeOfString:[NSString stringWithFormat:@"%d",self.thePokemon.item]];
			NSString *tempitem = [iListFile substringFromIndex:itemSpot.location];
			itemSpot = [tempitem rangeOfString:@" "];
			tempitem = [tempitem substringFromIndex:itemSpot.location+1];
			itemSpot = [tempitem rangeOfString:@"\n"];
			[self.itemButton setTitle:[tempitem substringToIndex:itemSpot.location] forState:UIControlStateNormal];
		}
	}
	pickerView.hidden = YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([pickerView isEqual:self.natureList]) {
		return 25;
	} else {
		return 368;
	}
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	NSString *title;
	if ([pickerView isEqual:self.natureList]) {
		NSString *iListFile = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/nature.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
		NSRange natureSpot = [iListFile rangeOfString:[NSString stringWithFormat:@"%d",row]];
		NSString *tempnature = [iListFile substringFromIndex:natureSpot.location];
		natureSpot = [tempnature rangeOfString:@" "];
		tempnature = [tempnature substringFromIndex:natureSpot.location+1];
		natureSpot = [tempnature rangeOfString:@"\n"];
		title = [tempnature substringToIndex:natureSpot.location];
	} else {
		if (row>=305) {
			NSString *iListFile = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/berries.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
			NSRange itemSpot = [iListFile rangeOfString:[NSString stringWithFormat:@"%d",row-305]];
			NSString *tempitem = [iListFile substringFromIndex:itemSpot.location];
			itemSpot = [tempitem rangeOfString:@" "];
			tempitem = [tempitem substringFromIndex:itemSpot.location+1];
			itemSpot = [tempitem rangeOfString:@"\n"];
			title = [tempitem substringToIndex:itemSpot.location];
		} else {
			int ind = [[mydelegate.itemAlphaNum objectAtIndex:row] intValue];
			NSString *iListFile = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/items.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
			NSRange itemSpot = [iListFile rangeOfString:[NSString stringWithFormat:@"%d",ind]];
			NSString *tempitem = [iListFile substringFromIndex:itemSpot.location];
			itemSpot = [tempitem rangeOfString:@" "];
			tempitem = [tempitem substringFromIndex:itemSpot.location+1];
			itemSpot = [tempitem rangeOfString:@"\n"];
			title = [tempitem substringToIndex:itemSpot.location];
		}
	}
	
    return title;
}

- (IBAction)pickNature:(id)sender
{
	self.natureList.hidden = NO;
}

- (IBAction)pickItem:(id)sender
{
	self.itemList.hidden = NO;
}

- (IBAction)stepHappy:(UIStepper *)sender
{
	self.thePokemon.happiness = self.happyStep.value;
	self.happyField.text = [NSString stringWithFormat:@"%d",self.thePokemon.happiness];
}

- (IBAction)stepLevel:(UIStepper *)sender
{
	self.thePokemon.level = self.levelStep.value;
	self.levelField.text = [NSString stringWithFormat:@"%d",self.thePokemon.level];
}

- (IBAction)flipShiny:(id)sender
{
	if (self.shinySwitch.on) {
		self.thePokemon.shiny = 1;
		[self.pokeImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/shiny/%d.png",mydelegate.basePath,self.thePokemon.number]]];
	} else {
		self.thePokemon.shiny = 0;
		[self.pokeImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/%d.png",mydelegate.basePath,self.thePokemon.number]]];
	}
}

- (IBAction)flipGender:(id)sender
{
	if (self.genderSwitch.selectedSegmentIndex==0) {
		self.thePokemon.gender = 1;
	} else {
		self.thePokemon.gender = 2;
	}
}

- (IBAction)slideStat:(UISlider *)sender
{
	[sender setValue:((int)((sender.value + 2) / 4) * 4) animated:NO];
	float tot = self.slideAtk.value + self.slideDef.value + self.slideHP.value + self.slideSpA.value + self.slideSpD.value + self.slideSpe.value;
	[self.slideTotal setValue:tot];
	
	[self.textAtk setText:[NSString stringWithFormat:@"%d",(int)self.slideAtk.value]];
	[self.textDef setText:[NSString stringWithFormat:@"%d",(int)self.slideDef.value]];
	[self.textHP setText:[NSString stringWithFormat:@"%d",(int)self.slideHP.value]];
	[self.textSpA setText:[NSString stringWithFormat:@"%d",(int)self.slideSpA.value]];
	[self.textSpD setText:[NSString stringWithFormat:@"%d",(int)self.slideSpD.value]];
	[self.textSpe setText:[NSString stringWithFormat:@"%d",(int)self.slideSpe.value]];
	[self.textTotal setText:[NSString stringWithFormat:@"%d",(int)self.slideTotal.value]];
}

- (IBAction)endSlide:(UISlider *)sender
{
	float tot = self.slideAtk.value + self.slideDef.value + self.slideHP.value + self.slideSpA.value + self.slideSpD.value + self.slideSpe.value;
	if (tot>508) {
		int diff = tot - 508;
		[sender setValue:((int)sender.value - diff)];
		[self.slideTotal setValue:508];
		
		[self.textAtk setText:[NSString stringWithFormat:@"%d",(int)self.slideAtk.value]];
		[self.textDef setText:[NSString stringWithFormat:@"%d",(int)self.slideDef.value]];
		[self.textHP setText:[NSString stringWithFormat:@"%d",(int)self.slideHP.value]];
		[self.textSpA setText:[NSString stringWithFormat:@"%d",(int)self.slideSpA.value]];
		[self.textSpD setText:[NSString stringWithFormat:@"%d",(int)self.slideSpD.value]];
		[self.textSpe setText:[NSString stringWithFormat:@"%d",(int)self.slideSpe.value]];
		[self.textTotal setText:[NSString stringWithFormat:@"%d",(int)self.slideTotal.value]];
	}
	
	self.thePokemon.ev1 = (int)self.slideHP;
	self.thePokemon.ev2 = (int)self.slideAtk;
	self.thePokemon.ev3 = (int)self.slideDef;
	self.thePokemon.ev4 = (int)self.slideSpA;
	self.thePokemon.ev5 = (int)self.slideSpD;
	self.thePokemon.ev6 = (int)self.slideSpe;
}

- (IBAction)editMore:(id)sender
{
	Pokemon *passPoke = self.thePokemon;
	NSNumber *passInd = self.theIndex;
	[self dismissViewControllerAnimated:YES completion:^{
	[[NSNotificationCenter defaultCenter] postNotificationName:@"swapToMore" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:passPoke,@"poketopass",passInd,@"indtopass",nil]];}];
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

- (void)updateSpecies:(NSNotification *)notis
{
	NSDictionary *dict = notis.userInfo;
	self.thePokemon = [[Pokemon alloc] init];
	self.thePokemon.item = [[dict objectForKey:@"item"] intValue];
	self.thePokemon.number = [[dict objectForKey:@"number"] intValue];
	self.thePokemon.shiny = 0;
	self.thePokemon.nickname = [dict objectForKey:@"name"];
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
}

- (void)setupInterface
{
	[self.pokeImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/%d.png",mydelegate.basePath,self.thePokemon.number]]];
	if (self.thePokemon.shiny) {
		[self.pokeImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/shiny/%d.png",mydelegate.basePath,self.thePokemon.number]]];
	}
	
	NSString *nListFile = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/nature.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	NSRange natureSpot = [nListFile rangeOfString:[NSString stringWithFormat:@"%d",self.thePokemon.nature]];
	NSString *tempnature = [nListFile substringFromIndex:natureSpot.location];
	natureSpot = [tempnature rangeOfString:@" "];
	tempnature = [tempnature substringFromIndex:natureSpot.location+1];
	natureSpot = [tempnature rangeOfString:@"\n"];
	[self.natureButton setTitle:[tempnature substringToIndex:natureSpot.location] forState:UIControlStateNormal];
	
	if (self.thePokemon.item>=8000) {
		// Berries are given their own set of item numbers starting at 8000, but the images for them still start at 1.png
		[self.itemImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Berries/%d.png",mydelegate.basePath,(self.thePokemon.item-7999)]]];
		NSString *iListFile = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/berries.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
		NSRange itemSpot = [iListFile rangeOfString:[NSString stringWithFormat:@"%d",self.thePokemon.item-8000]];
		NSString *tempitem = [iListFile substringFromIndex:itemSpot.location];
		itemSpot = [tempitem rangeOfString:@" "];
		tempitem = [tempitem substringFromIndex:itemSpot.location+1];
		itemSpot = [tempitem rangeOfString:@"\n"];
		[self.itemButton setTitle:[tempitem substringToIndex:itemSpot.location] forState:UIControlStateNormal];
	} else {
		[self.itemImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/Items/%d.png",mydelegate.basePath,self.thePokemon.item]]];
		NSString *iListFile = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/items.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
		NSRange itemSpot = [iListFile rangeOfString:[NSString stringWithFormat:@"%d",self.thePokemon.item]];
		NSString *tempitem = [iListFile substringFromIndex:itemSpot.location];
		itemSpot = [tempitem rangeOfString:@" "];
		tempitem = [tempitem substringFromIndex:itemSpot.location+1];
		itemSpot = [tempitem rangeOfString:@"\n"];
		[self.itemButton setTitle:[tempitem substringToIndex:itemSpot.location] forState:UIControlStateNormal];
	}
	self.nameLabel.text = self.thePokemon.species;
	self.nicknameField.text = self.thePokemon.nickname;
	[self.type1img setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/type%d.png",mydelegate.basePath,self.thePokemon.type1]]];
	if (self.thePokemon.type2==17) {
		[self.type2img setImage:nil];
	} else {
		[self.type2img setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/type%d.png",mydelegate.basePath,self.thePokemon.type2]]];
	}
	switch (self.thePokemon.gender) {
		case 0:
			[self.genderSwitch setHidden:YES];
			break;
		case 1:
			[self.genderSwitch setHidden:NO];
			[self.genderSwitch setSelectedSegmentIndex:0];
			break;
		case 2:
			[self.genderSwitch setHidden:NO];
			[self.genderSwitch setSelectedSegmentIndex:1];
			break;
		default:
			break;
	}
	
	self.happyField.text = [NSString stringWithFormat:@"%d",self.thePokemon.happiness];
	self.happyStep.value = self.thePokemon.happiness;
	self.levelField.text = [NSString stringWithFormat:@"%d",self.thePokemon.level];
	self.levelStep.value = self.thePokemon.level;
	[self.shinySwitch setOn:self.thePokemon.shiny];
	
	// note: ideally the picker would be 300px high, but pickers have a set frame height.
	self.natureList = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 84, 480, 216)];
	self.natureList.delegate = self;
	self.natureList.showsSelectionIndicator = YES;
	[self.view addSubview:self.natureList];
	self.itemList = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 84, 480, 216)];
	self.itemList.delegate = self;
	self.itemList.showsSelectionIndicator = YES;
	[self.view addSubview:self.itemList];
	self.natureList.hidden = YES;
	self.itemList.hidden = YES;
	
	// set up the EVs
	self.slideHP.value = self.thePokemon.ev1;
	self.slideAtk.value = self.thePokemon.ev2;
	self.slideDef.value = self.thePokemon.ev3;
	self.slideSpA.value = self.thePokemon.ev4;
	self.slideSpD.value = self.thePokemon.ev5;
	self.slideSpe.value = self.thePokemon.ev6;
	float tot = self.slideAtk.value + self.slideDef.value + self.slideHP.value + self.slideSpA.value + self.slideSpD.value + self.slideSpe.value;
	[self.slideTotal setValue:tot];
	[self.textAtk setText:[NSString stringWithFormat:@"%d",(int)self.slideAtk.value]];
	[self.textDef setText:[NSString stringWithFormat:@"%d",(int)self.slideDef.value]];
	[self.textHP setText:[NSString stringWithFormat:@"%d",(int)self.slideHP.value]];
	[self.textSpA setText:[NSString stringWithFormat:@"%d",(int)self.slideSpA.value]];
	[self.textSpD setText:[NSString stringWithFormat:@"%d",(int)self.slideSpD.value]];
	[self.textSpe setText:[NSString stringWithFormat:@"%d",(int)self.slideSpe.value]];
	[self.textTotal setText:[NSString stringWithFormat:@"%d",(int)self.slideTotal.value]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if ([textField isEqual:self.nicknameField]) {
		self.thePokemon.nickname = self.nicknameField.text;
		[textField resignFirstResponder];
	}
	return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
