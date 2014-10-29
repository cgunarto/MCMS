//
//  CreatureViewController.m
//  MCMS
//
//  Created by CHRISTINA GUNARTO on 10/28/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import "CreatureViewController.h"
#import "RootViewController.h"

@interface CreatureViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation CreatureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nameLabel.text = self.creature.name;
    self.textField.hidden = YES;

}

- (IBAction)onEditButtonPressed:(UIBarButtonItem *)editButton
{
    self.textField.hidden = !self.textField.hidden;
    self.nameLabel.hidden = !self.textField.hidden;

    if (self.textField.hidden)
    {
        editButton.title = @"Edit";
        self.creature.name = self.textField.text;
        self.nameLabel.text = self.textField.text;
        // have to put this somewhere
    }


    else
    {
        editButton.title = @"Done";
    }

}

- (IBAction)unWindToList:(UIStoryboardSegue*)segue
{
}






@end
