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
    
    /************************************************
     This is the part of code that passes the values to remote php page
     ************************************************/
    
    // Create the request.
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8888/PhpProject2/index.php/"]cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    // create the connection with the request
    // and start loading the data
    
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (theConnection) {
        // Create the NSMutableData to hold the received data.
        // receivedData is an instance variable declared elsewhere.
        receivedData = [NSMutableData data];
        NSLog(@"Connection successful : received Data = %@", receivedData);
    } else {
        // Inform the user that the connection failed.
        NSLog(@"Connection failed");        
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
    NSLog(@"Connection didReceiveResponse");
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    [receivedData setLength:0];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    //Append the new data to receiveData.
    
    //receiveData is an instance variable declared elsewhere.
    [receivedData appendData:data];
    NSLog(@"Connection didReceiveData - %@", receivedData);
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
