//
//  TBPokePreviewView.h
//  Pokemon Online
//
//  Created by Andrew Colsch on 11/15/12.
//  Copyright (c) 2012 Andrew Colsch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBPokePreviewView : UIView

@property (nonatomic, retain) IBOutlet UIImageView *image;
@property (nonatomic, retain) IBOutlet UILabel *level;
@property (nonatomic, retain) IBOutlet UILabel *nickname;
@property (nonatomic, retain) IBOutlet UILabel *species;
@property (nonatomic, retain) IBOutlet UIImageView *item;


@end
