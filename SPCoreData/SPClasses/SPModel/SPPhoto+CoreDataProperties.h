//
//  SPPhoto+CoreDataProperties.h
//  SPCoreData
//
//  Created by popovychs on 16.11.15.
//  Copyright © 2015 popovychs. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SPPhoto.h"

NS_ASSUME_NONNULL_BEGIN

@interface SPPhoto (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *photoData;
@property (nullable, nonatomic, retain) NSString *photoName;
@property (nullable, nonatomic, retain) NSNumber *photoNumber;
@property (nullable, nonatomic, retain) SPNote *notesWithPhoto;

@end

NS_ASSUME_NONNULL_END
