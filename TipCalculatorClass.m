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
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    [receivedData setLength:0];
    NSLog(@"Connection didReceiveResponse - %@", receivedData);
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    //Append the new data to receiveData.
    
    //receiveData is an instance variable declared elsewhere.
    [receivedData appendData:data];
    NSString *receivedDataString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"Connection didReceiveDataString - %@", receivedDataString);
    // NSLog(@"Connection didReceiveData - %@", receivedData);
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    
    //release the connection, and the data object
    //[connection release];
    //receiveData is declared as an instance variable elsewhere
    //[receiveData release];
    //inform the user
    NSLog(@"Connection failed! Error - %@ %@", [error localizedDescription], [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}


@end
