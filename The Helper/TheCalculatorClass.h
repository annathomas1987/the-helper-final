//
//  TheCalculatorClass.h
//  The Helper
//
//  Created by Anna Thomas on 9/17/12.
//  Copyright (c) 2012 Client XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TheCalculatorClass : NSDecimalNumber {
 
    int Emi, totalPayment, totalInterest, Tip;
    const int monthlyRate, centPercent;
}

- (int) calculate:(long int)billAmount Tip: (float)tipRate;
- (int) calculate:(long int)principal Emi:(float)rate formula:(int)time;
- (int) calculate:(int)time totalInterest:(long int)principal;
- (int) calculateTotalPayment:(long int)principal;

@end
