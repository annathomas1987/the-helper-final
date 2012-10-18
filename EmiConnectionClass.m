//
//  EmiConnectionClass.m
//  The Helper
//
//  Created by Anna Thomas on 10/17/12.
//
//

#import "EmiConnectionClass.h"

@implementation EmiConnectionClass

- (void) connectToServer:(long int)principal :(float)rate :(int)time{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8888/PhpProject2/emiServerSideCalculation.php?principal=%ld&rate=%f&time=%d", principal, rate, time]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/(long int)receivedPrincipal :(float)receivedRate :(int)receivedTime" forHTTPHeaderField:@"Current-Type"];
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (theConnection) {
        receivedData = [NSMutableData data];
    }
    parserObject = [[EmiXmlParserClass alloc]init];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    [receivedData setLength:0];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
    [parserObject startParsing:receivedData];   
}

- (void) connectionDidFinishLaunching:(NSURLConnection *)connection {
    NSLog(@"Succeeded! Received __ bytes of data");
}


- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed! Error - %@ %@", [error localizedDescription], [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}


- (long int) CalculatedEmi {
    return [parserObject returnEmi];
}

- (long int) CalculatedTotalPayment {
    return [parserObject returnTotalPayment];
}

- (long int) CalculatedTotalInterest {
    return [parserObject returnTotalInterest];
}


@end
