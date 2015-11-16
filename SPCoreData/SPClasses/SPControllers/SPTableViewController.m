//
//  SPTableViewController.m
//  SPCoreData
//
//  Created by popovychs on 16.11.15.
//  Copyright © 2015 popovychs. All rights reserved.
//

#import "SPTableViewController.h"
#import "SPTableViewCell.h"
#import "SPCoreDataController.h"
#import "SPNote+CoreDataProperties.h"
#import "SPPhoto+CoreDataProperties.h"

@interface SPTableViewController ()

@property (strong, nonatomic) NSMutableArray * arrayOfNotes;

@end

@implementation SPTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Easy Note";
    
    [self welcomeMessage];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self updateNotes];
    [self updatePhotos];
    [self.tableView reloadData];
}

#pragma mark - Welcome Message

- (void) welcomeMessage
{
    if (!self.arrayOfNotes.count)
    {
        UILabel * welcomeMessage =[[UILabel alloc] initWithFrame:
                                 CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        welcomeMessage.text = @"No Note! Let's create one now. Touch + on the top right corner";
        welcomeMessage.textColor = [UIColor blueColor];
        welcomeMessage.textAlignment = NSTextAlignmentCenter;
        welcomeMessage.numberOfLines = 0;
        self.tableView.backgroundView = welcomeMessage;
    }
    else self.tableView.backgroundView = nil;
}

#pragma mark - Update Notes and Photos

- (void) updateNotes
{
    SPCoreDataController * coreDataManager = [SPCoreDataController sharedInstance];
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Note"];
    [self.arrayOfNotes removeAllObjects];
    self.arrayOfNotes = [[coreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [self sortNotesByTime];
}

- (void) updatePhotos
{
//    SPCoreDataController * coreDataManager = [SPCoreDataController sharedInstance];
//    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Photo"];
//    
//    NSMutableArray * photoArray = [[coreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
//    for (SPPhoto * photo in photoArray)
//    {
//        if (photo.notesWithPhoto.count == 0)
//        {
//            [coreDataManager.managedObjectContext deleteObject:photo];
//        }
//    }
//    
//    NSError * error = nil;
//    if (![coreDataManager.managedObjectContext save:&error])
//    {
//        NSLog(@"Can't delete photo - %@ %@", error, [error localizedDescription]);
//    }
    
}

- (void) sortNotesByTime
{
    NSSortDescriptor * sortDescriptor;
    sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"timeStamp" ascending:NO];
    NSArray * sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray * sortedArray = [self.arrayOfNotes sortedArrayUsingDescriptors:sortDescriptors];
    self.arrayOfNotes = [sortedArray mutableCopy];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfNotes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    [self prepareNoteCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)prepareNoteCell:(SPTableViewCell*)cell atIndexPath: (NSIndexPath*)indexPath
{
    SPNote * newNote = [self.arrayOfNotes objectAtIndex:indexPath.row];
    cell.cellNoteTextView.text = newNote.textDescription;
    cell.cellNoteTextView.textAlignment = NSTextAlignmentJustified;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"uk_UK"]];
    NSString * dateFormat = @"dd MMMM yyyy, HH:mm";
    [formatter setDateFormat:dateFormat];
    cell.cellDateLabel.text = [formatter stringFromDate:newNote.timeStamp];
    cell.cellPhotoButton.tag = indexPath.row;
    cell.cellEditButton.tag = indexPath.row;
    cell.cellDeleteButton.tag = indexPath.row;
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
