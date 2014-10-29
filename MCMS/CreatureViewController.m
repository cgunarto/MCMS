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

@end

@implementation CreatureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nameLabel.text = self.creature.name;
    self.elementLabel.text = self.creature.element;
    self.imageView.image = self.creature.image;
    self.textField.hidden = YES;

}

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

//returns back
- (IBAction)unWindToList:(UIStoryboardSegue*)segue
{
}






@end
