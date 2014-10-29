//
//  Magical Creature.m
//  MCMS
//
//  Created by CHRISTINA GUNARTO on 10/28/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import "MagicalCreature.h"

@implementation MagicalCreature

-(instancetype)initWithName: (NSString *)name
{
    self = [super init];
    self.name = name;
//    self.type = type;
    return self;
}

- (instancetype)initWithName:(NSString *)name withElement:(NSString *)element withImage:(UIImage *)image withAccessories:(NSMutableArray*)accessories
{
    self = [super init];
    self.name = name;
    self.element = element;
    self.image = image;
    self.accessories = accessories;
    return self;
}



@end
