//
//  BOXContainer.m
//  Pods
//
//  Created by stonedong on 16/4/4.
//
//

#import "BOXContainer.h"
#import "BOXUtilities.h"


@implementation BOXContainer
{
    NSMutableArray* _subItems;
}
- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _subItems = [NSMutableArray new];
    _chiefAxis = BoxAxisHorizontal;
    return self;
}
- (instancetype) initWithItems:(NSArray *)items
{
    self = [self init];
    if (!self) {
        return self;
    }
    [_subItems addObjectsFromArray:items];
    return self;
}

- (NSArray*) items
{
    return [_subItems copy];
}

- (void) replaceItems:(NSArray *)items
{
    [_subItems removeAllObjects];
    [_subItems addObjectsFromArray:items];
}

- (void) addItem:(BOXObject *)item
{
    [_subItems addObject:item];
}

- (void) removeItem:(BOXObject *)item
{
    return [_subItems removeObject:item];
}

- (void) layout
{
    if (_chiefAxis == BOXAxisVertical) {
        [self layoutWhenVertical];
    } else
    {
        [self layoutWhenHorizontal];
    }
}
- (void) layoutWhenHorizontal
{
    NSMutableArray* lines = [NSMutableArray new];
    CGFloat lineWidth = 0;
    CGFloat height;
    CGFloat lineHeight = 0;
    void(^InsertLineItem)(BOXObject*) = ^(BOXObject* ob) {
        NSMutableArray* items = lines.lastObject;
        if (!items) {
            [lines addObject:[NSMutableArray new]];
        }
        items = lines.lastObject;
        [items addObject:ob];
    };
    for (int i = 0; i < _subItems.count; i++) {
        BOXObject* object = _subItems[i];
        CGSize contentSize = object.contentSize;
        lineWidth = contentSize.width + lineWidth;
        lineHeight = MAX(lineHeight, contentSize.height);
        if (lineWidth < self.width) {
            InsertLineItem(object);
        } else {
            [lines addObject:[NSMutableArray new]];
            InsertLineItem(object);
            lineWidth = contentSize.width;
            lineHeight = 0;
            height += lineHeight;
        }
    }
    self.adjustHeight = lineHeight;
    self.adjustWidth = self.width;
    
    for (NSArray* line in lines) {
        [self layoutLine:line];
    }
    
}

- (void) layoutLine:(NSArray* )array
{
    NSMutableArray* segments = [NSMutableArray new];
    CGFloat fixWidth = 0;
    int unfixItemCount;
    CGFloat lineHeight = 0;
    for (BOXObject* ob in array) {
        lineHeight = MAX(lineHeight, ob.adjustHeight);
        if (BOXFloatIsZero(ob.adjustWidth)) {
            unfixItemCount++;
            BOXContainer* segment= [segments lastObject];
            if (!segments) {
                [segments addObject:[BOXContainer new]];
            }
            segment = segments.lastObject;
            if (BOXFloatIsZero(segment.adjustWidth)) {
                [segment addItem:ob];
            } else {
                segment = [BOXContainer new];
                [segment addItem:ob];
                [segments addObject:segment];
            }
            
        } else {
            fixWidth += ob.adjustHeight;
            BOXContainer* segment= [segments lastObject];
            if (!segments) {
                [segments addObject:[BOXContainer new]];
            }
            segment = segments.lastObject;
            if (!BOXFloatIsZero(segment.adjustWidth)) {
                segment.adjustWidth += ob.adjustWidth;
                [segment addItem:ob];
            } else {
                segment = [BOXContainer new];
                segment.adjustWidth = ob.adjustWidth;
                [segment addItem:ob];
                [segments addObject:segment];
            }
        }
    }
    CGFloat unfixWidth = 0;
    if (unfixItemCount) {
        unfixWidth = (self.width - fixWidth)/ unfixItemCount;
    }
    
    CGFloat startX = self.x;
    CGFloat startY = self.y;
    for (BOXContainer* container in segments) {
        CGRect rect;
        rect.origin.x = startX;
        rect.origin.y = startY;
        rect.size.height = lineHeight;
        if (BOXFloatIsZero(container.adjustWidth)) {
            rect.size.width = unfixWidth * container.items.count;
            container.frame = rect;
            [container layoustUnfixWidth];
        } else {
            rect.size.width = container.adjustWidth;
            container.frame = rect;
            [container layoutsFixWidth];
        }
        startX += rect.size.width;
    }
}
- (void) layoutsFixWidth
{
    CGFloat startX = self.x;
    CGFloat startY = self.y;
    for (BOXObject* ob  in self.items) {
        CGRect rect;
        rect.origin.x = startX;
        rect.origin.y = startY;
        rect.size.width = ob.adjustWidth;
        rect.size.height = self.height;
        ob.frame = rect;
        startX += ob.adjustWidth;
    }
}

- (void) layoustUnfixWidth
{
    if (self.items.count) {
        CGFloat width = self.width / self.items.count;
        CGFloat startX = self.x;
        CGFloat startY = self.y;
        for (BOXObject* ob  in self.items) {
            CGRect rect;
            rect.origin.x = startX;
            rect.origin.y = startY;
            rect.size.width = width;
            rect.size.height = self.height;
            ob.frame = rect;
            startX += width;
        }
    }
}

- (void) layoutWhenVertical
{
    
}

- (void) adjust
{
    [self layout];
}

@end
