//
//  TipCalculatorClass.h
//  The Helper
//
//  Created by Anna Thomas on 10/11/12.
//  Copyright (c) 2012 Client XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "constants.h"
#import "TipConnectionClass.h"

@interface TipCalculatorClass : NSObject {
    
    float Tip, totalAmount;
    NSMutableData *receivedData;
    long int Bill;
    float Rate;
    TipConnectionClass *connectionObject;
}

- (void) setData:(long int)receivedBill :(float)receivedRate;
- (void) initiateConnectionToServer;
- (float) getTip;
- (float) getTotalBill;

@end
