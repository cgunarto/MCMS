//
//  ViewController.m
//  MCMS
//
//  Created by CHRISTINA GUNARTO on 10/28/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import "RootViewController.h"
#import "MagicalCreature.h"
#import "CreatureViewController.h"

@interface RootViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    MagicalCreature *creatureOne = [[MagicalCreature alloc]initWithName:@"Ducky"];
    creatureOne.element = @"water";
    creatureOne.image = [UIImage imageNamed:@"ducky"];
    creatureOne.accessories = [@[@"spectacles",@"macbook",@"XCode", @"nerd tie"]mutableCopy];
    MagicalCreature *creatureTwo = [[MagicalCreature alloc]initWithName:@"Bucky"];
    creatureTwo.element = @"earth";
    creatureTwo.image = [UIImage imageNamed:@"bucky"];
    creatureTwo.accessories = [@[@"gangsta hat", @"chain", @"long black tee"]mutableCopy];
    MagicalCreature *creatureThree = [[MagicalCreature alloc]initWithName:@"Lucky"];
    creatureThree.element = @"wind";
    creatureThree.image = [UIImage imageNamed:@"lucky"];
    creatureThree.accessories = [@[@"goggles", @"bikini", @"SPF", @"lip gloss"]mutableCopy];

    self.creatures = [@[creatureOne, creatureTwo, creatureThree] mutableCopy];
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
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
    cell.detailTextLabel.text = creature.element;

    return cell;
}

- (IBAction)onAddButtonPressed:(id)sender
{
    if(![self.textField.text isEqualToString:@""])
    {

        //DEFAULT MAGICAL CREATURE
        NSString *creatureName = self.textField.text;
        NSString *element = @"water";
        UIImage *defaultImage = [UIImage imageNamed:@"ducky"];
        NSMutableArray *accessories = [@[@"spectacles",@"macbook",@"XCode", @"nerd tie"] mutableCopy];


        MagicalCreature *creatureToAdd = [[MagicalCreature alloc] initWithName:creatureName
                                                                   withElement:element
                                                                     withImage:defaultImage
                                                               withAccessories:accessories];
        [self.creatures addObjectsFromArray:@[creatureToAdd]];

        [self.tableView reloadData];
    }

    self.textField.text = @""; // clear the text
    [self.textField resignFirstResponder]; //clears the keyboard

}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
//
//    MagicalCreature *creatureSelected = self.creatures[indexPath.row];
//
//    if (selectedCell.accessoryType == UITableViewCellAccessoryNone)
//    {
//       selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
//
////        toDoItemSelected.boolIsChecked = YES;
//
//    }
//    else if (selectedCell.accessoryType == UITableViewCellAccessoryCheckmark)
//    {
//        selectedCell.accessoryType = UITableViewCellAccessoryNone;
//
////        toDoItemSelected.boolIsChecked = NO;
//    }
//    
//    
//}







- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CreatureViewController *creatureVC = segue.destinationViewController;
    NSInteger rowNumber = [self.tableView indexPathForSelectedRow].row;
    MagicalCreature *theCreature = [self.creatures objectAtIndex:rowNumber];
    creatureVC.creature = theCreature; //we are passing the creature object from RootViewController to the segue's destination (CreatureViewController)

}


@end
