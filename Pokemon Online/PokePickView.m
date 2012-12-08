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

#pragma mark TableView Methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	
	Species *mySpec = [self.speciesList objectAtIndex:indexPath.row];
	if ([mySpec.subnumber intValue]==0) {
		[cell.textLabel setText:[NSString stringWithFormat:@"%d      %@",[mySpec.number intValue],mySpec.name]];
	} else {
		[cell.textLabel setText:[NSString stringWithFormat:@"%d:%d    %@",[mySpec.number intValue],[mySpec.subnumber intValue],mySpec.name]];
	}
	
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.speciesList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	Species *selspec = [self.speciesList objectAtIndex:indexPath.row];
	if ([selspec.subnumber intValue]==0) {
		[self.pokeImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/%d.png",mydelegate.basePath,[selspec.number intValue]]]];
	}
	else {
		[self.pokeImage setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/images/black-white/%d-%d.png",mydelegate.basePath,[selspec.number intValue],[selspec.subnumber intValue]]]];
	}
}

@end

@implementation Species

- (id)init
{
	self.number = 0;
	self.subnumber = 0;
	self.name = @"Missingno";
	
	return self;
}

@end
