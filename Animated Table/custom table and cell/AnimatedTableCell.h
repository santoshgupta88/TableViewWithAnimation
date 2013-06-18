//
//  AnimatedTableCell.h
//  Animated Cell
//
//  Created by Santosh Gupta on 18/06/13.
//

#import <UIKit/UIKit.h>
#import "AnimatedTableView.h"

@interface AnimatedTableCell : UITableViewCell

@property (nonatomic) bool popped;
@property float cellHeight;
@property (nonatomic,strong) UIView *cellContentView;
@property (nonatomic,retain)UIButton *deleteBtn;
@property (nonatomic, retain) UIImageView *swipeImageView;

@property (nonatomic) int cellPosition;
@property (nonatomic,retain) UISwipeGestureRecognizer *swipegestureLeft;
@property (nonatomic,retain) UISwipeGestureRecognizer *swipegestureRight;
@property (nonatomic,retain) AnimatedTableView *table;

- (void) configureCellWithTable:(AnimatedTableView *) table width:(float) width height:(float)height color:(UIColor *)color;
- (void) pushCellWithAnimation:(bool)animated;
- (void) pushCellWithAnimation:(bool)animated direction:(NSString *)direction;
- (void) pushCellWithAnimation:(bool)animated duration:(float)duration;
- (void) pushCellWithAnimation:(bool)animated duration:(float)duration direction:(NSString *)direction;
- (void) popCellWithAnimation:(bool)animated;
- (void) popCellWithAnimation:(bool)animated duration:(float)duration;
- (void) popForDeleteCellWithAnimation:(bool)animated;
- (void) popForDeleteCellWithAnimation:(bool)animated duration:(float)duration;


-(void)addGesture;
-(void)swipeleft:(id)sender;
-(void)swiperight:(id)sender;
-(void)deleteCell:(id)sender;


@end
