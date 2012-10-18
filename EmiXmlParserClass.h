//
//  EmiParserClass.h
//  The Helper
//
//  Created by Anna Thomas on 10/17/12.
//
//

#import <Foundation/Foundation.h>

extern NSString * const xmlTagForEmi;
extern NSString * const xmlTagForTotalInterest;
extern NSString * const xmlTagForTotalPayment;

@interface EmiXmlParserClass : NSObject <NSXMLParserDelegate> {
    
    NSMutableString *currentString;
    long int Emi, totalInterest, totalPayment;
}

- (void) startParsing:(NSMutableData *)receivedData;
- (long int) returnEmi;
- (long int) returnTotalInterest;
- (long int) returnTotalPayment;

@end
