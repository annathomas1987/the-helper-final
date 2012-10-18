//
//  TipConnectionClass.m
//  The Helper
//
//  Created by Anna Thomas on 10/17/12.
//
//

#import "TipConnectionClass.h"

@implementation TipConnectionClass

- (void) connectToServer:(long int)bill :(float)rate {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8888/PhpProject2/tipServerSideCalculation.php?billAmount=%ld&tipRate=%f", bill, rate]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (theConnection) {
        receivedData = [NSMutableData data];        
    }
    parserObject = [[TipJsonParserClass alloc]init];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    [receivedData setLength:0];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"connection did receive data");
    [receivedData appendData:data];
    [parserObject startParsing:receivedData];
//    NSError* error;
//    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//    NSDictionary *tipCalculator = [json objectForKey:@"TipCalculator"];
//    tipToGive = [[tipCalculator objectForKey:jsonKeyForTip] floatValue];
//    totalAmount = [[tipCalculator objectForKey:jsonKeyForTotalAmount] floatValue];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed! Error - %@ %@", [error localizedDescription], [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (long) calculatedTip {
    return [parserObject returnTip];
    
}
- (long) calculatedTotalAmount {
    return [parserObject returnTotalAmount];
}

@end
