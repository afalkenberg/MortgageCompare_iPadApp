//
//  ViewController.h
//  CompareTwoMortgages
//
//  Created by Andreas on 5/20/15.
//  Copyright (c) 2015 Andreas. All rights reserved.
//

#import "MortgageCalculate.h"

#import "ResultViewController.h"

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>



@interface ViewController : UIViewController<ADBannerViewDelegate>

{
    
    
    
    MortgageCalculate* mortgageFirst;
    MortgageCalculate* mortgageSecond; 
    
    
    __weak IBOutlet UITextField *totalAmountTextField;
    
    
    __weak IBOutlet UISegmentedControl *timeUnitField;
    
    __weak IBOutlet UITextField *firstTimeSteps;
    
    __weak IBOutlet UITextField *secondTimeSteps;
    
    
    
    __weak IBOutlet UISegmentedControl *interestTimeUnitField;
    
    __weak IBOutlet UITextField *firstPercentField;
    
    __weak IBOutlet UITextField *secondPercentField;
    
    
    
    
    
    __weak IBOutlet UISegmentedControl *downPayUnitField;
    
    __weak IBOutlet UITextField *firstDownPayValue;
    
    __weak IBOutlet UITextField *secondDownPayValue;
    
    
    // pointUnit
    
    
    __weak IBOutlet UISegmentedControl *pointUnitField;
    
    __weak IBOutlet UITextField *firstPointValue;
    
    __weak IBOutlet UITextField *secondPointValue;
    
    // financed amount
    
    
    __weak IBOutlet UILabel *firstFinancedField;
    
    __weak IBOutlet UILabel *secondFinancedField;
    
    
    //
    
    __weak IBOutlet UISegmentedControl *resultUnitField;
    

    __weak IBOutlet UILabel *firstPayment;
    
    
    __weak IBOutlet UILabel *secondPayment;
    
    
    
    __weak IBOutlet UITextField *afterTimesField;
    
    
    __weak IBOutlet UISegmentedControl *afterUnitField;
    
    
    
    __weak IBOutlet UILabel *firstPrincipal;
    
    
    __weak IBOutlet UILabel *secondPrincipal;

    

    
    __weak IBOutlet UILabel *interestLabel;
    
    __weak IBOutlet UILabel *unitALabel;
    
    __weak IBOutlet UILabel *unitBLabel;
    
    
    
    /// total interest
    
    
    __weak IBOutlet UILabel *totalInterestALabel;
    
    
    __weak IBOutlet UILabel *totalInterestBLabel;
    
    
    /// total payment
    
    
    __weak IBOutlet UILabel *totalPaymentALabel;
    

    __weak IBOutlet UILabel *totalPaymentBLabel;


    
    
    /// iAd support ///
    
    
    
    __weak IBOutlet ADBannerView *firstAdBanner;
    bool firstBannerIsVisible;


}


-(void) setMortgageFirst  :(MortgageCalculate*) f;
-(void) setMortgageSecond :(MortgageCalculate*) s;
-(void)setAddBanner:(ADBannerView*) ba;


-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error;



@end

// global static value
static bool viewControllerLoaded = false;


