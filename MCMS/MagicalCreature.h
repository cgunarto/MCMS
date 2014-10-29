//
//  Magical Creature.h
//  MCMS
//
//  Created by CHRISTINA GUNARTO on 10/28/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MagicalCreature : NSObject
@property NSString *name;
@property NSString *element;
@property NSInteger *strength;
@property (strong, nonatomic) UIImage *image;
@property NSMutableArray *accesories;

- (instancetype)initWithName: (NSString *)name;


@end
