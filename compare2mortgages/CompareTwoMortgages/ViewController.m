//
//  ViewController.m
//  CompareTwoMortgages
//
//  Created by Andreas on 5/20/15.
//  Copyright (c) 2015 Andreas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
    //NSLog(@"HALLLOOO");
    

    firstAdBanner.delegate = self;
    firstAdBanner.hidden   = YES;
    
    
    if(viewControllerLoaded == false)
    {
   
        
        viewControllerLoaded = true;
        
        
    	mortgageFirst  = [[MortgageCalculate alloc] init];
    	mortgageSecond = [[MortgageCalculate alloc] init];
    
        
        [mortgageFirst  setTotalAmount:[[NSNumber alloc] initWithDouble:100000.0]];
        [mortgageSecond setTotalAmount:[[NSNumber alloc] initWithDouble:100000.0]];
        
        
        [mortgageFirst  setPrincipal : [[NSNumber alloc] initWithDouble:100000.0]];
        [mortgageSecond setPrincipal : [[NSNumber alloc] initWithDouble:100000.0]];
        
        ///  timeUnit
        [mortgageFirst   setTimeUnit:0];
        [mortgageSecond  setTimeUnit:0];
        
        
        /// timeSteps
        [mortgageFirst   setTimeSteps: [[NSNumber alloc] initWithDouble: 30.0]];
        [mortgageSecond  setTimeSteps: [[NSNumber alloc] initWithDouble: 30.0]];
        
        
        
        [mortgageFirst   setInterestPercent:[[NSNumber alloc] initWithDouble: 4.5]];
        [mortgageSecond  setInterestPercent:[[NSNumber alloc] initWithDouble: 3.5]];
        
        
        [mortgageFirst   setDownPayUnit:1];
        [mortgageSecond  setDownPayUnit:1];
        
        [mortgageFirst   setDownPayment:[[NSNumber alloc] initWithDouble:100.00]];
        [mortgageSecond  setDownPayment:[[NSNumber alloc] initWithDouble:900.00]];
        
        
        
        [mortgageFirst   setPointUnit:0];
        [mortgageSecond  setPointUnit:0];
       
        //pointPayment
        
        [mortgageFirst   setPointPayment:[[NSNumber alloc] initWithDouble:2.00]];
        [mortgageSecond  setPointPayment:[[NSNumber alloc] initWithDouble:1.00]];
        
        
        
        // afterValue
        
        [mortgageFirst   setAfterValue: 29];
        [mortgageSecond  setAfterValue: 29];

        
        
        
    }
    // else
    // {
       // NSLog(@"do nothing");
        
       // NSLog(@"principal is : %@", [mortgageFirst principal]);
    
    [self firstTrigger];   // new
    [self secondTrigger];  // new 
    
        [self setAllGuiValues];
    
    
    
    // }
    
}



-(void) setMortgageFirst  :(MortgageCalculate*) f
{
   // NSLog(@"in setMortgageFirst");
    
    mortgageFirst = f;
}


-(void) setMortgageSecond :(MortgageCalculate*) s
{
    mortgageSecond = s;
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)getNSIntegerFromSender:(id)sender
{
    UITextField* p;
    p = (UITextField*)sender;
    
    NSString* pr;
    pr = [p text];
 
    NSInteger x;
    x = [pr integerValue];
    
    return x;
    
    
    
}


-(NSNumber*)getNSNumberFromSender:(id)sender
{
    UITextField* p;
    p = (UITextField*)sender;
    
    NSString* pr;
    pr = [p text];
    
    double x;
    x = [pr doubleValue];
    
    NSNumber* prin;
    prin = [[NSNumber alloc] initWithDouble:x];
    return prin;
    
}





- (IBAction)tapOnBackground:(id)sender
{

    [self dismissKeyboard];
    
    [self firstTrigger];
    [self secondTrigger];

    
}


-(void)dismissKeyboard
{
  	[totalAmountTextField resignFirstResponder];
  	[firstTimeSteps resignFirstResponder];
  	[secondTimeSteps resignFirstResponder];
  	[firstPercentField resignFirstResponder];
  	[secondPercentField resignFirstResponder];
    [firstDownPayValue resignFirstResponder];
    [secondDownPayValue resignFirstResponder];
    [firstPointValue resignFirstResponder];
    [secondPointValue resignFirstResponder];
    [afterTimesField  resignFirstResponder];
}








- (IBAction)totalValueChangedE:(id)sender {


    
    [mortgageFirst  setTotalAmount : [self getNSNumberFromSender:sender]];
    [mortgageSecond setTotalAmount : [self getNSNumberFromSender:sender]];
    
    [self firstTrigger];
    [self secondTrigger];
    
}






- (IBAction)timeUnitChanged:(id)sender
{
    
    UISegmentedControl* uis;
    
    uis = (UISegmentedControl*) sender;
    
    
    
    [mortgageFirst  setInterestUnit:[uis selectedSegmentIndex] withChange:true];
    
    [mortgageSecond setInterestUnit:[uis selectedSegmentIndex] withChange:true];
    
    
    
    [mortgageFirst  setTimeUnit: [uis selectedSegmentIndex] withChange : true];
    
    [mortgageSecond setTimeUnit: [uis selectedSegmentIndex] withChange : true];
    
    
    [self firstInterestChanged];
    [self secondInterestChanged];
    
    [self firstTimeUnitChanged];
    [self secondTimeUnitChanged];
    
    [self firstTrigger];
    [self secondTrigger];
    
    [self setTimeUnits];
    
    
    
}


// ------------ //


- (IBAction)firstTimeChanged:(id)sender
{

    double temp;
    NSNumber* tnum;
    temp = [[self getNSNumberFromSender:sender] doubleValue];
    if(temp <= 0.0)
    {
        temp = 1.0;
    }
    
    tnum = [[NSNumber alloc] initWithDouble: temp];
    
    // NSLog(@"<><><><><>>><>><><><>< ><> >< >< ><><><<> <> <>>< %@", tnum);
    
    
    [mortgageFirst setTimeSteps: tnum];
    
    
    [self firstTrigger];

}



- (IBAction)secondTimeChanged:(id)sender
{
    double temp;
    NSNumber* tnum;
    temp = [[self getNSNumberFromSender:sender] doubleValue];
    if(temp <= 0.0)
    {
        temp = 1.0;
    }
    
    tnum = [[NSNumber alloc] initWithDouble: temp];
    
    [mortgageSecond setTimeSteps: tnum];

    [self secondTrigger];
}




- (IBAction)firstPercentChanged:(id)sender {


    [mortgageFirst setInterestPercent: [self
        getNSNumberFromSender:sender]];

    
    [self firstTrigger];
    
}


- (IBAction)secondPercentChanged:(id)sender
{


    [mortgageSecond setInterestPercent :
     [self getNSNumberFromSender:sender]];

    [self secondTrigger];
}



//----- //

- (IBAction)downPaySelect:(id)sender
{

    
    UISegmentedControl* uis;
    
    uis = (UISegmentedControl*) sender;
    
    [mortgageFirst  setDownPayUnit: [uis selectedSegmentIndex] withChange : true];
    [mortgageSecond setDownPayUnit: [uis selectedSegmentIndex] withChange : true];

    
    [self firstDownpayChanged];
    [self secondDownpayChanged];

}



- (IBAction)firstDownpay:(id)sender
{
 

    [mortgageFirst setDownPayment : [self
       getNSNumberFromSender:sender]];

    [self firstTrigger];

}

- (IBAction)secondDownPay:(id)sender
{


    [mortgageSecond setDownPayment : [self
        getNSNumberFromSender:sender]];
    
    [self secondTrigger];

}

// ----- ///

- (IBAction)pointsSelect:(id)sender
{

    UISegmentedControl* uis;
    
    uis = (UISegmentedControl*) sender;

    [mortgageFirst  setPointUnit: [uis selectedSegmentIndex] withChange: true];
    [mortgageSecond setPointUnit: [uis selectedSegmentIndex] withChange: true];

    [self firstPointsChanged];
    [self secondPointsChanged];
    
}




- (IBAction)firstPoints:(id)sender {

    
    [mortgageFirst setPointPayment : [self
        getNSNumberFromSender:sender]];
    
    [self firstTrigger];
}



- (IBAction)secondPoints:(id)sender
{

    
    [mortgageSecond setPointPayment : [self
        getNSNumberFromSender:sender]];
    
    [self secondTrigger];
}


/// result ////





// ----- ////


- (IBAction)afterField:(id)sender
{
    

    [mortgageFirst setAfterValue : [self
        getNSIntegerFromSender:sender]];

    
    
    [mortgageSecond setAfterValue : [self
        getNSIntegerFromSender: sender]];
    
    
    [self firstTrigger];
    [self secondTrigger];

}




//------output   ////

-(void)firstTimeUnitChanged
{
   
    NSNumber* ts0;
    ts0 = [mortgageFirst timeSteps];
    
    
    NSString* str0;
    str0 = [NSString stringWithFormat: @"%.02f", [ts0 doubleValue]];
    
    firstTimeSteps.text = str0;
    
    
}


-(void)secondTimeUnitChanged
{
    
    NSNumber* ts0;
    ts0 = [mortgageSecond timeSteps];
    
    
    NSString* str0;
    str0 = [NSString stringWithFormat: @"%.02f", [ts0 doubleValue]];
    
    secondTimeSteps.text = str0;
    
    
}


/// -------- ////


-(void)firstDownpayChanged
{
    
    NSNumber* ts0;
    ts0 = [mortgageFirst downPayment];
    
    
    NSString* str0;
    str0 = [NSString stringWithFormat: @"%.02f", [ts0 doubleValue]];
    
    firstDownPayValue.text = str0;
    
    
}

-(void)secondDownpayChanged
{
    
    NSNumber* ts0;
    ts0 = [mortgageSecond downPayment];
    
    
    NSString* str0;
    str0 = [NSString stringWithFormat: @"%.02f", [ts0 doubleValue]];
    
    secondDownPayValue.text = str0;
    
    
}



- (void)firstInterestChanged
{
    
    
    NSNumber* ts0;
    ts0 = [mortgageFirst interestPercent];
    
    
    NSString* str0;
    str0 = [NSString stringWithFormat: @"%.02f", [ts0 doubleValue]];
    
    firstPercentField.text = str0;
    
}


-(void) secondInterestChanged
{
    
    NSNumber* ts1;
    ts1 = [mortgageSecond interestPercent];
    
    
    NSString* str1;
    str1 = [NSString stringWithFormat: @"%.02f", [ts1 doubleValue]];
    
    secondPercentField.text = str1;
    
    
}




-(void)firstPointsChanged
{
    NSNumber* ts0;
    ts0 = [mortgageFirst pointPayment];
    
    
    NSString* str0;
    str0 = [NSString stringWithFormat: @"%.02f", [ts0 doubleValue]];
    
    firstPointValue.text = str0;

}

-(void)secondPointsChanged
{
    NSNumber* ts0;
    ts0 = [mortgageSecond pointPayment];
    
    
    NSString* str0;
    str0 = [NSString stringWithFormat: @"%.02f", [ts0 doubleValue]];
    
    
    secondPointValue.text = str0;

}








-(void)firstTrigger
{
    
    
    NSNumber* ci;
    
    [mortgageFirst calculateAll]; 
    
    ci = [mortgageFirst paymentPerUnit];
    
    NSString* label;
    label = [NSString stringWithFormat:@"%.02f", [ci doubleValue]];
    
    firstPayment.text = label;
    
    
    NSNumber* pr;
    pr = [mortgageFirst balanceAfterUnits];
    
    NSString *label2;
    label2   = [NSString stringWithFormat:@"%.02f", [pr doubleValue]];
    firstPrincipal.text = label2;
    
    
    
    NSNumber* f1;
    f1 = [mortgageFirst principal];
    
    NSString *fff1;
    fff1     = [NSString stringWithFormat:@"%.02f", [f1 doubleValue]];
    firstFinancedField.text = fff1;
    

    
    totalInterestALabel.text = [NSString stringWithFormat:@"%.02f", [[mortgageFirst totalInterestPaid] doubleValue]];

    
    totalPaymentALabel.text = [NSString stringWithFormat:@"%.02f", [[mortgageFirst totalAmountPaid] doubleValue]];

    
    
    
    
}


-(void)secondTrigger
{
    NSNumber* ci;
    [mortgageSecond calculateAll];
    
    ci = [mortgageSecond paymentPerUnit];
    
    NSString* label;
    label = [NSString stringWithFormat:@"%.02f", [ci doubleValue]];
    
    secondPayment.text = label;
    
    NSNumber* pr;
    pr = [mortgageSecond balanceAfterUnits];
    
    NSString *label2;
    label2   = [NSString stringWithFormat:@"%.02f", [pr doubleValue]];
    secondPrincipal.text = label2;
    
    
    NSNumber* f2;
    f2 = [mortgageSecond principal];
    
    NSString *fff2;
    fff2     = [NSString stringWithFormat:@"%.02f", [f2 doubleValue]];
    
    secondFinancedField.text = fff2; 
    
    
    totalInterestBLabel.text = [NSString stringWithFormat:@"%.02f", [[mortgageSecond totalInterestPaid] doubleValue]];

    totalPaymentBLabel.text = [NSString stringWithFormat:@"%.02f", [[mortgageSecond totalAmountPaid] doubleValue]];
    
    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    // gotoResultSegue
    
    // NSLog(@"In the Seque !!!!!! >>>>>> >>>> >> >> >>>> >>> >> > ");
    
    
    if([[segue identifier] isEqualToString:@"gotoResultSegue"] ||
       [[segue identifier] isEqualToString:@"swipeLeftSegue"])
    {
        
    
    	ResultViewController *rv = [segue destinationViewController];
    
        [rv setMortgageFirst : mortgageFirst];
        [rv setMortgageSecond: mortgageSecond];
        
        // [rv setAddBanner: firstAdBanner ];
        
    }
    
    // Pass the selected object to the new view controller.
}


-(void)setAllGuiValues
{
    
    
    totalAmountTextField.text = [NSString stringWithFormat:@"%.02f", [[mortgageFirst totalAmount] doubleValue]] ;
    
    
    firstFinancedField.text = [NSString stringWithFormat: @"%.02f",  [[mortgageFirst principal] doubleValue	]];
    
    secondFinancedField.text = [NSString stringWithFormat: @"%.02f", [[mortgageSecond principal] doubleValue ]];
    
    
    
    [timeUnitField setSelectedSegmentIndex:[mortgageFirst timeUnit]];
    
    
    firstTimeSteps.text  = [NSString stringWithFormat:@"%.02f", [[mortgageFirst timeSteps] doubleValue]];
    
    secondTimeSteps.text = [NSString stringWithFormat:@"%.02f", [[mortgageSecond timeSteps] doubleValue]];
    

    firstPercentField.text  = [NSString stringWithFormat:@"%.02f", [[mortgageFirst interestPercent] doubleValue]];
    secondPercentField.text = [NSString stringWithFormat:@"%.02f", [[mortgageSecond interestPercent] doubleValue]];
    
    
    
   
    [downPayUnitField setSelectedSegmentIndex:[mortgageFirst downPayUnit]];
    
    firstDownPayValue.text = [NSString stringWithFormat: @"%.02f", [[mortgageFirst downPayment] doubleValue]];
    
    secondDownPayValue.text = [NSString stringWithFormat: @"%.02f", [[mortgageSecond downPayment] doubleValue]];
    
    
    
    [pointUnitField setSelectedSegmentIndex:[mortgageFirst pointUnit]];
    
    firstPointValue.text = [NSString stringWithFormat: @"%.02f",[[mortgageFirst pointPayment] doubleValue]];
    
    secondPointValue.text = [NSString stringWithFormat: @"%.02f",[[mortgageSecond pointPayment] doubleValue]];
    
    
    
    firstPayment.text   = [NSString stringWithFormat: @"%.02f",[[mortgageFirst paymentPerUnit] doubleValue]];
    
    
    secondPayment.text  = [NSString stringWithFormat: @"%.02f",[[mortgageSecond paymentPerUnit] doubleValue]];
    
    afterTimesField.text = [NSString stringWithFormat: @"%ld",(long)[mortgageFirst afterValue]];
    
    firstPrincipal.text = [NSString stringWithFormat: @"%.02f",[[mortgageFirst balanceAfterUnits] doubleValue]];
    
    secondPrincipal.text = [NSString stringWithFormat: @"%.02f",[[mortgageSecond balanceAfterUnits] doubleValue]];
    
    
    totalInterestALabel.text = [NSString stringWithFormat:@"%.02f", [[mortgageFirst totalInterestPaid] doubleValue]];
    
    totalInterestBLabel.text = [NSString stringWithFormat:@"%.02f", [[mortgageSecond totalInterestPaid] doubleValue]];
    
    totalPaymentALabel.text = [NSString stringWithFormat:@"%.02f", [[mortgageFirst totalAmountPaid] doubleValue]];
    
    totalPaymentBLabel.text = [NSString stringWithFormat:@"%.02f", [[mortgageSecond totalAmountPaid] doubleValue]];
    
    
    
    
    [self setTimeUnits];


}



-(void) setTimeUnits
{
  
    if([mortgageFirst timeUnit] == 0)
    {
        interestLabel.text = @"Interest per year";
        unitALabel.text =  @"Years" ;
        unitBLabel.text =  @"Payment per year";
    }
    else if([mortgageFirst timeUnit] == 1)
    {
        interestLabel.text = @"Interest per month";
        unitALabel.text = @"Months" ;
        unitBLabel.text = @"Payment per month";
    }
    else if([mortgageFirst timeUnit] == 2)
    {
        interestLabel.text = @"Interest per week";
        unitALabel.text = @"Weeks" ;
        unitBLabel.text = @"Payment per week";
    }
    else if([mortgageFirst timeUnit] == 3)
    {
        interestLabel.text = @"Interest per payment";
        unitALabel.text = @"Payments";
        unitBLabel.text = @"Payment 2X per month";
    }
    else if([mortgageFirst timeUnit] == 4)
    {
        interestLabel.text = @"Interest per payment";
        unitALabel.text = @"Payments";
        unitBLabel.text = @"Payment every other week";
    }
    
    
}


-(void)setAddBanner:(ADBannerView*) ba
{
    firstAdBanner = ba;
}



- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    
    firstAdBanner.hidden = NO;
    //NSLog(@"Banner is loaded1 ");
    
}



-(void)viewDidAppear:(BOOL)animated
{
   	//NSLog(@"BANNER APPEARED1");
    
    
    
    if(firstAdBanner.isBannerLoaded == YES)
    {
        //NSLog(@"isbannerLoaded? ");
    	firstAdBanner.hidden = NO;
    }
    
    [super viewDidAppear:animated];
}


- (void) viewWillDisappear:(BOOL)animated
{
    //NSLog(@"ok try disappear ");
    
    [firstAdBanner removeFromSuperview];
    firstAdBanner.delegate = nil;
    firstAdBanner = nil;
    
    [super viewWillDisappear:animated];
    
}


-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    firstAdBanner.hidden = YES;
    // NSLog(@"did fail to load1");
}


-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    
    //NSLog(@"view action bshould begin1");
    return YES;
}


@end
