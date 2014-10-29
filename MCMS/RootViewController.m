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
#import <stdlib.h>

@interface RootViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    MagicalCreature *creatureOne = [[MagicalCreature alloc]initWithName:@"Ducky"];
    creatureOne.element = @"Coder Duck";
    creatureOne.image = [UIImage imageNamed:@"ducky"];
    creatureOne.accessories = [@[@"spectacles",@"macbook",@"XCode", @"nerd tie"]mutableCopy];

    MagicalCreature *creatureTwo = [[MagicalCreature alloc]initWithName:@"Bucky"];
    creatureTwo.element = @"Urban Duck";
    creatureTwo.image = [UIImage imageNamed:@"bucky"];
    creatureTwo.accessories = [@[@"gangsta hat", @"chain", @"long black tee"]mutableCopy];
    
    MagicalCreature *creatureThree = [[MagicalCreature alloc]initWithName:@"Lucky"];
    creatureThree.element = @"Sassy Duck";
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

    if (creature.isSelectedForBattle == YES)
    {
        cell.backgroundColor = [UIColor redColor];
    }
    else
    {
        cell.backgroundColor = [UIColor whiteColor];
    }

    return cell;
}

- (IBAction)onAddButtonPressed:(id)sender
{
    if(![self.textField.text isEqualToString:@""])
    {

        //DEFAULT MAGICAL CREATURE
        NSString *creatureName = self.textField.text;
        NSString *element = @"Coder Duck";
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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CreatureViewController *creatureVC = segue.destinationViewController;
    NSInteger rowNumber = [self.tableView indexPathForSelectedRow].row;
    MagicalCreature *theCreature = [self.creatures objectAtIndex:rowNumber];
    creatureVC.creature = theCreature; //we are passing the creature object from RootViewController to the segue's destination (CreatureViewController)

}
- (IBAction)onBattleChosenButton:(UIButton *)sender
{

    NSMutableArray *chosenDucks = [[NSMutableArray alloc]init];

    for (int i = 0; i < self.creatures.count; i++)
    {
        MagicalCreature *creature = self.creatures[i];
        if (creature.isSelectedForBattle == YES)
        {
            [chosenDucks addObject:creature];
        }
    }

    if (chosenDucks.count < 2)
    {
        UIAlertController *chooseAnotherDuck = [UIAlertController alertControllerWithTitle:@"Not enough ducks chosen" message:@"choose at least 2" preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];

        [chooseAnotherDuck addAction:cancel];
        [self presentViewController:chooseAnotherDuck animated:YES completion:nil];

    }
    else
    {
        MagicalCreature *creature = [chosenDucks objectAtIndex:arc4random() % [chosenDucks count]];

        NSString *winningMessage = (@"%@ is the winner", creature.name);

        UIAlertController *announceWinner = [UIAlertController alertControllerWithTitle:@"We have a winner" message:winningMessage preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *playAgain = [UIAlertAction actionWithTitle:@"Play again" style:UIAlertActionStyleDefault handler:nil];

        [announceWinner addAction:playAgain];
        [self presentViewController:announceWinner animated:YES completion:nil];


    }

}



@end
