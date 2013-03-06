//
//  EYLutilities.h
//  ipmobman01
//
//  Created by Alex Zabeo on 24/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

//RGB color macro
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//RGB color macro with alpha
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#import <Foundation/Foundation.h>

@interface EYLutilities : NSObject

+(CGRect)getFrameForText:(NSString*)text inLabel:(UILabel*)label maximumSize:(CGSize)maxSize;
+(void)insertTextLabelWithFrame:(CGRect)frame Text:(NSString*)text textSize:(int)textSize bkgColor:(UIColor*)color inView:(UIView*)view;
+(UIImageView*)getPngImageForName:(NSString*)name withFrame:(CGRect)frame;


@end
