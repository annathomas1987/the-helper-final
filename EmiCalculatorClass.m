//
//  EmiCalculatorClass.m
//  The Helper
//
//  Created by Anna Thomas on 10/11/12.
//
//

#import "EmiCalculatorClass.h"

@implementation EmiCalculatorClass

@synthesize receivedData;

- (void) setData:(long int)receivedPrincipal :(float)receivedRate :(int)receivedTime {
    principal = receivedPrincipal;
    rate = receivedRate;
    time = receivedTime;
    [self initiateConnectionToServer];
}

- (void) initiateConnectionToServer {
    connectionObject = [[EmiConnectionClass alloc]init];
    [connectionObject connectToServer:principal :rate :time];
}

- (int)getEmiValue
{
    return [connectionObject CalculatedEmi];
}

- (int)getTotalInterest
{
    //totalInterest = (Emi * time) - principal;
    return [connectionObject CalculatedTotalInterest];
}

- (int) getTotalPayment
{
    //totalPayment = principal + totalInterest;
    return [connectionObject CalculatedTotalPayment];
}

@end
