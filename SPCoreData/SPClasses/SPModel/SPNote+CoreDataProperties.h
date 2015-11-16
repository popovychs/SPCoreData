//
//  SPNote+CoreDataProperties.h
//  SPCoreData
//
//  Created by popovychs on 16.11.15.
//  Copyright © 2015 popovychs. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SPNote.h"

NS_ASSUME_NONNULL_BEGIN

@interface SPNote (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *textDescription;
@property (nullable, nonatomic, retain) NSDate *timeStamp;
@property (nullable, nonatomic, retain) SPPhoto *photoForNote;

@end

NS_ASSUME_NONNULL_END
