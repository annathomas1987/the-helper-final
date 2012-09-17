//
//  TipResultViewController.h
//  The Helper
//
//  Created by Anna Thomas on 9/13/12.
//  Copyright (c) 2012 Client XYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipResultViewController : UIViewController {
    
    UILabel *calculatedTip;
    id infoRequest;
}

@property (strong, nonatomic) IBOutlet UILabel *calculatedTip;
@property (nonatomic, retain) id infoRequest;

@end
