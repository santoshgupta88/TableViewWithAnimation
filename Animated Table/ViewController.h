//
//  ViewController.h
//  Animated Table
//
//  Created by Santosh Gupta on 18/06/13.
//

#import <UIKit/UIKit.h>
#import "AnimatedTableView.h"

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{  
    
    NSMutableArray *dataArray;

}

@property (nonatomic,strong) AnimatedTableView *table;

@end
