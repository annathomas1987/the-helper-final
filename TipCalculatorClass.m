//
//  TipCalculatorClass.m
//  The Helper
//
//  Created by Anna Thomas on 10/11/12.
//  Copyright (c) 2012 Client XYZ. All rights reserved.
//

#import "TipCalculatorClass.h"

@implementation TipCalculatorClass

- (float)calculate:(long int)billAmount Tip: (float)tipRate
{
    Tip = billAmount * tipRate /centPercent;
    return Tip;
}

- (float) calculateTotalBill:(long int)bill {
    totalAmount = bill + Tip;
    return totalAmount;
}

@end
