//
//  TipConnectionClass.h
//  The Helper
//
//  Created by Anna Thomas on 10/17/12.
//
//

#import <Foundation/Foundation.h>
#import "TipJsonParserClass.h"

@interface TipConnectionClass : NSObject {
    NSMutableData *receivedData;
    TipJsonParserClass *parserObject;
}

- (void) connectToServer:(long int)bill :(float)rate;
- (long) calculatedTip;
- (long) calculatedTotalAmount;

@end
