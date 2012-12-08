//
//  EditPokeVC.h
//  Pokemon Online
//
//  Created by Andrew Colsch on 11/16/12.
//  Copyright (c) 2012 Andrew Colsch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pokemon.h"
#import "PokePickView.h"

@interface EditPokeVC : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, retain) Pokemon *thePokemon;
@property (nonatomic, retain) NSNumber *theIndex;
@property (nonatomic, retain) IBOutlet UIImageView *pokeImage;
@property (nonatomic, retain) IBOutlet UIImageView *itemImage;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UISegmentedControl *genderSwitch;
@property (nonatomic, retain) IBOutlet UIImageView *type1img;
@property (nonatomic, retain) IBOutlet UIImageView *type2img;
@property (nonatomic, retain) IBOutlet UITextField *nicknameField;
@property (nonatomic, retain) IBOutlet UIButton *natureButton;
@property (nonatomic, retain) UIPickerView *natureList;
@property (nonatomic, retain) IBOutlet UIButton *itemButton;
@property (nonatomic, retain) UIPickerView *itemList;
@property (nonatomic, retain) IBOutlet UIStepper *happyStep;
@property (nonatomic, retain) IBOutlet UITextField *happyField;
@property (nonatomic, retain) IBOutlet UIStepper *levelStep;
@property (nonatomic, retain) IBOutlet UITextField *levelField;
@property (nonatomic, retain) IBOutlet UISwitch *shinySwitch;

@property (nonatomic, retain) IBOutlet UISlider *slideHP;
@property (nonatomic, retain) IBOutlet UISlider *slideAtk;
@property (nonatomic, retain) IBOutlet UISlider *slideDef;
@property (nonatomic, retain) IBOutlet UISlider *slideSpe;
@property (nonatomic, retain) IBOutlet UISlider *slideSpA;
@property (nonatomic, retain) IBOutlet UISlider *slideSpD;
@property (nonatomic, retain) IBOutlet UISlider *slideTotal;
@property (nonatomic, retain) IBOutlet UITextField *textHP;
@property (nonatomic, retain) IBOutlet UITextField *textAtk;
@property (nonatomic, retain) IBOutlet UITextField *textDef;
@property (nonatomic, retain) IBOutlet UITextField *textSpe;
@property (nonatomic, retain) IBOutlet UITextField *textSpA;
@property (nonatomic, retain) IBOutlet UITextField *textSpD;
@property (nonatomic, retain) IBOutlet UILabel *textTotal;

- (id)initWithPokemon:(Pokemon *)poke fromIndex:(int)ind;
- (IBAction)pickNature:(id)sender;
- (IBAction)pickItem:(id)sender;
- (IBAction)stepHappy:(UIStepper *)sender;
- (IBAction)stepLevel:(UIStepper *)sender;
- (IBAction)flipShiny:(id)sender;
- (IBAction)flipGender:(id)sender;
- (IBAction)slideStat:(UISlider *)sender;
- (IBAction)endSlide:(UISlider *)sender;
- (IBAction)editMore:(id)sender;
- (IBAction)editSpecies:(UITapGestureRecognizer *)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
- (void)setupInterface;

@end
