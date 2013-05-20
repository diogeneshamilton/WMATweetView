#import "WMARecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface WMARecognizer ()
@property (nonatomic) CGFloat moveX;
@property (nonatomic) CGFloat moveY;
@property BOOL drag;
@end

@implementation WMARecognizer

- (void)touchesMoved:(NSSet*) touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    if(self.state == UIGestureRecognizerStateFailed) return;
    CGPoint currentPoint = [[touches anyObject] locationInView:self.view];
    CGPoint prevPoint = [[touches anyObject] previousLocationInView:self.view];
    _moveX += prevPoint.x - currentPoint.x;
    _moveY += prevPoint.y - currentPoint.y;
    if(!_drag) {
        if(abs(_moveY) > abs(_moveX))
            self.state = UIGestureRecognizerStateFailed;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CancelWMATap"
                                                            object:nil];

    }
}

- (void)reset {
    [super reset];
    _drag = NO;
    _moveX = 0;
    _moveY = 0;
}

@end
