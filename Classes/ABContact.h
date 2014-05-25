//
//  ABContact.h
//  shakka.me
//
//  Created by Shay Erlichmen on 12/10/12.
//  Copyright (c) 2012 shakka.me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBookUI/AddressBookUI.h>

@class ABAddressBook;

@interface ABContact : NSObject

- (instancetype)initWithRecord:(ABRecordRef)aRecord;

@property (readonly, strong, nonatomic) UIImage *thumbnailImage;
@property (readonly, strong, nonatomic) NSString *nickName;
@property (readonly, strong, nonatomic) NSString *firstName;
@property (readonly, strong, nonatomic) NSString *lastName;
@property (readonly, strong, nonatomic) NSNumber *recordId;
@property (readonly, strong, nonatomic) NSDate *lastModified;
@property (nonatomic, readonly, strong) NSArray *phones;

@property (nonatomic, readonly) BOOL hasImage;

@end
