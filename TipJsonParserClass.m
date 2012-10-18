//
//  TipJsonParserClass.m
//  The Helper
//
//  Created by Anna Thomas on 10/17/12.
//
//

#import "TipJsonParserClass.h"

NSString * const jsonKeyForTip = @"tip";
NSString * const jsonKeyForTotalAmount = @"totalAmount";

@implementation TipJsonParserClass

- (void) startParsing: (NSMutableData *)data {
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSDictionary *tipCalculator = [json objectForKey:@"TipCalculator"];
    Tip = [[tipCalculator objectForKey:jsonKeyForTip] floatValue];
    TotalAmount = [[tipCalculator objectForKey:jsonKeyForTotalAmount] floatValue];
    NSLog(@"started parsing");
}

- (long int) returnTotalAmount {
    return TotalAmount;
}

- (long int) returnTip {
    return Tip;
}
@end
