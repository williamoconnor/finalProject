//
//  Student.m
//  FinalProject
//
//  Created by William O'Connor on 5/4/15.
//  Copyright (c) 2015 slickWilly. All rights reserved.
//

#import "ThingAboutWill.h"

@implementation ThingAboutWill

-(id)initWithTitle:(NSString*)title andPhoto:(UIImage*)photo andDetail:(NSString*)detail
{
    self = [super init];
    
    self.title = title;
    self.photo = photo;
    self.details = detail;
    
    return self;
}

@end
