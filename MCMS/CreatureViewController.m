//
//  CreatureViewController.m
//  MCMS
//
//  Created by CHRISTINA GUNARTO on 10/28/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import "CreatureViewController.h"
#import "RootViewController.h"

@interface CreatureViewController () <UITableViewDataSource, UITabBarDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *elementLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *battleButton;
@property (weak, nonatomic) IBOutlet UILabel *winCountLabel;

@end

@implementation CreatureViewController

#pragma mark View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nameLabel.text = self.creature.name;
    self.elementLabel.text = self.creature.element;

    self.winCountLabel.text = [NSString stringWithFormat:@"%ld", (long)self.creature.winCount ];

    self.imageView.image = self.creature.image;
    self.textField.hidden = YES;

}

- (void)viewWillAppear:(BOOL)animated
{
    //BATTLE CHOSEN button change colors depending on Magical Creature custom property isSelectedForBattle
    if(self.creature.isSelectedForBattle == YES)
    {
        self.battleButton.backgroundColor = [UIColor cyanColor];

    }
    else
    {
        self.battleButton.backgroundColor = [UIColor whiteColor];
    }


}

#pragma mark Table View

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.creature.accessories.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *accessoryCell = [self.tableView dequeueReusableCellWithIdentifier:@"accessoryCell" forIndexPath:indexPath];
    accessoryCell.textLabel.text = self.creature.accessories[indexPath.row];
    return accessoryCell;
}


#pragma mark Button Pressed Methods

- (IBAction)onEditButtonPressed:(UIBarButtonItem *)editButton
{
    self.textField.hidden = !self.textField.hidden;
    self.nameLabel.hidden = !self.textField.hidden;

    if (self.textField.hidden)
    {
        editButton.title = @"Edit";
        self.creature.name = self.textField.text; // this is where we are accessing the pointer of the original object and assigning it with whatever text we put it textfield
        self.nameLabel.text = self.textField.text;
        // have to put this somewhere
    }


    else
    {
        editButton.title = @"Done";
    }

}


- (IBAction)onBattleButtonPressed:(UIButton*)button
    {
    if(self.creature.isSelectedForBattle == YES)
    {
        button.backgroundColor = [UIColor whiteColor];
        self.creature.isSelectedForBattle = NO;
    }
    else
    {
        button.backgroundColor = [UIColor cyanColor];
        self.creature.isSelectedForBattle = YES;
    }

}


//returns back
- (IBAction)unWindToList:(UIStoryboardSegue*)segue
{
}


@end
