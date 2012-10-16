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
    [receivedData setLength:0];
    NSLog(@"Connection didReceiveResponse - %@", receivedData);
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
    NSString *receivedDataString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"Connection didReceiveDataString - %@", receivedDataString);
    NSData *xmlData = [receivedDataString dataUsingEncoding:NSUnicodeStringEncoding];
    if ([xmlData length] == 0) {
        NSLog(@"empty stirng.. :(");
    }
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:receivedData];
    [parser setDelegate:self];
    [parser parse];
    
}

- (void) parser: (NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"error occured : %@", parseError);
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed! Error - %@ %@", [error localizedDescription], [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void) connectionDidFinishLaunching:(NSURLConnection *)connection {
    NSLog(@"Succeeded! Received __ bytes of data");
}

- (void) parser:(NSXMLParser *) parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:@"LoanCalculator"]) {
        //do nothing
        totalInterest = [[attributeDict valueForKey:@"totalInterest"] integerValue];
        NSLog(@"totalInterest = %d", totalInterest);
    }
    if ([elementName isEqualToString:@"emi"]) {
        //assign tip to tip
        Emi = [[attributeDict valueForKey:@"emi"]integerValue];
        NSLog(@"emi = %d",Emi);
    }
    if ([elementName isEqualToString:@"totalPayment"]) {
        //assign totalAmount to totalAmount
        totalPayment = [[attributeDict valueForKey:@"totalPayment"] integerValue];
        NSLog(@"totalPayment = %d", totalPayment);
    }
}

- (void) parser: (NSXMLParser *) parser foundCharacters:(NSString *)string {
    if (!currentString) {
        currentString = [[NSMutableString alloc] initWithCapacity:50];
    }
    currentString = [NSMutableString stringWithFormat:@"%@",string];
    // do some action
}

- (void) parser: (NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    //ignore root and empty elements
    if ([elementName isEqualToString:@"LoanCalculator"]) {
        return;
    }
    if ([elementName isEqualToString:@"emi"]) {
        //add the object
        Emi = [currentString intValue];
        NSLog(@"emi = %d", Emi);
    }
    if ([elementName isEqualToString:@"totalPayment"]) {
        //add the object
        totalPayment = [currentString intValue];
        NSLog(@"totalpayment = %d", totalPayment);
    }
}

- (void) startParsing:(NSString *)myXMLString {
    NSData *xmlData = [myXMLString dataUsingEncoding:NSUnicodeStringEncoding];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
    [parser setDelegate:self];
    [parser parse];
}
@end
