//
//  PokePickView.m
//  Pokemon Online
//
//  Created by Andrew Colsch on 12/7/12.
//  Copyright (c) 2012 Andrew Colsch. All rights reserved.
//

#import "PokePickView.h"

@interface PokePickView ()

@end

@implementation PokePickView

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
	self.thePokemon = [[Pokemon alloc] initWithPokemon:poke];
	
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.speciesList = [self loadList];
	self.useMain = YES;
}

- (NSMutableArray *)loadList
{
	NSMutableArray *speclist = [[NSMutableArray alloc] init];
	NSMutableArray *subspeclist = [[NSMutableArray alloc] init];
	NSString *nListFile = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/released_5g.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	NSRange ranger = [nListFile rangeOfString:@"\n"];
	
	do {
		Species *nextSpec = [[Species alloc] init];
		NSString *line = [nListFile substringToIndex:ranger.location];
		nListFile = [nListFile substringFromIndex:ranger.location+1];
		
		ranger = [line rangeOfString:@":"];
		NSString *temp = [line substringToIndex:ranger.location];
		[nextSpec setNumber:[NSNumber numberWithInt:[temp intValue]]];
		
		line = [line substringFromIndex:ranger.location+1];
		ranger = [line rangeOfString:@" "];
		temp = [line substringToIndex:ranger.location];
		[nextSpec setSubnumber:[NSNumber numberWithInt:[temp intValue]]];
		[nextSpec setName:[line substringFromIndex:ranger.location+1]];
		
		if ([nextSpec.subnumber intValue]==0) {
			[speclist addObject:nextSpec];
		} else {
			[subspeclist addObject:nextSpec];
		}
		
		ranger = [nListFile rangeOfString:@"\n"];
	} while (ranger.location<nListFile.length);
	
	for (int x=0; x<subspeclist.count; x++) {
		Species *nextSub = [subspeclist objectAtIndex:x];
		bool foundit = NO;
		for (int y=0; y<speclist.count && !foundit; y++) {
			Species *nextSpec = [speclist objectAtIndex:y];
			
			if ([nextSub.number intValue]==[nextSpec.number intValue] && [nextSub.subnumber intValue]==[nextSpec.subnumber intValue]+1) {
				[speclist insertObject:nextSub atIndex:y+1];
				foundit = YES;
			}
		}
	}
	
	return speclist;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapImage:(UITapGestureRecognizer *)sender
{
	if (sender.state==UIGestureRecognizerStateEnded) {
		UIAlertView *tapped = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"Keep %@, or cancel and return to %@?",self.theSpecies.name,self.thePokemon.species] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Keep", nil];
		[tapped show];
	}
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	NSString *name = self.theSpecies.name;
	NSNumber *num = self.theSpecies.number;
	NSNumber *subnum = self.theSpecies.subnumber;
	NSNumber *level = [NSNumber numberWithInt:self.thePokemon.level];
	NSNumber *item = [NSNumber numberWithInt:self.thePokemon.item];
	NSNumber *gender = [NSNumber numberWithInt:self.thePokemon.gender];
	NSNumber *happy = [NSNumber numberWithInt:self.thePokemon.happiness];
	
	if (buttonIndex==0) {
		[self dismissViewControllerAnimated:YES completion:nil];
	} else {
		[self dismissViewControllerAnimated:YES completion:^{
			[[NSNotificationCenter defaultCenter] postNotificationName:@"updateSpecies" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:name,@"name",num,@"number",subnum,@"subnumber",level,@"level",item,@"item",gender,@"gender",happy,@"happy",nil]];}];
	}
}

#pragma mark TableView Methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	
	Species *mySpec;
	if (self.useMain) {
		mySpec = [self.speciesList objectAtIndex:indexPath.row];
	} else {
		mySpec = [self.searchList objectAtIndex:indexPath.row];
	}
	
	if ([mySpec.subnumber intValue]==0) {
		[cell.textLabel setText:[NSString stringWithFormat:@"%d      %@",[mySpec.number intValue],mySpec.name]];
	} else {
		[cell.textLabel setText:[NSString stringWithFormat:@"%d:%d    %@",[mySpec.number intValue],[mySpec.subnumber intValue],mySpec.name]];
	}
	
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (self.useMain) {
		return self.speciesList.count;
	} else {
		return self.searchList.count;
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (self.useMain) {
		self.theSpecies = [self.speciesList objectAtIndex:indexPath.row];
	} else {
		self.theSpecies = [self.searchList objectAtIndex:indexPath.row];
	}
	
	int stat;
	if ([self.theSpecies.subnumber intValue]==0) {
		[self.pokeImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/%d.png",mydelegate.basePath,[self.theSpecies.number intValue]]]];
	}
	else {
		[self.pokeImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/%d-%d.png",mydelegate.basePath,[self.theSpecies.number intValue],[self.theSpecies.subnumber intValue]]]];
	}
	
	[self.pokeName setText: self.theSpecies.name];
	
	NSString *nFileList = [[NSString alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/stats.txt",mydelegate.basePath] encoding:NSUTF8StringEncoding error:nil];
	NSRange ranger = [nFileList rangeOfString:[NSString stringWithFormat:@"%d:",[self.theSpecies.number intValue]]];
	NSString *temp = [nFileList substringFromIndex:ranger.location];
	ranger = [temp rangeOfString:@" "];
	temp = [temp substringFromIndex:ranger.location+1];
	ranger = [temp rangeOfString:@" "];
	stat = [[temp substringToIndex:ranger.location] intValue];
	[self.barHP setProgress:(stat/255.0)];
	temp = [temp substringFromIndex:ranger.location+1];
	ranger = [temp rangeOfString:@" "];
	stat = [[temp substringToIndex:ranger.location] intValue];
	[self.barAtk setProgress:(stat/255.0)];
	temp = [temp substringFromIndex:ranger.location+1];
	ranger = [temp rangeOfString:@" "];
	stat = [[temp substringToIndex:ranger.location] intValue];
	[self.barDef setProgress:(stat/255.0)];
	temp = [temp substringFromIndex:ranger.location+1];
	ranger = [temp rangeOfString:@" "];
	stat = [[temp substringToIndex:ranger.location] intValue];
	[self.barSpa setProgress:(stat/255.0)];
	temp = [temp substringFromIndex:ranger.location+1];
	ranger = [temp rangeOfString:@" "];
	stat = [[temp substringToIndex:ranger.location] intValue];
	[self.barSpd setProgress:(stat/255.0)];
	temp = [temp substringFromIndex:ranger.location+1];
	ranger = [temp rangeOfString:@" "];
	stat = [[temp substringToIndex:ranger.location] intValue];
	[self.barSpe setProgress:(stat/255.0)];
	temp = [temp substringFromIndex:ranger.location+1];
	
}

#pragma mark SearchBar Methods
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	if ([searchText isEqualToString:@""]) {
		self.useMain = YES;
		[self.theTable reloadData];
	} else {
		self.useMain = NO;
		
		self.searchList = [[NSMutableArray alloc] initWithArray:self.speciesList];
		for (int x=0; x<self.searchList.count; x++) {
			Species *tempspec = [self.searchList objectAtIndex:x];
			if ([tempspec.name rangeOfString:searchText options:NSCaseInsensitiveSearch].location==NSNotFound) {
				[self.searchList removeObjectAtIndex:x];
				x--;
			}
		}
		
		[self.theTable reloadData];
	}
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	[searchBar resignFirstResponder];
	[searchBar setText:@""];
	self.useMain = YES;
	[self.theTable reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[searchBar resignFirstResponder];
}

@end

#pragma mark SPECIES

@implementation Species

- (id)init
{
	self.number = 0;
	self.subnumber = 0;
	self.name = @"Missingno";
	
	return self;
}

@end
