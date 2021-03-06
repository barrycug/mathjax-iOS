//
//  Vec2.h
//  eBook
//
//  Created by Dan Lynch on 4/12/11.
//  Copyright 2011 Pyramation Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vec2 : NSObject {
    CGPoint a;
    CGPoint b;
}

- (id)initWithPointsA:(CGPoint)aa B:(CGPoint)bb;
- (float) angle;
- (void) draw : (CGContextRef) context;
- (void) drawComponents : (CGContextRef) context;
- (void) drawTrigComponents : (CGContextRef) context;
- (void) drawArrow : (CGContextRef) context;
- (void) drawVector : (CGContextRef) context;
- (void) drawDot:(CGContextRef) context;

@property (nonatomic, assign) CGPoint a;
@property (nonatomic, assign) CGPoint b;

@end
