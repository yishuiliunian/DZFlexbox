//
//  BOXObject.m
//  Pods
//
//  Created by stonedong on 16/4/4.
//
//

#import "BOXObject.h"

@implementation BOXObject

- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _frame = CGRectZero;
    _adjustContentSize = CGSizeZero;
    return self;
}

- (void) setX:(CGFloat)x
{
    _frame.origin.x = x;
}
- (CGFloat) x
{
    return _frame.origin.x;
}

- (void) setY:(CGFloat)y
{
    _frame.origin.y = y;
}

- (CGFloat) y
{
    return _frame.origin.y;
}

- (void) setWidth:(CGFloat)width
{
    _frame.size.width = width;
}

- (CGFloat) width
{
    return _frame.size.width;
}

- (void) setHeight:(CGFloat)height
{
    _frame.size.height= height;
}

- (CGFloat) height
{
    return _frame.size.height;
}

- (void) setAdjustWidth:(CGFloat)adjustWidth
{
    _adjustContentSize.width = adjustWidth;
}

- (CGFloat) adjustWidth
{
    return _adjustContentSize.width;
}

- (void) setAdjustHeight:(CGFloat)adjustHeight
{
    _adjustContentSize.height = adjustHeight;
}

- (CGFloat) adjustHeight
{
    return _adjustContentSize.height;
}

- (CGSize) contentSize
{
    CGSize size;
    size.width = _insets.left + _insets.right + self.adjustWidth;
    size.height = _insets.top + _insets.bottom + self.adjustHeight;
    return size;
}

@end
