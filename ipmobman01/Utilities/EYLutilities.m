//
//  EYLutilities.m
//  ipmobman01
//
//  Created by Alex Zabeo on 24/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EYLutilities.h"

@implementation EYLutilities

+(CGRect)getFrameForText:(NSString*)text inLabel:(UILabel*)label maximumSize:(CGSize)maxSize{
       
    CGSize expectedLabelSize = [text sizeWithFont:label.font 
                                      constrainedToSize:maxSize 
                                          lineBreakMode:label.lineBreakMode]; 
    
    //adjust the label the the new height.
    CGRect newFrame = label.frame;
    newFrame.size.width = expectedLabelSize.width;
    //label.frame = newFrame;
    return newFrame;
}

+(void)insertTextLabelWithFrame:(CGRect)frame Text:(NSString*)text textSize:(int)textSize bkgColor:(UIColor*)color inView:(UIView*)view{
    //textSize = 0 means automatic text size
    UILabel* test;
    
    test = [[UILabel alloc] initWithFrame:frame];
    
    test.adjustsFontSizeToFitWidth = YES;
    
    if (textSize!=0) {
        test.font = [UIFont systemFontOfSize:(CGFloat)textSize];
        test.lineBreakMode = UILineBreakModeMiddleTruncation;
        test.numberOfLines=0;
    }
    
    test.text =  (NSString*)text;
    test.textAlignment = UITextAlignmentCenter;
    if (color) {
        test.backgroundColor = color;
    }else {
        test.backgroundColor = [UIColor clearColor];
    }
    
    //test.frame = [EYLutilities getFrameForText:test.text inLabel:test maximumSize:size];
    //test.lineBreakMode = UILineBreakModeWordWrap;
    
    
    [view addSubview:test];
}

+(UIImageView*)getPngImageForName:(NSString*)name withFrame:(CGRect)frame{
    UIImageView *imv = [[UIImageView alloc]initWithFrame:frame];
    
    NSURL* plistURL = [[NSBundle mainBundle] URLForResource:name withExtension:@"png"];
    
    imv.image = [UIImage imageWithContentsOfFile:[plistURL path]];
    return imv;
}


@end
