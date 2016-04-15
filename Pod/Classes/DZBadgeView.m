//
//  DZBadgeView.m
//  K12
//
//  Created by stonedong on 16/4/11.
//  Copyright © 2016年 stonedong. All rights reserved.
//

#import "DZBadgeView.h"
#import "DZGeometryTools.h"
@interface DZBadgeView()
{
    CAShapeLayer* _roundLayer;
    CATextLayer* _textLayer;
    CGSize _contentSize;
    
    CGFloat _yMargin;
}
@end


@implementation DZBadgeView

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return self;
    }
    _roundLayer = [CAShapeLayer new];
    _textLayer = [CATextLayer new];
    _textLayer.contentsScale = [UIScreen mainScreen].scale;
    _maxWidth = CGFLOAT_MAX;
    _alignment = NSTextAlignmentCenter;
    [self setTextColor:[UIColor whiteColor]];
    [self setTextFont:[UIFont systemFontOfSize:16]];
    [self setBadgeColor:[UIColor redColor]];

    [self.layer addSublayer:_roundLayer];
    [self.layer addSublayer:_textLayer];
    _shrinkToBoundsHeight = YES;
    _yMargin = 0;
    _maxWidth = 0;
    return self;
}

- (void) setText:(NSString *)text
{
    if (![_text isEqualToString:text]) {
        _text = text;
        _textLayer.string = _text;
        [self updateBadgeFrame];
    }
}
- (void) setBadgeColor:(UIColor *)badgeColor
{
    if (_badgeColor != badgeColor) {
        _roundLayer.backgroundColor = badgeColor.CGColor;
        _badgeColor = badgeColor;
        [_roundLayer setNeedsDisplay];
    }
}

- (void) setTextColor:(UIColor *)textColor
{
    if (_textColor != textColor) {
        _textColor = textColor;
        _textLayer.foregroundColor = textColor.CGColor;
    }
}

- (void) setTextFont:(UIFont *)textFont
{
    if (textFont != _textFont) {
        _textFont = textFont;
        _textLayer.font = (__bridge CFTypeRef _Nullable)(_textFont);
        _textLayer.fontSize = _textFont.pointSize;
    }
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    if (CGSizeEqualToSize(_contentSize, CGSizeZero)) {
        [self calTextSize];
    }
    if (ABS(_maxWidth - 0.001) < 1) {
        _maxWidth= CGRectGetWidth(self.bounds);
    }
    
    CGRect contentRect;
    contentRect.origin.y = 0;

    if (_shrinkToBoundsHeight) {
        _contentSize.width = MIN(_contentSize.width, _maxWidth);
        contentRect.size.width = _contentSize.width;
        contentRect.size.height =_contentSize.height;
    } else {
        contentRect.size.height = self.bounds.size.height;
        CGFloat width = _contentSize.width - _contentSize.height;
        width += CGRectGetHeight(contentRect);
        contentRect.size.width = MIN(width, _maxWidth);
    }

    switch (_alignment) {
        case NSTextAlignmentLeft:
        {
            contentRect.origin.x = 0;
        }
            break;
        case NSTextAlignmentCenter:
        {
            contentRect.origin.x = (CGRectGetWidth(self.bounds) - _contentSize.width)/2;
        }
            break;
            
        case NSTextAlignmentRight:
        {
            contentRect.origin.x = CGRectGetWidth(self.bounds) - _contentSize.width;
            break;
        }
        default:
            break;
    }
    _roundLayer.frame = contentRect;
    _roundLayer.cornerRadius = CGRectGetHeight(contentRect)/2;
    CGRect textRect = CGRectCenterSubSize(contentRect, CGSizeMake(_roundLayer.cornerRadius*2, CGRectGetHeight(contentRect) - _contentSize.height));
    _textLayer.frame = textRect;
}

- (void) calTextSize
{
    _contentSize = [_text sizeWithFont:_textFont constrainedToSize:CGSizeMake(CGFLOAT_MAX, _textFont.pointSize)];
    _contentSize.height += _yMargin*2;
    _contentSize.width += _contentSize.height;
}

- (void) updateBadgeFrame
{
    [self calTextSize];
    [self setNeedsLayout];
}



@end
