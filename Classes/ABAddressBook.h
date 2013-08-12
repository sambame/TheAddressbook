//
//  ABAddressBook.h
//  shakka.me
//
//  Created by Shay Erlichmen on 12/10/12.
//  Copyright (c) 2012 shakka.me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBookUI/AddressBookUI.h>

@class ABContact;

@interface ABAddressBook : NSObject
- (id)initWithAddressBook:(ABAddressBookRef)aAddressBook;
- (id)initAndCreate;

- (ABContact *)contactFromId:(NSNumber *)recordId;
- (NSArray *) contacts;

-(void)requestAccessWithCompletion:(ABAddressBookRequestAccessCompletionHandler)callback;
-(void)unregisterExternalChangeCallback:(ABExternalChangeCallback)callback withContext:(void *)context;
-(void)registerExternalChangeCallback:(ABExternalChangeCallback)callback withContext:(void *)context;
@end
