//
//  CopMapView.m
//  BodiTrak
//
//  Created by AnCheng on 9/27/16.
//  Copyright © 2016 AnCheng. All rights reserved.
//

#import "CopMapView.h"

#define kSBHeatRadiusInPoints 6

#define ColorSteps @[@[@(38) ,@(50) ,@(56)] ,@[@(240) ,@(240) ,@(240)] ,@[@(240) ,@(240) ,@(240)] ,@[@(240) ,@(240) ,@(240)] ,@[@(232) ,@(232) ,@(236)] ,@[@(224) ,@(224) ,@(232)] ,\
@[@(216) ,@(216) ,@(228)] ,@[@(208) ,@(208) ,@(224)] ,@[@(200) ,@(200) ,@(220)] ,@[@(192) ,@(192) ,@(224)] ,@[@(184) ,@(184) ,@(228)] , \
@[@(176) ,@(176) ,@(232)] ,@[@(168) ,@(168) ,@(236)] ,@[@(160) ,@(160) ,@(240)] ,@[@(152) ,@(152) ,@(240)] ,@[@(144) ,@(144) ,@(240)] , \
@[@(136) ,@(136) ,@(240)] ,@[@(128) ,@(128) ,@(240)] ,@[@(120) ,@(120) ,@(240)] ,@[@(112) ,@(112) ,@(240)] ,@[@(104) ,@(104) ,@(240)] , \
@[@(96) ,@(96) ,@(240)] ,@[@(88) ,@(88) ,@(240)] ,@[@(80) ,@(80) ,@(240)] ,@[@(72) ,@(72) ,@(240)] ,@[@(64) ,@(64) ,@(240)] , \
@[@(56) ,@(56) ,@(240)] ,@[@(48) ,@(48) ,@(240)] ,@[@(40) ,@(40) ,@(240)] ,@[@(32) ,@(32) ,@(240)] ,@[@(24) ,@(24) ,@(240)] , \
@[@(16) ,@(16) ,@(240)] ,@[@(8) ,@(8) ,@(240)] ,@[@(0) ,@(0) ,@(240)] ,@[@(0) ,@(24) ,@(232)] ,@[@(0) ,@(48) ,@(224)] , \
@[@(0) ,@(72) ,@(216)] ,@[@(0) ,@(96) ,@(208)] ,@[@(0) ,@(120) ,@(200)] ,@[@(0) ,@(112) ,@(192)] ,@[@(0) ,@(104) ,@(184)] , \
@[@(0) ,@(96) ,@(176)] ,@[@(0) ,@(88) ,@(168)] ,@[@(0) ,@(80) ,@(160)] ,@[@(0) ,@(88) ,@(152)] ,@[@(0) ,@(96) ,@(144)] , \
@[@(0) ,@(104) ,@(136)] ,@[@(0) ,@(112) ,@(128)] ,@[@(0) ,@(120) ,@(120)] ,@[@(0) ,@(128) ,@(112)] ,@[@(0) ,@(136) ,@(104)] , \
@[@(0) ,@(144) ,@(96)] ,@[@(0) ,@(152) ,@(88)] ,@[@(0) ,@(160) ,@(80)] ,@[@(0) ,@(168) ,@(72)] ,@[@(0) ,@(176) ,@(64)] , \
@[@(0) ,@(184) ,@(56)] ,@[@(0) ,@(192) ,@(48)] ,@[@(0) ,@(200) ,@(40)] ,@[@(0) ,@(208) ,@(32)] ,@[@(0) ,@(216) ,@(24)] , \
@[@(0) ,@(224) ,@(16)] ,@[@(0) ,@(232) ,@(8)] ,@[@(0) ,@(240) ,@(0)] ,@[@(8) ,@(232) ,@(0)] ,@[@(16) ,@(224) ,@(0)] , \
@[@(24) ,@(216) ,@(0)] ,@[@(32) ,@(208) ,@(0)] ,@[@(40) ,@(200) ,@(0)] ,@[@(48) ,@(192) ,@(0)] ,@[@(56) ,@(184) ,@(0)] , \
@[@(64) ,@(176) ,@(0)] ,@[@(72) ,@(168) ,@(0)] ,@[@(80) ,@(160) ,@(0)] ,@[@(88) ,@(152) ,@(0)] ,@[@(96) ,@(144) ,@(0)] , \
@[@(104) ,@(136) ,@(0)] ,@[@(112) ,@(128) ,@(0)] ,@[@(120) ,@(120) ,@(0)] ,@[@(128) ,@(112) ,@(0)] ,@[@(136) ,@(104) ,@(0)] , \
@[@(144) ,@(96) ,@(0)] ,@[@(152) ,@(88) ,@(0)] ,@[@(160) ,@(80) ,@(0)] ,@[@(168) ,@(74) ,@(10)] ,@[@(176) ,@(68) ,@(20)] , \
@[@(184) ,@(62) ,@(30)] ,@[@(192) ,@(56) ,@(40)] ,@[@(200) ,@(50) ,@(50)] ,@[@(208) ,@(44) ,@(44)] ,@[@(216) ,@(38) ,@(38)] , \
@[@(224) ,@(32) ,@(32)] ,@[@(232) ,@(26) ,@(26)] ,@[@(240) ,@(20) ,@(20)] ,@[@(242) ,@(16) ,@(16)] ,@[@(244) ,@(12) ,@(12)] , \
@[@(246) ,@(8) ,@(8)] ,@[@(248) ,@(4) ,@(4)] ,@[@(250) ,@(0) ,@(0)] ,@[@(250) ,@(0) ,@(0)] ,@[@(250) ,@(0) ,@(0)] ]

@interface CopMapView ()
{
    int middleLead;
    int middleTrail;
    
    int topLeft;
    int bottomLeft;
    int topRight;
    int bottomRight;
    
}

@property (nonatomic, readonly) float *scaleMatrix;
@end

@implementation CopMapView

- (id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        _scaleMatrix = malloc(2 * kSBHeatRadiusInPoints * 2 * kSBHeatRadiusInPoints * sizeof(float));
        [self populateScaleMatrix];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super initWithCoder:aDecoder])
    {
        _scaleMatrix = malloc(2 * kSBHeatRadiusInPoints * 2 * kSBHeatRadiusInPoints * sizeof(float));
        [self populateScaleMatrix];
    }
    
    return self;
}

- (void)populateScaleMatrix
{
    
    for (int i = 0; i < 2 * kSBHeatRadiusInPoints; i++) {
        for (int j = 0; j < 2 * kSBHeatRadiusInPoints; j++) {
            float distance = sqrt((i - kSBHeatRadiusInPoints) * (i - kSBHeatRadiusInPoints) + (j - kSBHeatRadiusInPoints) * (j - kSBHeatRadiusInPoints));
            float scaleFactor = 1 - distance / kSBHeatRadiusInPoints;
            if (scaleFactor < 0) {
                scaleFactor = 0;
            } else {
                scaleFactor = (expf(-distance/10.0) - expf(-kSBHeatRadiusInPoints/10.0)) / expf(0);
            }
            
            _scaleMatrix[j * 2 * kSBHeatRadiusInPoints + i] = scaleFactor;
        }
    }
    
    candidateIndex = -1;
    _traceArr = [NSMutableArray new];
    stillPoint = CGPointMake(0.5, 0.5);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextSetFillColorWithColor(context, [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor);
    //CGContextFillRect(context, rect);
    CGContextClearRect(context, rect);
    
    if (self.matFrame != nil)
    {
        
        /*  draw foot force color plot */
        CGRect newRect = CGRectMake(0, 0, 128, 64);
        int rows = ceil(CGRectGetWidth(newRect));
        int columns = ceil(CGRectGetHeight(newRect));
        int arrayLen = columns * rows;
        
        float zoomScale = CGRectGetWidth(newRect) / (float)_sensor.rows;
 
        // allocate an array matching the screen point size of the rect
        float *pointValues = calloc(arrayLen, sizeof(float));
        
        for (int r = 0 ; r < _sensor.rows ; r++)
        {
            for (int c = 0 ; c < _sensor.columns  ; c++)
            {
                
                for (int i = 0; i < 2 * kSBHeatRadiusInPoints; i++) {
                    for (int j = 0; j < 2 * kSBHeatRadiusInPoints; j++) {
                         
                        // find the array index
                        int row = floor(r * zoomScale - kSBHeatRadiusInPoints + i);
                        int column = floor(c * zoomScale - kSBHeatRadiusInPoints + j);
                        
                        // make sure this is a valid array index
                        if (row >= 0 && column >= 0 && row < rows && column < columns) {
                            int index = rows * column + row;
                            float value = [[_matFrame.values objectAtIndex:(r * _sensor.columns + c)] floatValue];
                            double addVal = value * _scaleMatrix[j * 2 * kSBHeatRadiusInPoints + i];
                            pointValues[index] += addVal;
                        }
                        
                    }
                }
                
            }
        }
        
        uint indexOrigin;
        unsigned char *rgba = (unsigned char *)calloc(arrayLen * 4, sizeof(unsigned char));
        for (int i = 0; i < arrayLen; i++) {
            
            indexOrigin = 4 * i;
            float val = pointValues[i];
            if  (val < 1) val = 0;
            else if (val > 100) val = 100.0f;
            
            NSArray *rgbArr = [ColorSteps objectAtIndex:(int)(val)];
            rgba[indexOrigin] = [rgbArr[0] intValue];
            rgba[indexOrigin+1] = [rgbArr[1]  intValue];
            rgba[indexOrigin+2] = [rgbArr[2]  intValue];

            float alpha = 255.0f; if (val == 0) alpha = 220;
            rgba[indexOrigin+3] = alpha;
        }
                                                                                                                                                                                                                            
        free(pointValues);
        
        CGContextRef context = UIGraphicsGetCurrentContext();

        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef bitmapContext = CGBitmapContextCreate(rgba,
                                                           rows,
                                                           columns,
                                                           8, // bitsPerComponent
                                                           4 * rows, // bytesPerRow
                                                           colorSpace,
                                                           kCGImageAlphaPremultipliedLast | kCGBitmapByteOrderDefault);
        
        
        CGImageRef cgImage = CGBitmapContextCreateImage(bitmapContext);
        UIImage *img = [UIImage imageWithCGImage:cgImage];
        UIImage *flipImg = [UIImage imageWithCGImage:img.CGImage scale:img.scale orientation:UIImageOrientationDownMirrored];
        UIGraphicsPushContext(context);
        [flipImg drawInRect:rect];
        UIGraphicsPopContext();
        CFRelease(cgImage);
        CFRelease(bitmapContext);
        CFRelease(colorSpace);
        free(rgba);
        /*  draw foot force color plot */
        
        /*  calculate ball trace plot */

        currentPoint = CGPointMake(self.matFrame.cop.x, 1 - self.matFrame.cop.y);
        float dx = currentPoint.x - stillPoint.x;
        float dy = currentPoint.y - stillPoint.y;
        float distance = sqrtf(dx * dx + dy * dy) * 28.437;
        if (distance < 2)
        {
            candidateIndex = -1;
        }
        else if (candidateIndex < 0)
        {
            candidateIndex = self.matFrame.frameid;
            candidateTime = self.matFrame.frameTime;
        }
        else
        {
            dx = currentPoint.x - candidatePoint.x;
            dy = currentPoint.y - candidatePoint.y;
            distance = sqrtf(dx * dx + dy * dy) * 28.437;
         
            if (distance >= 2)
            {
                candidateIndex = self.matFrame.frameid;
                candidateTime = self.matFrame.frameTime;
            }
            else if ([self.matFrame.frameTime timeIntervalSinceDate:candidateTime] > 2)
            {
                stillPoint = candidatePoint;
                candidateIndex = -1;
            }
        }
      
        if (candidateIndex == -1) [_traceArr removeAllObjects];
        [_traceArr addObject:[NSValue valueWithCGPoint:currentPoint]];
        
        /*  calculate ball trace plot */

        /*  draw Axis */

        CGContextSetLineWidth(context, 0.5f);
        CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
        CGContextMoveToPoint(context, 0 ,  rect.size.height / 2.0f);
        CGContextAddLineToPoint(context,  rect.size.width,  rect.size.height / 2.0f);
        CGContextMoveToPoint(context, rect.size.width / 2.0f ,  0);
        CGContextAddLineToPoint(context,  rect.size.width / 2.0f,  rect.size.height);
        CGContextStrokePath(context);

        /*  draw Axis */

        /*  draw foot ball trace plot */
        
        if ([_traceArr count] > 2)
        {
            CGContextSetLineWidth(context, 1.0f);
            CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
            for (int i = 0; i < [_traceArr count] - 2; i++) {
                
                CGPoint p1 = [[_traceArr objectAtIndex:i] CGPointValue];
                CGPoint p2 = [[_traceArr objectAtIndex:i + 1]  CGPointValue];
                CGContextMoveToPoint(context, p1.x * rect.size.width, p1.y * rect.size.height);
                CGContextAddLineToPoint(context, p2.x * rect.size.width, p2.y * rect.size.height);
                CGContextStrokePath(context);
            }
            
            CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
            CGContextFillEllipseInRect(context, CGRectMake(currentPoint.x * rect.size.width - 5, currentPoint.y * rect.size.height - 5, 10, 10));
            CGContextFillPath(context);
        }

        /*  draw foot ball trace plot */
        
        /*  draw Distribution and Stance Width */
        
        NSDictionary *attributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:10.0f] ,
                                      NSForegroundColorAttributeName : [UIColor whiteColor]};
        CGRect topleftRect;
        if (topLeft + bottomLeft > 0)
        {
            
            topleftRect = CGRectMake(5, rect.size.height / 2 - 20, 20, 10);
            [[NSString stringWithFormat:@"%.0f" ,(float)topLeft / (float)(topLeft + bottomLeft) * 100.0f] drawInRect:topleftRect withAttributes:attributes];
            topleftRect = CGRectMake(5, rect.size.height / 2 + 10, 20, 10);
            [[NSString stringWithFormat:@"%.0f" ,(float)bottomLeft / (float)(topLeft + bottomLeft) * 100.0f] drawInRect:topleftRect withAttributes:attributes];
        }

        if (topRight + bottomRight > 0)
        {

            topleftRect = CGRectMake(rect.size.width - 25, rect.size.height / 2 - 20 , 20, 10);
            [[NSString stringWithFormat:@"%.0f" ,(float)bottomRight / (float)(topRight + bottomRight) * 100.0f] drawInRect:topleftRect withAttributes:attributes];
            topleftRect = CGRectMake(rect.size.width - 25, rect.size.height / 2 + 10 , 20, 10);
            [[NSString stringWithFormat:@"%.0f" ,(float)topRight / (float)(topRight + bottomRight) * 100.0f] drawInRect:topleftRect withAttributes:attributes];
        }
        
        if (middleLead + middleTrail > 0)
        {

            topleftRect = CGRectMake(rect.size.width / 2 - 30, rect.size.height - 15 , 20, 15);
            [[NSString stringWithFormat:@"%.0f" ,(float)middleLead / (float)(middleLead + middleTrail) * 100.0f] drawInRect:topleftRect withAttributes:attributes];
            topleftRect = CGRectMake(rect.size.width / 2 + 10, rect.size.height - 15 , 20, 15);
            [[NSString stringWithFormat:@"%.0f" ,(float)middleTrail / (float)(middleLead + middleTrail) * 100.0f] drawInRect:topleftRect withAttributes:attributes];
            
        }
        
        /*  draw Distribution and Stance Width */
    }
}
                                                                                                                                                                                                                  
- (void)setMatFrame:(Frame *)frame
{
    _matFrame = frame;
    [self getWeightDistribution:frame];
    [self getStanceWidth:frame];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsDisplay];
    });
}

- (void)getWeightDistribution:(Frame *)frame
{
    float quadrant[4];
    
    int c ,r;
    float rowHeight = _sensor.height /  _sensor.rows;
    float columnWidth = _sensor.width / _sensor.columns;
    
    int leftColumns = (int)(currentPoint.y * _sensor.width/ columnWidth);
    float leftFraction = (currentPoint.y * _sensor.width/ columnWidth) - leftColumns;
    int topRows = (int)(_sensor.height - currentPoint.x * _sensor.height) / rowHeight;
    float topFraction = (_sensor.height - currentPoint.x * _sensor.height) / rowHeight - topRows;
    float total = 0 ,topTotal = 0 , topLeftTotal = 0 , bottomLeftTotal = 0;
    
    for (r = 0 ; r < _sensor.rows ; r ++)
    {
        for (c = 0 ; c < _sensor.columns ; c ++)
        {
            float val = [[frame.values objectAtIndex:(r * _sensor.columns + c)] floatValue];
            if (val > 0.0f){
            
                total += val;
                if (r == topRows)
                {
                    float v1 = val * topFraction;
                    topTotal += v1;
                    if (c == leftColumns)
                    {
                        topLeftTotal += v1 * leftFraction;
                        bottomLeftTotal += (val - v1) * leftFraction;
                    }
                    else if (c < leftColumns)
                    {
                        topLeftTotal += v1;
                        bottomLeftTotal += (val - v1);
                    }
                }
                else if (r < topRows)
                {
                    topTotal += val;
                    if (c<= leftColumns) topLeftTotal += val * leftFraction;
                    else topLeftTotal += val;
                }
                else if (c <= leftColumns)
                {
                    if (c == leftColumns) bottomLeftTotal += val * leftFraction;
                    else
                        bottomLeftTotal += val;
                }
                
            }
        }
    }
    
    if (total == 0)
    {
        int q = 0;
        for (q = 0 ; q < 4 ; q ++)
            quadrant[q] = 0.00f;
    }
    else
    {
        float bottomTotal = total - topTotal;
        quadrant[0] = topLeftTotal / total;
        quadrant[1] = (topTotal - topLeftTotal) / total;
        quadrant[2] = bottomLeftTotal / total;
        quadrant[3] = (bottomTotal - bottomLeftTotal) / total;
    }
    
    topLeft = (int)(quadrant[0] * 100.0f);
    topRight = (int)(quadrant[1] * 100.0f);
    bottomLeft = (int)(quadrant[2] * 100.0f);
    bottomRight = (int)(quadrant[3] * 100.0f);

}

- (void)getStanceWidth:(Frame *)frame
{
    int c ,r;
    int leadMax = 0, leadMin = 100, trailMax = 0, trailMin= 100;
    for (r = 0 ; r < _sensor.rows / 2 ; r ++)
    {
        for (c = 0 ; c < _sensor.columns ; c ++)
        {
            float val = [[frame.values objectAtIndex:(r * _sensor.columns + c)] floatValue];
            
            if (val > 2.5f)
            {
                if (r < leadMin) leadMin = r;
                if (r > leadMax) leadMax = r;
            }
        }
    }

    middleLead =  abs(leadMin - leadMax);
    if (middleLead == 100) middleLead = 0;
    
    for (r = _sensor.rows / 2 ; r < _sensor.rows ; r ++)
    {
        for (c = 0 ; c < _sensor.columns ; c ++)
        {
            float val = [[frame.values objectAtIndex:(r * _sensor.columns + c)] floatValue];
            if (val > 2.5f)
            {
                if (r < trailMin) trailMin = r;
                if (r > trailMax) trailMax = r;
            }
        }
    }

    middleTrail =  abs(trailMin - trailMax);
    if (middleTrail == 100) middleTrail = 0;
}
 
@end
