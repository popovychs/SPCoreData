//
//  SPDetailViewController.m
//  SPCoreData
//
//  Created by popovychs on 17.11.15.
//  Copyright © 2015 popovychs. All rights reserved.
//

#import "SPDetailViewController.h"
#import "SPCoreDataController.h"

@interface SPDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *detailDateLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@property (weak, nonatomic) IBOutlet UIButton *detailPhotoButton;

@property (strong, nonatomic) SPCoreDataController * coreDataManager;

@end

@implementation SPDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.coreDataManager = [SPCoreDataController sharedInstance];
    
    self.detailDateLabel.text = [self setStringFromDate];

    if (self.selectedNote) {
        [self editNote];
    }
}

#pragma mark - Editing Methods

-(void) editNote
{
    self.detailTextView.text = self.selectedNote.textDescription;
}

- (NSString*) setStringFromDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"uk_UK"]];
    NSString * dateFormat = @"dd MMMM yyyy, HH:mm";
    [formatter setDateFormat:dateFormat];
    return [formatter stringFromDate:[NSDate date]];
}

- (IBAction)saveButton:(UIButton *)sender {
    
    if (self.detailTextView.text.length)
    {
        SPNote * newNote;
        if (!self.selectedNote)
        {
            newNote = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:self.coreDataManager.managedObjectContext];
        }
        else newNote = self.selectedNote;
        
        newNote.textDescription = self.detailTextView.text;
        newNote.timeStamp = [NSDate date];
        
        NSError * error = nil;
        if (![self.coreDataManager.managedObjectContext save:&error])
        {
            NSLog(@"Can't save note text - %@ %@", error, [error localizedDescription]);
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Done" message:@"Successfully saved" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            });
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"No text" message:@"Note is empty. Add some text." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        });
}

- (IBAction)cancelButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end