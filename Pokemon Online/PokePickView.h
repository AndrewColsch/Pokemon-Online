//
//  PokePickView.h
//  Pokemon Online
//
//  Created by Andrew Colsch on 12/7/12.
//  Copyright (c) 2012 Andrew Colsch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokemon.h"

@interface PokePickView : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) Pokemon *thePokemon;
@property (nonatomic, retain) IBOutlet UIImageView *pokeImage;
@property (nonatomic, retain) NSMutableArray *speciesList;
@property (nonatomic, retain) IBOutlet UITableView *theTable;

- (id)initWithPokemon:(Pokemon *)poke;
- (NSMutableArray *)loadList;

@end



// SPECIES CLASS //////////////////////////////////////////
// This class is used in the list of species for the table
// in this view controller.
@interface Species : NSObject

@property (nonatomic, retain) NSNumber *number;
@property (nonatomic, retain) NSNumber *subnumber;
@property (nonatomic, retain) NSString *name;

@end