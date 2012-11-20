//
//  EditPokeVC.h
//  Pokemon Online
//
//  Created by Andrew Colsch on 11/16/12.
//  Copyright (c) 2012 Andrew Colsch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokemon.h"

@interface EditPokeVC : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, retain) Pokemon *thePokemon;
@property (nonatomic, retain) IBOutlet UIImageView *pokeImage;
@property (nonatomic, retain) IBOutlet UIImageView *itemImage;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UIImageView *genderImage;
@property (nonatomic, retain) IBOutlet UIImageView *type1img;
@property (nonatomic, retain) IBOutlet UIImageView *type2img;
@property (nonatomic, retain) IBOutlet UITextField *nicknameField;
@property (nonatomic, retain) IBOutlet UIButton *natureButton;
@property (nonatomic, retain) IBOutlet UILabel *natureLabel;
@property (nonatomic, retain) UIPickerView *natureList;
@property (nonatomic, retain) IBOutlet UIButton *itemButton;
@property (nonatomic, retain) IBOutlet UILabel *itemLabel;
@property (nonatomic, retain) UIPickerView *itemList;
@property (nonatomic, retain) IBOutlet UIStepper *happyStep;
@property (nonatomic, retain) IBOutlet UITextField *happyField;

- (id)initWithPokemon:(Pokemon *)poke;
- (IBAction)pickNature:(id)sender;
- (IBAction)pickItem:(id)sender;
- (IBAction)stepHappy:(UIStepper *)sender;
- (IBAction)cancel:(id)sender;

@end
