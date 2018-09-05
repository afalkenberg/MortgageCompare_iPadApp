//
//  ResultViewController.h
//  CompareTwoMortgages
//
//  Created by Andreas on 5/27/15.
//  Copyright (c) 2015 Andreas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

#import "MortgageCalculate.h"
#import "ViewController.h"
#import "AFMultiGraph.h"


@interface ResultViewController : UIViewController<ADBannerViewDelegate>

{
   MortgageCalculate* mortgageFirst;
   MortgageCalculate* mortgageSecond;
    
}



-(void) setMortgageFirst  :(MortgageCalculate*) f;
-(void) setMortgageSecond :(MortgageCalculate*) s;



@property (weak, nonatomic) IBOutlet AFMultiGraph *UpperGraph;

@property (weak, nonatomic) IBOutlet AFMultiGraph *LowerGraph;

@property (weak, nonatomic) IBOutlet ADBannerView *secondAdBanner;

-(void) setAddBanner : (ADBannerView *) ad;

@end

static bool resultControllerLoaded = false;


