//
//  ResultViewController.m
//  CompareTwoMortgages
//
//  Created by Andreas on 5/27/15.
//  Copyright (c) 2015 Andreas. All rights reserved.
//

#import "ResultViewController.h"


@interface ResultViewController ()

@end

@implementation ResultViewController


@synthesize UpperGraph;

@synthesize LowerGraph;


- (void)viewDidLoad
{
    [super viewDidLoad];

    
    _secondAdBanner.delegate = self;
    _secondAdBanner.hidden   = YES;
    
    //NSLog(@"inside v2");
    
    // Do any additional setup after loading the view.

    
    [self generateLabelsAndSettingsUpper : 0];
    [self generateLabelsAndSettingsLower : 0];
    
    if(resultControllerLoaded == false)
    {
        resultControllerLoaded   = true;

    }
    

    
}


- (IBAction)upperGraphSettingChanged:(id)sender
{

    
    UISegmentedControl* uis;
    
    uis = (UISegmentedControl*) sender;
    
    int select;
    select = (int)[uis selectedSegmentIndex];

    [self generateLabelsAndSettingsUpper:select];
    
    [UpperGraph somethingChanged]; 

}


- (IBAction)lowerGraphSettingChanged:(id)sender
{

    UISegmentedControl* uis;
    
    uis = (UISegmentedControl*) sender;
    
    int select;
    select = (int)[uis selectedSegmentIndex];
    
    [self generateLabelsAndSettingsLower:select];
    
    [LowerGraph autoSize:true];
    
    [LowerGraph somethingChanged];
    

}




-(void)generateLabelsAndSettingsUpper : (int) select
{
    
    int inta;
    int intb;
    
    inta = (int)[[mortgageFirst  timeSteps] integerValue];
    intb = (int)[[mortgageSecond timeSteps] integerValue];
    
    // NSLog(@" ,.,.,.,., >>>>> 1 %d %d",inta, intb);
    
    
    
    
    
    if(select == 0)
    {
    
    	if(inta > intb)
    	{
        
        	[UpperGraph setXLabels: [mortgageFirst  xLabel]];
        
        	[UpperGraph setaValues: [mortgageFirst  principalPerUnitOverTime]];
        
        
        	[UpperGraph extendbValues: [mortgageSecond  principalPerUnitOverTime] extend : inta  with : true ] ;
        
            
        
        // interestPerUnitOverTime
        // interestOverTime
        
    	}
    	else
    	{
        
        	// NSLog(@" ,.,.,.,., >>>>> upper 3 ");

        	[UpperGraph setXLabels: [mortgageSecond xLabel]];
        
        	[UpperGraph extendaValues: [mortgageFirst  principalPerUnitOverTime] extend : intb with  : true];
        	[UpperGraph setbValues:    [mortgageSecond principalPerUnitOverTime]];
        

    	}
    }
    
    else if(select == 1)
    {
        [UpperGraph setXLabels:[mortgageFirst xLabel]];
        [UpperGraph setaValues:[mortgageFirst principalPerUnitOverTime]];
        [UpperGraph setbValues:[mortgageFirst interestPerUnitOverTime]];
    }
    
    else if(select == 2)
    {
        [UpperGraph setXLabels:[mortgageSecond xLabel]];
        [UpperGraph setaValues:[mortgageSecond principalPerUnitOverTime]];   /// payment
        [UpperGraph setbValues:[mortgageSecond interestPerUnitOverTime]];
    }
    
    else if(select == 3)
    {
        if(inta > intb)
        {
            
            [UpperGraph setXLabels: [mortgageFirst  xLabel]];
            
            [UpperGraph setaValues: [mortgageFirst  balanceOverTime]];
            
            [UpperGraph extendbValues: [mortgageSecond  balanceOverTime] extend : inta  with : true ] ;
            
            
            // interestPerUnitOverTime
            // interestOverTime
            
        }
        else
        {
            
            // NSLog(@" ,.,.,.,., upper 13 ");
            
            [UpperGraph setXLabels:    [mortgageSecond xLabel]];
            
            [UpperGraph extendaValues: [mortgageFirst  balanceOverTime] extend : intb with  : true];
            [UpperGraph setbValues:    [mortgageSecond balanceOverTime]];
            
            
        }
    }
    
    [UpperGraph autoSize:true];


}


-(void)generateLabelsAndSettingsLower : (int) select
{
    int inta;
    int intb;
    
    inta = (int)[[mortgageFirst  timeSteps] integerValue];
    intb = (int)[[mortgageSecond timeSteps] integerValue];
    
    // NSLog(@" ,.,.,.,., >>>>> 1 %d %d",inta, intb);
    
    if(select == 0)
    {
    
    	if(inta > intb)
    	{
        // n = inta;
        
        [LowerGraph setXLabels: [mortgageFirst  xLabel]];
        
        [LowerGraph setaValues: [mortgageFirst  totalOverTime]];  /// <<<
        
        [LowerGraph extendbValues: [mortgageSecond  totalOverTime] extend : inta with : true];
        
        
        // interestPerUnitOverTime
        // interestOverTime
            // totalOverTime
        
    	}
    	else
    	{
         
        	[LowerGraph setXLabels:    [mortgageSecond xLabel]];
            
            [LowerGraph extendaValues: [mortgageFirst  totalOverTime] extend : intb with : true];
            
        	[LowerGraph setbValues:    [mortgageSecond totalOverTime]];
    
        }
    }
    else if(select == 1)   // total interest
    {
        
        // NSLog(@"here we are %@", [mortgageFirst interestOverTime]);
        
        
        if(inta > intb)
        {
            // n = inta;
            
            [LowerGraph setXLabels: [mortgageFirst  xLabel]];
            [LowerGraph setaValues: [mortgageFirst  interestOverTime]];  /// <<<
            [LowerGraph extendbValues: [mortgageSecond  interestOverTime] extend : inta with : true];
            
            
            // interestPerUnitOverTime
            // interestOverTime
            
        }
        else
        {
            
            // NSLog(@" ,.,.,.,., >>>>> 3 ");
            
            
            [LowerGraph setXLabels:    [mortgageSecond xLabel]];
            [LowerGraph extendaValues: [mortgageFirst  interestOverTime] extend : intb with : true];
            [LowerGraph setbValues:    [mortgageSecond interestOverTime]];
            
        }

        
        
    }
    else if(select == 2)
    {
        
        
        if(inta > intb)
        {
            
            [LowerGraph setXLabels: [mortgageFirst  xLabel]];
            
            [LowerGraph setaValues: [mortgageFirst  interestPerUnitOverTime]];
            
            [LowerGraph extendbValues: [mortgageSecond  interestPerUnitOverTime] extend : inta  with : true ] ;
            
            
            // interestPerUnitOverTime
            // interestOverTime
            
        }
        else
        {
            
            // NSLog(@" ,.,.,.,., upper 13 ");
            
            [LowerGraph setXLabels:    [mortgageSecond xLabel]];
            
            [LowerGraph extendaValues: [mortgageFirst  interestPerUnitOverTime] extend : intb with  : true];
            [LowerGraph setbValues:    [mortgageSecond interestPerUnitOverTime]];
            
            
        }
        
        
        
    }
    
    
        
    [LowerGraph autoSize:true];


}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void) setMortgageFirst  :(MortgageCalculate*) f
{
    
    mortgageFirst = f;
}


-(void) setMortgageSecond :(MortgageCalculate*) s
{
    mortgageSecond = s;
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    // gotoResultSegue
    
    
    if([[segue identifier] isEqualToString:@"gotoInputSegue"] ||
       [[segue identifier] isEqualToString:@"swipeBackSegue"])
    {
        
        
        ViewController *rv = [segue destinationViewController];
        
        [rv setMortgageFirst :mortgageFirst];
        [rv setMortgageSecond:mortgageSecond];
        
        // [rv setAddBanner : _secondAdBanner];
        
    }
    
    // Pass the selected object to the new view controller.
}


// add banner ///



-(void)setAddBanner : (ADBannerView *) ad
{
    _secondAdBanner = ad;
}


- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    
    _secondAdBanner.hidden = NO;
   // NSLog(@"Banner is loaded ");
    
}



-(void)viewDidAppear:(BOOL)animated
{
   //	NSLog(@"BANNER APPEARED");
    
    if(_secondAdBanner.isBannerLoaded == YES)
    {
    //    NSLog(@"isbannerLoaded? ");
        _secondAdBanner.hidden = NO;
    }
    
    [super viewDidAppear:animated];
    
}


- (void) viewWillDisappear:(BOOL)animated
{
  //  NSLog(@"ok try disappear ");
    
    [_secondAdBanner removeFromSuperview];
    _secondAdBanner.delegate = nil;
    _secondAdBanner = nil;
    
    [super viewWillDisappear:animated];
    
}



-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    _secondAdBanner.hidden = YES;
    // NSLog(@"did fail to load");
}


-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    
    //NSLog(@"view action bshould begin");
    return YES;
}






@end
