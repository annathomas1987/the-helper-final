//
//  EmiParserClass.m
//  The Helper
//
//  Created by Anna Thomas on 10/17/12.
//
//

#import "EmiXmlParserClass.h"

NSString * const xmlTagForEmi = @"emi";
NSString * const xmlTagForTotalInterest = @"totalInterest";
NSString * const xmlTagForTotalPayment = @"totalPayment";

@implementation EmiXmlParserClass

- (void) startParsing:(NSMutableData *)receivedData {
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:receivedData];
    [parser setDelegate:self];
    [parser parse];
}

- (void) parser:(NSXMLParser *) parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    currentString = nil;
}

- (void) parser: (NSXMLParser *) parser foundCharacters:(NSString *)string {
    if (!currentString) {
        currentString = [[NSMutableString alloc] initWithCapacity:50];
    }
    currentString = [NSMutableString stringWithFormat:@"%@", string];
}

- (void) parser: (NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:xmlTagForEmi]) {
        //add the object
        Emi = [currentString intValue];
    }
    if ([elementName isEqualToString:xmlTagForTotalInterest]) {
        totalInterest = [currentString intValue];
    }
    if ([elementName isEqualToString:xmlTagForTotalPayment]) {
        //add the object
        totalPayment = [currentString intValue];
    }
}

- (long int) returnEmi {
    return Emi;
}

- (long int) returnTotalInterest {
    return totalInterest;
}

- (long int) returnTotalPayment {
    return totalPayment;
}

- (void) parser: (NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"error occured : %@", parseError);
}

@end
