//
//  FindPaymentsClass.h
//  CompareTwoMortgages
//
//  Created by Andreas on 5/23/15.
//  Copyright (c) 2015 Andreas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindPaymentsClass : NSObject


// berechnet wielange man zahlen muss bis auf null runter //


@property  NSNumber* anzahlPayments;
@property  NSNumber* thePayment;
@property  bool      paymentTooLow;



-(double)calculateUnitsFromPrincipal :(double)principal payment : (double) payment interest :(double) interest goal :(double) goal what:(bool) what;

-(double)calculatePaymentFromUnits : (double) goalUnits principal : (double) principal interest :(double) interest;

-(NSMutableArray*) resultArray :(double)principal payment : (double) payment interest :(double) interest numberPayments :(int) goalUnits what : (bool) what;



@end
