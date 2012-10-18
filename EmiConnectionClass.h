//
//  EmiConnectionClass.h
//  The Helper
//
//  Created by Anna Thomas on 10/17/12.
//
//

#import <Foundation/Foundation.h>
#import "EmiXmlParserClass.h"

@interface EmiConnectionClass : NSObject <NSXMLParserDelegate> {
    NSMutableData *receivedData;
    EmiXmlParserClass *parserObject;
}

- (void) connectToServer:(long int)principal :(float)rate :(int)time;
- (long int) CalculatedEmi;
- (long int) CalculatedTotalInterest;
- (long int) CalculatedTotalPayment;

@end
