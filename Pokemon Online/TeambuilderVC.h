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

@interface TeambuilderVC : UIViewController <UIActionSheetDelegate>

@property (nonatomic, retain) IBOutlet UIView *teamView;
@property (nonatomic, retain) IBOutlet TBPokePreviewView *pokeView1;
@property (nonatomic, retain) IBOutlet TBPokePreviewView *pokeView2;
@property (nonatomic, retain) IBOutlet TBPokePreviewView *pokeView3;
@property (nonatomic, retain) IBOutlet TBPokePreviewView *pokeView4;
@property (nonatomic, retain) IBOutlet TBPokePreviewView *pokeView5;
@property (nonatomic, retain) IBOutlet TBPokePreviewView *pokeView6;
@property (nonatomic, retain) IBOutlet UITextField *teamName;
@property (nonatomic, retain) NSMutableArray *teamList;

- (IBAction)handlePokeTap:(UITapGestureRecognizer *)sender;
- (IBAction)listTeams:(id)sender;
- (NSString *)removeTeamWithName:(NSString *)name fromList:(NSString *)list;
- (void)refreshInterface;
- (IBAction)saveTeam:(id)sender;
- (IBAction)newTeam:(id)sender;
- (IBAction)done:(id)sender;

@end
