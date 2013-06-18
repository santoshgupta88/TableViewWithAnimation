//
//  CustomTableView.h
//  Animated Table
//
//  Created by Santosh Gupta on 18/06/13.
//

#import <UIKit/UIKit.h>

@interface AnimatedTableView : UITableView

-(BOOL)deletedCellAtIndexPath:(NSIndexPath *)indexPath;
-(NSMutableArray *)editingDoneWithArray:(NSMutableArray *)array;

- (void) reloadDataWithAnimation :(NSString *)direction1 : (NSString *)direction2;
-(void)setEditing :(BOOL)flag ;
-(BOOL)getEditing;
@end
