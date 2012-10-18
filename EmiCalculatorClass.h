//
//  EmiCalculatorClass.h
//  The Helper
//
//  Created by Anna Thomas on 10/11/12.
//
//

#import <Foundation/Foundation.h>
#import "constants.h"
#import "EmiConnectionClass.h"

@interface EmiCalculatorClass : NSObject <NSXMLParserDelegate> {
    
    long int principal;
    float rate;
    int time;
    long int Emi, totalPayment, totalInterest;
    NSMutableData *receivedData;
    NSMutableString *currentString;
    EmiConnectionClass *connectionObject;
}

@property (nonatomic, retain) NSData *receivedData;

- (void) initiateConnectionToServer;
- (void) setData:(long int)receivedPrincipal :(float)receivedRate :(int)receivedTime;
- (int) getEmiValue;
- (int) getTotalInterest;
- (int) getTotalPayment;

@end
