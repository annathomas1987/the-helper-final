//
//  TipCalculatorClass.m
//  The Helper
//
//  Created by Anna Thomas on 10/11/12.
//  Copyright (c) 2012 Client XYZ. All rights reserved.
//

#import "TipCalculatorClass.h"

@implementation TipCalculatorClass

- (float)calculate:(long int)billAmount Tip: (float)tipRate
{
    /*************************************************
     This is the part of code that does the calculation locally
     ************************************************/
    
    Tip = billAmount * tipRate /centPercent;
    /*
     ************************************************
     This is the part of code that passes the values to remote php page
     ************************************************/
   
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8888/PhpProject2/tipServerSideCalculation.php?billAmount=%ld&tipRate=%f", billAmount, tipRate]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (theConnection) {
        receivedData = [NSMutableData data];
        NSString *receivedDataString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
        NSLog(@"received Data = %@", receivedData);
        NSLog(@"received Data String = %@", receivedDataString);
        
    }
    return Tip;
}

- (float) calculateTotalBill:(long int)bill {
    totalAmount = bill + Tip;
    return totalAmount;
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    [receivedData setLength:0];
    NSLog(@"Connection didReceiveResponse - %@", receivedData);
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
    NSString *receivedDataString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"Connection didReceiveDataString - %@", receivedDataString);
    NSData *jsonData = [receivedDataString dataUsingEncoding:NSUnicodeStringEncoding];
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    NSDictionary *tipCalculator = [json objectForKey:@"TipCalculator"];
    Tip = [[tipCalculator objectForKey:@"tip"] floatValue];
    NSLog(@"integer value : %f", Tip);
    totalAmount = [[tipCalculator objectForKey:@"tip"] floatValue];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed! Error - %@ %@", [error localizedDescription], [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

@end
