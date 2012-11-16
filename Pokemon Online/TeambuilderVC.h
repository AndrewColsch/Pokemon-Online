//
//  TeambuilderVC.h
//  Pokemon Online
//
//  Created by Andrew Colsch on 11/14/12.
//  Copyright (c) 2012 Andrew Colsch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokemon.h"
#import "TBPokePreviewView.h"

@interface TeambuilderVC : UIViewController

@property (nonatomic, retain) IBOutlet TBPokePreviewView *pokeView1;
@property (nonatomic, retain) IBOutlet TBPokePreviewView *pokeView2;
@property (nonatomic, retain) IBOutlet TBPokePreviewView *pokeView3;
@property (nonatomic, retain) IBOutlet TBPokePreviewView *pokeView4;
@property (nonatomic, retain) IBOutlet TBPokePreviewView *pokeView5;
@property (nonatomic, retain) IBOutlet TBPokePreviewView *pokeView6;

- (IBAction)loadTeam:(id)sender;

@end
