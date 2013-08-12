//
//  ABAddressBook.m
//  shakka.me
//
//  Created by Shay Erlichmen on 12/10/12.
//  Copyright (c) 2012 shakka.me. All rights reserved.
//

#import "ABAddressBook.h"
#import "ABContact.h"

@interface ABAddressBook() {
    ABAddressBookRef _addressBook;
}
@end

@implementation ABAddressBook

- (id)initAndCreate {
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    ABAddressBookRef addressBook;
    
    if (ABAddressBookCreateWithOptions != NULL) {
        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    } else {
        addressBook = ABAddressBookCreate();
    }
    
    if (addressBook == nil) {
        return nil;
    }
    
    _addressBook = addressBook;
    
    return self;
}

- (id)initWithAddressBook:(ABAddressBookRef)aAddressBook;
{
    if ((self = [super init])) {
        _addressBook = CFRetain(aAddressBook);
    }
    return self;
}

- (void) dealloc
{
	if (_addressBook) {
        CFRelease(_addressBook);
    }
}

- (NSArray *) contacts {
    ABRecordRef allSources = ABAddressBookCopyArrayOfAllSources(_addressBook);
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1000];
    
    for (CFIndex i = 0; i < CFArrayGetCount(allSources); i++) {
        ABRecordRef source = (ABRecordRef)CFArrayGetValueAtIndex(allSources, i);
        
        CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeopleInSourceWithSortOrdering(_addressBook,
                                                                                         source,
                                                                                         kABPersonSortByFirstName);
        
        CFIndex nPeople = CFArrayGetCount(allPeople);
        
        for (unsigned j = 0; j < nPeople; j++) {
            ABRecordRef personRef = CFArrayGetValueAtIndex( allPeople, j );
        
            ABContact *person = [[ABContact alloc] initWithRecord:personRef];
            [array addObject:person];
        
            CFRelease(personRef);
        }
	}

	return array;
}

- (ABContact *)contactFromId:(NSNumber *)recordId {
    ABRecordRef record = ABAddressBookGetPersonWithRecordID(_addressBook, [recordId intValue]);
    return [[ABContact alloc] initWithRecord:record];
}

-(void)requestAccessWithCompletion:(ABAddressBookRequestAccessCompletionHandler)callback {
    ABAddressBookRequestAccessWithCompletion(_addressBook, callback);
}

-(void)unregisterExternalChangeCallback:(ABExternalChangeCallback)callback withContext:(void *)context {
    ABAddressBookUnregisterExternalChangeCallback(_addressBook, callback, context);
}

-(void)registerExternalChangeCallback:(ABExternalChangeCallback)callback withContext:(void *)context {
    ABAddressBookRegisterExternalChangeCallback(_addressBook, callback, context);
}

@end
