//
//  DZBadgeView.h
//  K12
//
//  Created by stonedong on 16/4/11.
//  Copyright © 2016年 stonedong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZBadgeView : UIView
@property (nonatomic, strong) NSString* text;
@property (nonatomic, assign) CGFloat maxWidth;
@property (nonatomic, assign) NSTextAlignment alignment;
@property (nonatomic, strong) UIColor* textColor;
@property (nonatomic, strong) UIFont* textFont;
@property (nonatomic, strong) UIColor* badgeColor;
@end
