//
//  EmiCalculatorClass.h
//  The Helper
//
//  Created by Anna Thomas on 10/11/12.
//
//

#import <Foundation/Foundation.h>
#import "constants.h"

@interface EmiCalculatorClass : NSObject <NSXMLParserDelegate> {

    int Emi, totalPayment, totalInterest;
    NSMutableData *receivedData;
    NSMutableString *currentString;
    
}

@property (nonatomic, retain) NSData *receivedData;

- (int) calculate:(long int)principal Emi:(float)rate formula:(int)time;
- (int) calculate:(int)time totalInterest:(long int)principal;
- (int) calculateTotalPayment:(long int)principal;
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
- (void) connectionDidFinishLaunching:(NSURLConnection *) connection;
- (void) startParsing:(NSString *)myXMLString;

@end
