//
//  Utilities.h
//
//
//  Created by synerzip
//



@interface Utilities : NSObject

@end

#pragma mark - Cocoa Helpers

NSArray* arrayFromDictionaryForKey(NSDictionary *parent, NSString *key);
NSString* stringForObject(id object);
NSNumber* numberForObject(id object);

BOOL isValidDictionary(NSDictionary *d);
BOOL isValidArray(NSArray *arr);
BOOL isValidString(NSString *str);
BOOL isValidStringChomped(NSString *str);