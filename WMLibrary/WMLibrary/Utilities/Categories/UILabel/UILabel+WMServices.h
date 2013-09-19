//
//  UILabel+ICServices.h
//  ICLibrary
//
//  Created by Shengzhe Chen on 7/14/13.
//  Copyright (c) 2013 Shengzhe Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICGeometry.h"

// default alignment LEFT, size 13, color BLACK

@interface UILabel (WMServices)

+ (UILabel *)labelWithText:(NSString *)text;
+ (UILabel *)labelWithTextColor:(UIColor *)color;
+ (UILabel *)labelWithTextColor:(UIColor *)color
                      alignment:(NSTextAlignment)alignment;

+ (UILabel *)labelWithText:(NSString *)text
                  font:(UIFont *)font;

+ (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
                  alignment:(NSTextAlignment)alignment;
+ (UILabel *)labelWithFont:(UIFont *)font
                 textColor:(UIColor *)textColor;
+ (UILabel *)labelWithAlignment:(NSTextAlignment)alignment
                           font:(UIFont *)font
                      textColor:(UIColor *)textColor;
+ (UILabel *)labelWithFrame:(CGRect)inputFrame
                       text:(NSString *)text
                  alignment:(NSTextAlignment)alignment
                  textColor:(UIColor *)textColor;
+ (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
                  alignment:(NSTextAlignment)alignment
                       font:(UIFont *)font
                  textColor:(UIColor *)textColor;

- (CGRect)resizeLabelWithMaxWidth:(CGFloat)width;
- (CGRect)resizeLabelWithFixedWith:(CGFloat)width;
- (CGFloat)labelWidthWithMaxWidth:(CGFloat)width;
- (CGFloat)labelHeightWithMaxWidth:(CGFloat)widht;
- (CGSize)labelSizeWithMaxWidth:(CGFloat)width;

@end
