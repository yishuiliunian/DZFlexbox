//
//  BOXUtilities.h
//  Pods
//
//  Created by stonedong on 16/4/4.
//
//

#import <Foundation/Foundation.h>


#define BOXFloatIsEqual(x, y) (ABS(x-y) < 0.0001)
#define BOXFloatIsZero(x) BOXFloatIsEqual(x, 0)