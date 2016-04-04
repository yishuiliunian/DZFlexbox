//
//  BOXContainer.h
//  Pods
//
//  Created by stonedong on 16/4/4.
//
//

#import "BOXObject.h"

@class BOXObject;
typedef NS_ENUM(NSInteger, BOXAxis) {
    BOXAxisVertical,
    BoxAxisHorizontal
};

@interface BOXContainer : BOXObject
@property (nonatomic, assign) BOXAxis chiefAxis;
@property (nonatomic, strong, readonly) NSArray* items;
- (instancetype) initWithItems:(NSArray*)items;
- (void) replaceItems:(NSArray*)items;
- (void) addItem:(BOXObject*)item;
- (void) removeItem:(BOXObject*)item;
- (void) adjust;
@end
