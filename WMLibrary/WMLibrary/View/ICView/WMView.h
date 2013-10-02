//
//  ICView.h
//  iCoffeeLibrary
//
//  Created by Shengzhe Chen on 8/4/13.
//  Copyright (c) 2013 iCoffee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMView : UIView

@property (nonatomic, strong) id delegate;

- (id)initWithFrame:(CGRect)frame
           delegate:(id)delegate;


@end
