//
//  EditMoreVC.h
//  Pokemon Online
//
//  Created by Andrew Colsch on 11/27/12.
//  Copyright (c) 2012 Andrew Colsch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokemon.h"
#import "PokePickView.h"
#import "Move.h"

@interface EditMoreVC : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) Pokemon *thePokemon;
@property (nonatomic, retain) NSNumber *theIndex;
@property (nonatomic, retain) IBOutlet UIImageView *pokeImage;
@property (nonatomic, retain) IBOutlet UIImageView *itemImage;
@property (nonatomic, retain) IBOutlet UIButton *IVButton;
@property (nonatomic, retain) IBOutlet UIStepper *IVStepper;
@property (readwrite) int currentIV;

@property (nonatomic, retain) IBOutlet UIButton *abilityButton;
@property (nonatomic, retain) IBOutlet UITextView *abilityDesc;
@property (readwrite) int ab1;
@property (readwrite) int ab2;
@property (readwrite) int ab3;
@property (nonatomic, retain) NSString *ability1;
@property (nonatomic, retain) NSString *ability2;
@property (nonatomic, retain) NSString *ability3;
@property (nonatomic, retain) NSString *abdesc1;
@property (nonatomic, retain) NSString *abdesc2;
@property (nonatomic, retain) NSString *abdesc3;

@property (nonatomic, retain) IBOutlet UITableView *moveTable;
@property (nonatomic, retain) UIView *segview;
@property (nonatomic, retain) UITableViewCell *headerCell;
@property (nonatomic, retain) IBOutlet UIButton *moveButton1;
@property (nonatomic, retain) IBOutlet UIButton *moveButton2;
@property (nonatomic, retain) IBOutlet UIButton *moveButton3;
@property (nonatomic, retain) IBOutlet UIButton *moveButton4;
@property (nonatomic, retain) NSMutableArray *moveList;
@property (nonatomic, retain) Move *move1;
@property (nonatomic, retain) Move *move2;
@property (nonatomic, retain) Move *move3;
@property (nonatomic, retain) Move *move4;
@property (readwrite) int moveEditing;

- (id)initWithPokemon:(Pokemon *)poke fromIndex:(int)ind;
- (IBAction)cycleIVs:(id)sender;
- (IBAction)changeIV:(id)sender;
- (IBAction)cycleAbilities:(id)sender;
- (IBAction)goBack:(id)sender;
- (IBAction)editSpecies:(UITapGestureRecognizer *)sender;
- (IBAction)editMove:(UIButton *)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
- (void)setupInterface;
- (void)createMoveList;

// segmented control actions
- (void)changeSort:(UISegmentedControl *)sender;
- (void)sortByType;
- (void)sortByName;
- (void)sortByLearn;
- (void)sortByPP;
- (void)sortByPower;
- (void)sortByAccuracy;

@end
