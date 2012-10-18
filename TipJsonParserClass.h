//
//  TipJsonParserClass.h
//  The Helper
//
//  Created by Anna Thomas on 10/17/12.
//
//

#import <Foundation/Foundation.h>

extern NSString * const jsonKeyForTip;
extern NSString * const jsonKeyForTotalAmount;

@interface TipJsonParserClass : NSObject {
    long int Tip, TotalAmount;
}

- (void) startParsing: (NSMutableData *)receivedData;
- (long int) returnTotalAmount;
- (long int) returnTip;
@end
