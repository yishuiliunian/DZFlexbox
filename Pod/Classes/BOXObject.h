//
//  BOXObject.h
//  Pods
//
//  Created by stonedong on 16/4/4.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface BOXObject : NSObject
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat adjustHeight;
@property (nonatomic, assign) CGFloat adjustWidth;
@property (nonatomic, assign) CGSize adjustContentSize;
@property (nonatomic, assign) UIEdgeInsets insets;
@property (nonatomic, assign, readonly) CGSize contentSize;
@end
