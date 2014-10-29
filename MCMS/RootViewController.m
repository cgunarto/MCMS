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

#pragma mark View Controller Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    //Creating initial ducks - two different init methods
    MagicalCreature *creatureOne = [[MagicalCreature alloc]initWithName:@"Ducky"];
    creatureOne.element = @"Coder Duck";
    creatureOne.image = [UIImage imageNamed:@"ducky"];
    creatureOne.accessories = [@[@"Spectacles",@"Macbook",@"XCode", @"Nerd tie"]mutableCopy];

    MagicalCreature *creatureTwo = [[MagicalCreature alloc]initWithName:@"Bucky"];
    creatureTwo.element = @"Urban Duck";
    creatureTwo.image = [UIImage imageNamed:@"bucky"];
    creatureTwo.accessories = [@[@"Gangsta hat", @"Chain", @"Long black tee"]mutableCopy];
    
    MagicalCreature *creatureThree = [[MagicalCreature alloc]initWithName:@"Lucky"];
    creatureThree.element = @"Sassy Duck";
    creatureThree.image = [UIImage imageNamed:@"lucky"];
    creatureThree.accessories = [@[@"Goggles", @"Bikini", @"SPF", @"Lip gloss"]mutableCopy];

    //Not sure the propery syntax for inserting this in the initiWithName... below so storing it in NSMutableArray before assigning
    NSMutableArray *accessories = [@[@"Tiara",
                                     @"Red Bra",
                                     @"Lipstick",
                                     @"Wig"] mutableCopy];

    MagicalCreature *creatureFour = [[MagicalCreature alloc]initWithName:@"Wucky"
                                                             withElement:@"Wonder Duck"
                                                               withImage:[UIImage imageNamed:@"wucky"]
                                                         withAccessories:accessories];

    accessories = [@[@"White mask",
                     @"Mechanical Parts",
                     @"Laser Gun",
                     @"Black glasses"] mutableCopy];

    MagicalCreature *creatureFive = [[MagicalCreature alloc]initWithName:@"Starky"
                                                             withElement:@"Star Duck"
                                                               withImage:[UIImage imageNamed:@"starky"]
                                                         withAccessories:accessories];

    accessories = [@[@"Blue Shirt",
                     @"Weird Hair",
                     @"Star Pin"] mutableCopy];

    MagicalCreature *creatureSix = [[MagicalCreature alloc]initWithName:@"Spocky"
                                                            withElement:@"Spock Duck"
                                                              withImage:[UIImage imageNamed:@"spocky"]
                                                        withAccessories:accessories];

    self.creatures = [@[creatureOne,
                        creatureTwo,
                        creatureThree,
                        creatureFour,
                        creatureFive,
                        creatureSix] mutableCopy];
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    //need to reload data from when it's coming back from CreatureVC and model data is change
}


#pragma mark Table View Cell Methods

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

    //if it's selected for battle, background color of cell changes
    if (creature.isSelectedForBattle == YES)
    {
        cell.backgroundColor = [UIColor cyanColor];
    }
    else
    {
        cell.backgroundColor = [UIColor whiteColor];
    }

    return cell;
}


#pragma mark Button Handlers

- (IBAction)onAddButtonPressed:(id)sender
{
    if(![self.textField.text isEqualToString:@""])
    {

        //This is the default magical creature -- later on change this to randomize
        NSString *creatureName = self.textField.text;
        NSString *element = @"Coder Duck";
        UIImage *defaultImage = [UIImage imageNamed:@"ducky"];
        NSMutableArray *accessories = [@[@"Spectacles",
                                         @"Macbook",
                                         @"XCode",
                                         @"Nerd tie"] mutableCopy];


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

- (IBAction)onBattleChosenButton:(UIButton *)sender
{

    NSMutableArray *chosenDucks = [[NSMutableArray alloc]init];

    //Finding out which duck in the row is chosen and then storing it in a chosenDuck array so we can randomize a winnder
    for (int i = 0; i < self.creatures.count; i++)
    {
        MagicalCreature *creature = self.creatures[i];
        if (creature.isSelectedForBattle == YES)
        {
            [chosenDucks addObject:creature];
        }
    }

    //IF ducks chosen are less than two, alert view need more ducks
    if (chosenDucks.count < 2)
    {
        UIAlertController *chooseAnotherDuck = [UIAlertController alertControllerWithTitle:@"Not enough ducks chosen"
                                                                                   message:@"choose at least 2"
                                                                            preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleDefault
                                                       handler:nil];

        [chooseAnotherDuck addAction:cancel];
        [self presentViewController:chooseAnotherDuck animated:YES completion:nil];

    }

    //otherwise randomize a winnder from chosen ducks
    else
    {
        MagicalCreature *creature = [chosenDucks objectAtIndex:arc4random() % [chosenDucks count]];

        NSString *winningMessage = (@"%@ is the winner", creature.name);

        UIAlertController *announceWinner = [UIAlertController alertControllerWithTitle:@"We have a winner"
                                                                                message:winningMessage
                                                                         preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *playAgain = [UIAlertAction actionWithTitle:@"Play again"
                                                            style:UIAlertActionStyleDefault
                                                          handler:nil];

        [announceWinner addAction:playAgain];
        [self presentViewController:announceWinner animated:YES completion:nil];
        
        
    }
    
}

#pragma mark Segue

//Pass the data into Creature VC
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CreatureViewController *creatureVC = segue.destinationViewController;
    NSInteger rowNumber = [self.tableView indexPathForSelectedRow].row;
    MagicalCreature *theCreature = [self.creatures objectAtIndex:rowNumber];
    creatureVC.creature = theCreature;
}




@end
