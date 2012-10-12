//
//  EmiCalculatorClass.m
//  The Helper
//
//  Created by Anna Thomas on 10/11/12.
//
//

#import "EmiCalculatorClass.h"

@implementation EmiCalculatorClass

@synthesize receivedData;

- (int)calculate:(long int)principal Emi:(float)rate formula:(int)time
{
    /*************************************************
     This is the part of code that does the calculation locally
     ************************************************/
    
    //code to calculate loan
    //             p*r*(1+r)^n
    // emi =       ----------- , p = principal amt, r = rate,
    //             ((1+r)^n)-1   n = loan term
    
    rate = rate / monthlyRate; // conversion of annual rate to monthly rate
    Emi = principal * rate;       //p*r
    float temp = 1 + rate;        //(1+r)
    temp = powf(temp, time);      //(1+r)^n
    Emi = Emi * temp / (temp-1);  //the complete formula
    
    /* 
     ************************************************
     This is the part of code that passes the values to remote php page
     ************************************************/
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8888/PhpProject2/emiServerSideCalculation.php?principal=%ld&rate=%f&time=%d", principal, rate, time]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (theConnection) {
        receivedData = [NSMutableData data];
        NSString *receivedDataString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
        NSLog(@"received Data = %@", receivedData);
        NSLog(@"received Data String = %@", receivedDataString);
    }
    return Emi;
}

- (int)calculate:(int)time totalInterest:(long int)principal
{
    totalInterest = (Emi * time) - principal;
    return totalInterest;
}

- (int) calculateTotalPayment:(long int)principal
{
    totalPayment = principal + totalInterest;
    return totalPayment;
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

- (void) connectionDidFinishLaunching:(NSURLConnection *)connection {
    
    //do something with the data
    //receiveData is declared as a method instance elsewhere
    NSLog(@"Succeeded! Received __ bytes of data");
    //release the connection and the data object
    //[connection release];
    //[receiveData release];
}

@end
