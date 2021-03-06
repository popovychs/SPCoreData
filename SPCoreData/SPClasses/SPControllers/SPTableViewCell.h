//
//  SPTableViewCell.h
//  SPCoreData
//
//  Created by popovychs on 16.11.15.
//  Copyright © 2015 popovychs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cellDateLabel;
@property (weak, nonatomic) IBOutlet UITextView *cellNoteTextView;
@property (weak, nonatomic) IBOutlet UIButton *cellEditButton;
@property (weak, nonatomic) IBOutlet UIButton *cellDeleteButton;
@property (weak, nonatomic) IBOutlet UIButton *cellPhotoButton;

@end
