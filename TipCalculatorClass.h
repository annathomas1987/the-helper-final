//
//  TipCalculatorClass.h
//  The Helper
//
//  Created by Anna Thomas on 10/11/12.
//  Copyright (c) 2012 Client XYZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "constants.h"

@interface TipCalculatorClass : NSObject {
    
    float Tip, totalAmount;
    NSMutableData *receivedData;
}

- (float) calculate:(long int)billAmount Tip: (float)tipRate;
- (float) calculateTotalBill:(long int)amount;

@end
