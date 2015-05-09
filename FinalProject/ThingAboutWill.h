//
//  Student.h
//  FinalProject
//
//  Created by William O'Connor on 5/4/15.
//  Copyright (c) 2015 slickWilly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ThingAboutWill : NSObject

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* details;
@property (strong, nonatomic) UIImage* photo;

-(id)initWithTitle:(NSString*)title andPhoto:(UIImage*)photo andDetail:(NSString*)detail;

@end
