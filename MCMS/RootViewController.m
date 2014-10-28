//
//  ViewController.m
//  MCMS
//
//  Created by CHRISTINA GUNARTO on 10/28/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import "RootViewController.h"
#import "MagicalCreature.h"

@interface RootViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MagicalCreature *creatureOne = [[MagicalCreature alloc]initWithName:@"Ducky"];
    MagicalCreature *creatureTwo = [[MagicalCreature alloc]initWithName:@"Bucky"];
    MagicalCreature *creatureThree = [[MagicalCreature alloc]initWithName:@"Lucky"];

    self.creatures = [@[creatureOne, creatureTwo, creatureThree] mutableCopy];

}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.creatures.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    MagicalCreature *creature = self.creatures[indexPath.row];
    cell.textLabel.text = creature.name;

    return cell;
}

- (IBAction)onAddButtonPressed:(id)sender
{
    if(![self.textField.text isEqualToString:@""])
    {
        NSString *creatureName = self.textField.text;
        MagicalCreature *creatureToAdd = [[MagicalCreature alloc]initWithName:creatureName];
        [self.creatures addObjectsFromArray:@[creatureToAdd]];

        [self.tableView reloadData];
    }

    self.textField.text = @""; // clear the text
    [self.textField resignFirstResponder]; //clears the keyboard

}




@end
