//
//  AFMultiGraph.h
//  GraphLibrary
//
//  Created by Andreas on 5/13/15.
//  Copyright (c) 2015 Andreas. All rights reserved.
//

#import <UIKit/UIKit.h>



IB_DESIGNABLE


@interface AFMultiGraph : UIView


{
    
    NSMutableArray *xLabels;
    
    NSMutableArray *aValues;  /// first set of values
    
    NSMutableArray *bValues;  /// second set of values
    
}



- (id)initWithFrame:(CGRect)theFrame;
- (id)initWithCoder:(NSCoder*)coder;


@property (nonatomic) IBInspectable UIColor *fillColor;

@property (nonatomic) IBInspectable UIColor *textColor;

@property (nonatomic) IBInspectable UIColor *xColor;

@property (nonatomic) IBInspectable UIColor *yColor;


@property (nonatomic) IBInspectable UIColor *lineColor0;

@property (nonatomic) IBInspectable UIColor *lineColor1;

@property (nonatomic) IBInspectable UIColor *verticalColor0;

@property (nonatomic) IBInspectable UIColor *verticalColor1;



@property (nonatomic) IBInspectable NSInteger fSize;

@property (nonatomic) IBInspectable NSInteger lineWidth;

@property (nonatomic) IBInspectable CGFloat   xoffset;

@property (nonatomic) IBInspectable CGFloat   xShift;

@property (nonatomic) IBInspectable CGFloat   yoffset;

// the absolute width in x direction
@property (nonatomic) IBInspectable CGFloat xWidthMult;
@property (nonatomic) CGFloat xWidth;


// @property float xWidth;
// the hight of the box in y dirction
@property (nonatomic) IBInspectable CGFloat yHightMult;
@property (nonatomic) CGFloat yHight;


// the maximum value in Y direction
// the idea is that this fills the room
@property (nonatomic) IBInspectable CGFloat maxYValue;

@property (nonatomic) IBInspectable CGFloat stepSize;

@property (nonatomic) IBInspectable  NSInteger xsteps;



// An action that triggers showing the view.
- (void)somethingChanged;


-(void)setXLabels: (NSMutableArray*) x;
-(void)setaValues: (NSMutableArray*) y;
-(void)setbValues: (NSMutableArray*) b; 


// sets parameters automatically based on data
// overwrites data given through xcode gui

-(void)autoSize : (bool) yes;



-(void)extendaValues: (NSMutableArray*) y extend : (int)n with : (bool) last;
-(void)extendbValues: (NSMutableArray*) y extend : (int)n with : (bool) last;


-(void)initDefault;


-(void) drawXAxis;
-(void) drawYAxis;
-(void) drawBars;

// takes xValues and yValues

-(void) drawLines : (NSMutableArray*) aval; 

-(void) drawBar: (float) xpos  value : (float) ypos;
-(void) drawXText: (NSString*) txt at: (float) xpos;
-(void) drawYText: (NSString*) txt at: (float) ypos;
-(void) drawRect:(CGRect)rect;


@end
