//
//  UVMRadioModel.m
//  RadioUVM
//
//  Created by Camilo Castro on 12-10-14.
//  Copyright (c) 2014 Universidad de Viña del Mar. All rights reserved.
//

#import "UVMRadioModel.h"

@implementation UVMRadioModel

#pragma mark - Abstract Methods

/*!
 * Returns all the radios available
 * for listening
 * @return NSArray of UVMRadioModel Objects
 */
+ (NSArray *) allRadios {
    
    UVMRadioModel * radio1 = [UVMRadioModel new];

    // Radio UVM FM
    radio1.url = [NSURL URLWithString:@"http://200.24.229.253:8020/"];
    
    return @[radio1];
}

@end
