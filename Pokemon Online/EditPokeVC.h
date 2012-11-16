//
//  EditPokeVC.h
//  Pokemon Online
//
//  Created by Andrew Colsch on 11/16/12.
//  Copyright (c) 2012 Andrew Colsch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokemon.h"

@interface EditPokeVC : UIViewController

@property (nonatomic, retain) Pokemon *thePokemon;
@property (nonatomic, retain) IBOutlet UIImageView *pokeImage;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UIImageView *type1img;
@property (nonatomic, retain) IBOutlet UIImageView *type2img;

- (id)initWithPokemon:(Pokemon *)poke;
- (IBAction)cancel:(id)sender;

@end
