//
//  AFMultiGraph.m
//  GraphLibrary
//
//  Created by Andreas on 5/13/15.
//  Copyright (c) 2015 Andreas. All rights reserved.
//

#import "AFMultiGraph.h"

@implementation AFMultiGraph


@synthesize xoffset;
@synthesize xShift;   // label text shift 

@synthesize yoffset;
@synthesize xWidthMult;

@synthesize xWidth;

@synthesize yHightMult;
@synthesize yHight;

@synthesize maxYValue;
@synthesize stepSize;

@synthesize xsteps;


- (id)initWithFrame:(CGRect)theFrame {
    self = [super initWithFrame:theFrame];
    if (self) {
        [self initDefault];
    }
    return self;
}


- (id)initWithCoder:(NSCoder*)coder
{
    if ((self = [super initWithCoder:coder])) {
        [self initDefault];
    }
    return self;
}


-(void)initDefault
{
    // xoffset   = 30.0;
    
    // yoffset   = 10.0;
    // xWidth    = 210.0;
    // yHight    = 140.0;  // PHYSICAL SIZE
    // maxYValue = 45.1;   // maximum on y axis
    // stepSize  = 10.0;
    
    
    
    xLabels = [[NSMutableArray alloc] init];
    
    aValues = [[NSMutableArray alloc] init];
    bValues = [[NSMutableArray alloc] init];
    
    
    NSNumber* n0 = [[NSNumber alloc] initWithFloat:30.0];
    NSNumber* n1 = [[NSNumber alloc] initWithFloat:20.0];
    NSNumber* n2 = [[NSNumber alloc] initWithFloat:10.0];
    
    NSString* l0 = @"x";
    NSString* l1 = @"y";
    NSString* l2 = @"z";
    NSString* l3 = @"a";
    
    
    [xLabels addObject:l0];
    [xLabels addObject:l1];
    [xLabels addObject:l2];
    [xLabels addObject:l1];
    [xLabels addObject:l3];
    [xLabels addObject:l0];
    [xLabels addObject:l3];
    [xLabels addObject:l2];
    [xLabels addObject:l3];
    
    
    
    [aValues addObject:n0];
    [aValues addObject:n1];
    [aValues addObject:n2];
    [aValues addObject:n2];
    [aValues addObject:n1];
    [aValues addObject:n0];
    [aValues addObject:n2];
    [aValues addObject:n2];
    [aValues addObject:n2];
    
    
    [bValues addObject:n2];
    [bValues addObject:n1];
    [bValues addObject:n0];
    [bValues addObject:n2];
    [bValues addObject:n1];
    [bValues addObject:n1];
    [bValues addObject:n0];
    [bValues addObject:n1];
    [bValues addObject:n2];
    
    
    
    //_fillColor  = [UIColor redColor];
    //_textColor  = [UIColor blueColor];
    //_lineColor  = [UIColor blackColor];
    
}


-(void)setXLabels:(NSMutableArray *)x
{
    xLabels = x;
}


-(void)setaValues:(NSMutableArray *)y
{
    
    
    //for(int b = 0; b < [y count]; b++)
    //{
    //    [aValues addObject:[y objectAtIndex : b]];
    //}
    
    aValues = y;
}

-(void)setbValues:(NSMutableArray *)b
{
    
    //for(int x = 0; x < [b count]; x++)
    //{
    //    [bValues addObject:[b objectAtIndex : x]];
    //}
    
    bValues = b;
}


-(void)extendaValues: (NSMutableArray*) y extend : (int)n with :(bool) last
{
    aValues = [[NSMutableArray alloc] init];
    
    for(int i = 0; i  < n ; i++)
    {
        
        if( i < [y count] )
        {
        	[aValues addObject : [y objectAtIndex : i]];
        }
        else
        {
            if( last == true)
            {
            	[aValues addObject : [y objectAtIndex : [y count] - 1]];
            }
            else
            {
                NSNumber *t;
                t = [[NSNumber alloc] initWithDouble:0.0];
                [aValues addObject : t];
        	}
        }
    }
}





-(void)extendbValues: (NSMutableArray*) y extend : (int) n with : (bool)last
{
    

	bValues = [[NSMutableArray alloc] init];

	for(int i = 0; i  < n ; i++)
	{
    
    	if( i < [y count] )
    	{
        	[bValues addObject : [y objectAtIndex : i]];
   	 	}
    	else
    	{
        	if( last == true)
        	{
            	[bValues addObject : [y objectAtIndex : [y count] - 1]];
        	}
        	else
        	{
            	NSNumber* t;
            	t = [[NSNumber alloc] initWithDouble:0.0];
            	[bValues addObject : t];
        	}
        }
    }
}



-(void)autoSize : (bool) yes
{
    maxYValue = 0.0;
    
    if(yes == true)
    {
        // find maxYValue
        for(int i = 0; i < [aValues count]; i++)
        {
            
            if(maxYValue < [[aValues objectAtIndex : i] floatValue])
            {
                maxYValue = [[aValues objectAtIndex:i] floatValue];
            }
        }
        
        for (int i = 0; i < [bValues count]; i++)
        {
            if(maxYValue < [[bValues objectAtIndex : i] floatValue])
            {
                maxYValue = [[bValues objectAtIndex:i] floatValue];
            }
        }
    
        /// number of y markers
        
        double sHelp;
        double numLetter;
        numLetter = ceil(log10(maxYValue));
        
        
        sHelp =  pow(10.0,numLetter);
        
        stepSize = sHelp/10.0;
        
        if((maxYValue / stepSize) < 3)
        {
            stepSize = sHelp/ 50.0;
        }
        
        xoffset    = (8 * (numLetter + 1));
        xShift     = (8 * numLetter) + 1;
        xWidthMult =  0.95  - 0.013 * numLetter;
        
        
        /// now we look at the labels ///
        
        xsteps = [xLabels count] / 10.0;
        
        
        
        
    }
    // else do nothing i.e. keep settings
    
    
    
}





-(void) drawXAxis
{
    int   n;
    float step;
    
    
    
    n =  (int)[aValues count];
    
    step = xWidth/n;
    
    // draw straight line
    
    
    [_xColor set];
    
    
    UIBezierPath* xMain = [UIBezierPath bezierPath];
    [xMain moveToPoint:CGPointMake(xoffset, yHight + yoffset)]; // was yoffset
    [xMain addLineToPoint:CGPointMake(xoffset + xWidth, yHight + yoffset)];  // was yOffset
    [xMain stroke];
    
    // ticks
    
    
    
    for(int i = 0; i < n; i = i + (int)xsteps)
    {
        
        [_xColor set];
        
        xMain = [UIBezierPath bezierPath];
        [xMain moveToPoint:CGPointMake(xoffset+step * i + step/2.0 , (yHight + yoffset) + 3)];
        [xMain addLineToPoint:CGPointMake(xoffset+step * i +step/2.0, (yHight + yoffset) - 3)];   // was only yOffset
        [xMain stroke];
        
        
        NSString* txt;
        txt = [xLabels objectAtIndex : i];
        
        float xLabelOffset;
        
        xLabelOffset = 0.0; //  xsteps*step/2.0;
        
        [self drawXText : txt at: xoffset + step * i - xLabelOffset];  /// + step/2.0 ];
        
        
    }
    
    
    
}


-(void) drawYAxis
{
    
    float numStep;
    
    float ystep;
    
    // y direction //
    ystep = stepSize * yHight / maxYValue;
    
    numStep = maxYValue / stepSize;
    
    
    [_yColor set];
    
    
    UIBezierPath* yMain; //  = [UIBezierPath bezierPath];
    
    
    yMain = [UIBezierPath bezierPath];
    
    
    [yMain moveToPoint:CGPointMake(xoffset, (yHight +yoffset))]; // was yoffset
    
    [yMain addLineToPoint:CGPointMake(xoffset, yoffset)];  // was yoffset + yHight
    
    [yMain stroke];
    
    
    // numbers from n here //
    for(int i = 0; i < numStep; i++)
    {
        
        [_yColor set];
        
        yMain = [UIBezierPath bezierPath];
        [yMain moveToPoint:CGPointMake(xoffset -3 , yHight + yoffset - ystep * i   )];
        [yMain addLineToPoint:CGPointMake(xoffset + 3, yHight + yoffset - ystep * i )];
        [yMain stroke];
        
        
        
        NSString* txt;
        txt = [NSString stringWithFormat:@"%i", (int)(stepSize * i)];
        
        [self drawYText : txt at: yHight - ystep * i];
        
        
    }
    
    
    
}



// takes xValues and yValues
-(void) drawLines : (NSMutableArray*) aval
{
    int n;
    float step;
    
    n = (int)[aValues count];
    
    
    step = xWidth/n;
    
    
    
    for(int i = 0; i < n-1; i++)
    {
        float v0 = [[aval objectAtIndex : i]   floatValue];
        float v1 = [[aval objectAtIndex : i+1] floatValue];
        
        
        // now calculate relative to maxValue
        
        float pixv0;
        pixv0 = yHight * v0/ maxYValue;
        
        float pixv1;
        pixv1 = yHight * v1/ maxYValue;
        
        
        [self drawLine : ((i + 0.5) * step) pos1 : (i+1.5)*step value0 : pixv0 value1 : pixv1];
        
        
    }
}


-(void) drawVerticals
{
    int n;
    float step;
    
    n = (int)[aValues count];
    
    
    step = xWidth/n;
    
    
    
    for(int i = 0; i < n; i++)
    {
        float v0 = [[aValues objectAtIndex : i] floatValue];
        float v1 = [[bValues objectAtIndex : i] floatValue];
        
        
        // now calculate relative to maxValue
        
        float pixv0;
        pixv0 = yHight * v0/ maxYValue;
        
        float pixv1;
        pixv1 = yHight * v1/ maxYValue;
        
        if(pixv0 > pixv1)
        {
            [_verticalColor0 set];
        }
        else
        {
            [_verticalColor1 set];
        }
        [self drawLine : ((i + 0.5) * step) pos1 : (i + 0.5)*step value0 : pixv0 value1 : pixv1];
        
        
    }

}




-(void) drawLine: (float) xpos0 pos1 : (float)xpos1 value0 : (float) pixv0 value1 : (float) pixv1
{
    int   n;
    float barWidth;
    
    n =  (int)[xLabels count];
    
    barWidth = (xWidth/n)*0.6; // .9 leaves a little gap
    
    //[_fillColor set];
    
    UIBezierPath* barMain = [UIBezierPath bezierPath];
    
    [barMain moveToPoint:CGPointMake(xoffset + xpos0, yoffset + yHight - pixv0)];
    
   // [barMain addLineToPoint:CGPointMake(xoffset + xpos +0.5*barWidth , yoffset + yHight)];
    
   // [barMain addLineToPoint:CGPointMake(xoffset + xpos +0.5*barWidth , yHight + yoffset - ypos )];
    
    [barMain addLineToPoint:CGPointMake(xoffset + xpos1  , yHight + yoffset - pixv1 )];
    
    [barMain closePath];
    
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Shadow for now we leave it here //
    CGContextSetShadow(context, CGSizeMake(8,8), 4);
    
    [barMain fill];
    
    [barMain stroke];
    
    
}




-(void) drawBars
{
    
    int n;
    float step;
    
    n = (int)[aValues count];
    
    
    step = xWidth/n;
    
    
    
    for(int i = 0; i < n; i++)
    {
        float v = [[aValues objectAtIndex : i] floatValue];
        
        // now calculate relative to maxValue
        
        float pixv;
        pixv = yHight*v/maxYValue;
        
        
        [self drawBar : ((i + 0.5) * step) value : pixv];
        
        
    }
    
}




-(void) drawBar: (float) xpos  value : (float) ypos
{
    
    int   n;
    float barWidth;
    
    n =  (int)[xLabels count];
    
    barWidth = (xWidth/n)*0.6; // .9 leaves a little gap
    
    [_fillColor set];
    
    UIBezierPath* barMain = [UIBezierPath bezierPath];
    
    [barMain moveToPoint:CGPointMake(xoffset + xpos -0.5*barWidth, yoffset + yHight)];
    
    [barMain addLineToPoint:CGPointMake(xoffset + xpos +0.5*barWidth , yoffset + yHight)];
    
    [barMain addLineToPoint:CGPointMake(xoffset + xpos +0.5*barWidth , yHight + yoffset - ypos )];
    
    [barMain addLineToPoint:CGPointMake(xoffset + xpos -0.5*barWidth , yHight + yoffset - ypos )];
    
    [barMain closePath];
    
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Shadow for now we leave it here //
    CGContextSetShadow(context, CGSizeMake(8,8), 4);
    
    [barMain fill];
    
    [barMain stroke];
    
    
    
}




-(void) drawXText: (NSString*) txt at: (float) xpos
{
    
    
    // UIFont *smallFont = [UIFont systemFontOfSize : _fSize];
    CGPoint textPoint = CGPointMake(xpos,yHight + yoffset + 2);
    
    [_textColor set];
    
    
    NSDictionary* dict = @{NSFontAttributeName : [UIFont systemFontOfSize : _fSize]};
    
    [txt drawAtPoint:textPoint withAttributes:dict];
    
//    [txt drawAtPoint: textPoint withFont:smallFont];
    
   
    
}








-(void) drawYText: (NSString*) txt at: (float) ypos
{
    
    
    
    // UIFont *smallFont = [UIFont systemFontOfSize: _fSize];  /// was 8
    CGPoint textPoint = CGPointMake(xoffset - xShift , yoffset + ypos - (_fSize/2) );
    
    
    [_textColor set];
    
    NSDictionary* dict = @{NSFontAttributeName : [UIFont systemFontOfSize : _fSize]};
    
    [txt drawAtPoint:textPoint withAttributes:dict];
    
    
}





- (void)drawRect:(CGRect)rect

{
    
    
    // [self initDefault];
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();  // old
    CGRect  myFrame = self.bounds;       // new
    
    yHight  = self.bounds.size.height  * yHightMult;
    xWidth  = self.bounds.size.width   * xWidthMult;
    
    CGContextSetLineWidth(context, _lineWidth);   // new
    
    CGRectInset(myFrame, 5,5);  // new
    [_fillColor set];        //  ??
    
    UIRectFrame(myFrame);       // new
    
    
    // [self drawBars];
    [_lineColor0 set];
    [self drawLines : aValues];
    
    [_lineColor1 set]; 
    [self drawLines : bValues];
    
    [self drawVerticals];
    
    [self drawXAxis];
    [self drawYAxis];
    
    //    CGContextRestoreGState(context);
    
    
}



-(void)somethingChanged
{
    
    //UISlider * bla;
    //bla = (UISlider*)sender;
    
    
    //NSLog(@"in somethingChanged %f",[bla value]);
    
    //NSNumber* n1 = [[NSNumber alloc] initWithFloat:[bla value]*10.0];
    
    //NSLog(@"in somethingChanged _  %@",n1);
    
    //[aValues replaceObjectAtIndex:1 withObject:n1];
    
    [self setNeedsDisplay];
    
}



@end
