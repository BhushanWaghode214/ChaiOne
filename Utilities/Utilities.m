//
//  Utilities.m
//  
//
//  Created by synerzip
//  Copyright (c) 2014 RxNetwork. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

@end

#pragma mark - Cocoa Helpers

NSArray* arrayFromDictionaryForKey(NSDictionary *parent, NSString *key)
{
    if (isValidDictionary(parent))
    {
        id obj = [parent objectForKey:key];
        if ([obj isEqual:[NSNull null]] || nil == obj)
        {
            return [NSArray array];;
        }
        else if ([obj isKindOfClass:NSArray.class])
        {
            return obj;
        }
        
        return @[obj];
    }
    return [NSArray array];
}

NSString* stringForObject(id object)
{
    if (object == nil || [object isEqual:[NSNull null]]) return @"";
    return [NSString stringWithFormat:@"%@", object];
}

NSNumber* numberForObject(id object)
{
    if (object == nil || [object isEqual:[NSNull null]]) return nil;
    
    if ([object isKindOfClass:[NSNumber class]])
    {
        return object;
    }
    return nil;
}

inline BOOL isValidDictionary(NSDictionary *d)
{
    if (d == nil || [d isEqual:[NSNull null]]) return NO;
    return [d isKindOfClass:NSDictionary.class] && (d.allKeys.count > 0);
}

inline BOOL isValidArray(NSArray *arr)
{
    if (arr == nil || [arr isEqual:[NSNull null]]) return NO;
    return [arr isKindOfClass:NSArray.class] && (arr.count > 0);
}

inline BOOL isValidString(NSString *str)
{
    if (str == nil || [str isEqual:[NSNull null]]) return NO;
    return (str.length > 0);
}
