//
//  TheCalculatorClass.m
//  The Helper
//
//  Created by Anna Thomas on 9/17/12.
//  Copyright (c) Client XYZ. All rights reserved.
//

#import "TheCalculatorClass.h"
#import "constants.h"

@implementation TheCalculatorClass

- (float)calculate:(long int)billAmount Tip: (float)tipRate  
{  
    Tip = billAmount * tipRate /centPercent;
    return Tip;
} 

- (float) calculateTotalBill:(long int)bill {
    totalAmount = bill + Tip;
    return totalAmount;
}

- (int)calculate:(long int)principal Emi:(float)rate formula:(int)time   
{  
    //code to calculate loan 
    //             p*r*(1+r)^n
    // emi =       ----------- , p = principal amt, r = rate,
    //             ((1+r)^n)-1   n = loan term
    
    rate = rate / monthlyRate; // conversion of annual rate to monthly rate
    Emi = principal * rate;       //p*r
    float temp = 1 + rate;        //(1+r)
    temp = powf(temp, time);      //(1+r)^n
    Emi = Emi * temp / (temp-1);  //the complete formula
    return Emi;
}  

- (int)calculate:(int)time totalInterest:(long int)principal
{
    totalInterest = (Emi * time) - principal;
    return totalInterest;
}

- (int) calculateTotalPayment:(long int)principal
{
    totalPayment = principal + totalInterest;
    return totalPayment;
}

@end
