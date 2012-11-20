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

- (id)initWithPokemon:(Pokemon *)poke
{
	self.thePokemon = poke;
	
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	[self.pokeImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/black-white/%d.png",mydelegate.basePath,self.thePokemon.number]]];
	if (self.thePokemon.shiny) {
		[self.pokeImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/black-white/shiny/%d.png",mydelegate.basePath,self.thePokemon.number]]];
	}
	
	NSString *nListFile = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/nature.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	NSRange natureSpot = [nListFile rangeOfString:[NSString stringWithFormat:@"%d",self.thePokemon.nature]];
	NSString *tempnature = [nListFile substringFromIndex:natureSpot.location];
	natureSpot = [tempnature rangeOfString:@" "];
	tempnature = [tempnature substringFromIndex:natureSpot.location+1];
	natureSpot = [tempnature rangeOfString:@"\n"];
	self.natureLabel.text = [tempnature substringToIndex:natureSpot.location];
	
	if (self.thePokemon.item>=8000) {
		// Berries are given their own set of item numbers starting at 8000, but the images for them still start at 1.png
		[self.itemImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Berries/%d.png",mydelegate.basePath,(self.thePokemon.item-7999)]]];
		NSString *iListFile = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/berries.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
		NSRange itemSpot = [iListFile rangeOfString:[NSString stringWithFormat:@"%d",self.thePokemon.item-8000]];
		NSString *tempitem = [iListFile substringFromIndex:itemSpot.location];
		itemSpot = [tempitem rangeOfString:@" "];
		tempitem = [tempitem substringFromIndex:itemSpot.location+1];
		itemSpot = [tempitem rangeOfString:@"\n"];
		self.itemLabel.text = [tempitem substringToIndex:itemSpot.location];
	} else {
		[self.itemImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Items/%d.png",mydelegate.basePath,self.thePokemon.item]]];
		NSString *iListFile = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/items.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
		NSRange itemSpot = [iListFile rangeOfString:[NSString stringWithFormat:@"%d",self.thePokemon.item]];
		NSString *tempitem = [iListFile substringFromIndex:itemSpot.location];
		itemSpot = [tempitem rangeOfString:@" "];
		tempitem = [tempitem substringFromIndex:itemSpot.location+1];
		itemSpot = [tempitem rangeOfString:@"\n"];
		self.itemLabel.text = [tempitem substringToIndex:itemSpot.location];
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
			[self.genderImage setImage:nil];
			break;
		case 1:
			[self.genderImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/gender1.png",mydelegate.basePath]]];
			break;
		case 2:
			[self.genderImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/gender2.png",mydelegate.basePath]]];
			break;
		default:
			break;
	}
	
	self.happyField.text = [NSString stringWithFormat:@"%d",self.thePokemon.happiness];
	self.happyStep.value = self.thePokemon.happiness;
	
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
		self.natureLabel.text = [tempnature substringToIndex:natureSpot.location];
	}
	else if ([pickerView isEqual:self.itemList]) {
		if (row>=305) {
			// it's a berry
			self.thePokemon.item = row-305+8000;
			[self.itemImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Berries/%d.png",mydelegate.basePath,(self.thePokemon.item-7999)]]];
			NSString *iListFile = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/berries.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
			NSRange itemSpot = [iListFile rangeOfString:[NSString stringWithFormat:@"%d",self.thePokemon.item-8000]];
			NSString *tempitem = [iListFile substringFromIndex:itemSpot.location];
			itemSpot = [tempitem rangeOfString:@" "];
			tempitem = [tempitem substringFromIndex:itemSpot.location+1];
			itemSpot = [tempitem rangeOfString:@"\n"];
			self.itemLabel.text = [tempitem substringToIndex:itemSpot.location];
		} else {
			// it's an item
			self.thePokemon.item = row;
			[self.itemImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Items/%d.png",mydelegate.basePath,self.thePokemon.item]]];
			NSString *iListFile = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/items.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
			NSRange itemSpot = [iListFile rangeOfString:[NSString stringWithFormat:@"%d",self.thePokemon.item]];
			NSString *tempitem = [iListFile substringFromIndex:itemSpot.location];
			itemSpot = [tempitem rangeOfString:@" "];
			tempitem = [tempitem substringFromIndex:itemSpot.location+1];
			itemSpot = [tempitem rangeOfString:@"\n"];
			self.itemLabel.text = [tempitem substringToIndex:itemSpot.location];
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
			NSString *iListFile = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/items.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
			NSRange itemSpot = [iListFile rangeOfString:[NSString stringWithFormat:@"%d",row]];
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

- (IBAction)cancel:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:NULL];
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
