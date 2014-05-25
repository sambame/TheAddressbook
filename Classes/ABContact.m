//
//  ABContact.m
//  shakka.me
//
//  Created by Shay Erlichmen on 12/10/12.
//  Copyright (c) 2012 shakka.me. All rights reserved.
//

#import "ABContact.h"

@interface ABContact() {
    ABRecordRef _record;
}
@end

@implementation ABContact

- (instancetype)initWithRecord:(ABRecordRef)aRecord {
    if (aRecord == nil) {
        return nil;
    }
    
    if ((self = [super init])) {
        _record = CFRetain(aRecord);
    }
    return self;
}

- (void) dealloc
{
	if (_record) {
        CFRelease(_record);
    }
}

-(UIImage*)thumbnailImage {
    NSData *contactImageData = (__bridge NSData *)(ABPersonCopyImageDataWithFormat(_record, kABPersonImageFormatThumbnail));
    
    return [[UIImage alloc] initWithData:contactImageData];
}

- (NSString *) getRecordString:(ABPropertyID) anID {
	NSString *result = CFBridgingRelease(ABRecordCopyValue(_record, anID));
    if ([result isEqualToString:@"(null)"]) {
        result = nil;
    }
    
    return result;
}

- (NSDate *) getRecordDate:(ABPropertyID) anID {
    return CFBridgingRelease(ABRecordCopyValue(_record, anID));
}

- (NSArray *) valueLabelDictArrayForProperty: (ABPropertyID) anID
{
	CFTypeRef theProperty = ABRecordCopyValue(_record, anID);
    NSInteger count = ABMultiValueGetCount(theProperty);
   
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:count];
    
    for (unsigned i=0;i<count;++i) {
        NSString *label = CFBridgingRelease(ABMultiValueCopyLabelAtIndex(theProperty, i));
        NSString *value = CFBridgingRelease(ABMultiValueCopyValueAtIndex(theProperty, i));
        
        if (label ==  nil) {
            continue;
        }
        
        [result addObject:@{@"value": value, @"label": label}];
    }
    
	CFRelease(theProperty);
	return result;
}

- (NSDate *) lastModified {
    return [self getRecordDate:kABPersonModificationDateProperty];
}

- (NSNumber *) recordId {
    return [NSNumber numberWithInt:ABRecordGetRecordID(_record)];
}

- (NSString *) nickName {
    return [self getRecordString:kABPersonNicknameProperty];
}

- (NSString *) firstName {
    return [self getRecordString:kABPersonFirstNameProperty];
}

- (NSString *) lastName {
    return [self getRecordString:kABPersonLastNameProperty];
}

- (NSArray *) phones {
    return [self valueLabelDictArrayForProperty:kABPersonPhoneProperty];
}

-(BOOL)hasImage {
    return ABPersonHasImageData(_record);
}

@end
