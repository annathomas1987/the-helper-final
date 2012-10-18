//
//  TipCalculatorClass.m
//  The Helper
//
//  Created by Anna Thomas on 10/11/12.
//  Copyright (c) 2012 Client XYZ. All rights reserved.
//

#import "TipCalculatorClass.h"

@implementation TipCalculatorClass

- (void) setData:(long int)receivedBill :(float)receivedRate
{
    Bill = receivedBill;
    Rate = receivedRate;
}

- (void) initiateConnectionToServer
{
    connectionObject = [[TipConnectionClass alloc]init];
    [connectionObject connectToServer:Bill :Rate];
}

- (float)getTip
{
    NSLog(@"Tip is returned now..");
    return Tip;
}

- (float) getTotalBill
{
    return totalAmount;
}
@end
