//
//  SPDetailViewController.h
//  SPCoreData
//
//  Created by popovychs on 17.11.15.
//  Copyright © 2015 popovychs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPNote+CoreDataProperties.h"
#import "SPPhoto+CoreDataProperties.h"

@interface SPDetailViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (strong, nonatomic) SPNote * selectedNote;
@property (strong, nonatomic) SPPhoto * selectedPhoto;

@end