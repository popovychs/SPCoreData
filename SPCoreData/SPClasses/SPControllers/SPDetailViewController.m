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
}

- (IBAction)cancelButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end