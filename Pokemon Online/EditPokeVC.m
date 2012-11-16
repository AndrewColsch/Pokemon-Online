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
	self.nameLabel.text = self.thePokemon.species;
	[self.type1img setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/type%d.png",mydelegate.basePath,self.thePokemon.type1]]];
	if (self.thePokemon.type2==17) {
		[self.type2img setImage:nil];
	} else {
		[self.type2img setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/type%d.png",mydelegate.basePath,self.thePokemon.type2]]];
	}
}

- (IBAction)cancel:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
