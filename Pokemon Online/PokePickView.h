//
//  PokePickView.h
//  Pokemon Online
//
//  Created by Andrew Colsch on 12/7/12.
//  Copyright (c) 2012 Andrew Colsch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokemon.h"

// SPECIES CLASS //////////////////////////////////////////
// This class is used in the list of species for the table
// in this view controller.
@interface Species : NSObject

@property (nonatomic, retain) NSNumber *number;
@property (nonatomic, retain) NSNumber *subnumber;
@property (nonatomic, retain) NSString *name;

@end
///////////////////////////////////////////////////////////

@interface PokePickView : UIViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UIAlertViewDelegate>

@property (nonatomic, retain) Pokemon *thePokemon;
@property (nonatomic, retain) Species *theSpecies;
@property (nonatomic, retain) IBOutlet UIImageView *pokeImage;
@property (nonatomic, retain) IBOutlet UILabel *pokeName;
@property (nonatomic, retain) NSMutableArray *speciesList;
@property (nonatomic, retain) NSMutableArray *searchList;
@property (readwrite) bool useMain;
@property (nonatomic, retain) IBOutlet UISearchBar *theSearchBar;
@property (nonatomic, retain) IBOutlet UITableView *theTable;
@property (nonatomic, retain) IBOutlet UIProgressView *barHP;
@property (nonatomic, retain) IBOutlet UIProgressView *barAtk;
@property (nonatomic, retain) IBOutlet UIProgressView *barDef;
@property (nonatomic, retain) IBOutlet UIProgressView *barSpa;
@property (nonatomic, retain) IBOutlet UIProgressView *barSpd;
@property (nonatomic, retain) IBOutlet UIProgressView *barSpe;

- (id)initWithPokemon:(Pokemon *)poke;
- (NSMutableArray *)loadList;
- (IBAction)tapImage:(id)sender;

@end

