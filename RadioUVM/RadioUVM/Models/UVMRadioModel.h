//
//  UVMRadioModel.h
//  RadioUVM
//
//  Created by Camilo Castro on 12-10-14.
//  Copyright (c) 2014 Universidad de Viña del Mar. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * This Model returns all the radios
 * that the application should use
 */
@interface UVMRadioModel : NSObject

#pragma mark - Properties

/*!
 * This property holds the url for the 
 * streaming.
 */
@property (nonatomic) NSURL * url;

#pragma mark - Abstract Methods

/*!
 * Returns all the radios available
 * for listening
 * @return NSArray of UVMRadioModel Objects
 */
+ (NSArray *) allRadios;

@end
