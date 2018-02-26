//
//  BaseModel.h
//  Blossoms
//
//  Created by chenghong_mac on 15/12/17.
//  Copyright © 2015年 FL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
- (id)valueForUndefinedKey:(NSString *)key;

@end
