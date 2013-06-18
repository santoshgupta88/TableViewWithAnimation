//
//  CustomTableView.m
//  Animated Table
//
//  Created by Santosh Gupta on 18/06/13.
//

#import "AnimatedTableView.h"
#import "AnimatedTableCell.h"

@interface AnimatedTableView ()
@property(nonatomic) BOOL isEditing;

@end

@implementation AnimatedTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(BOOL)deletedCellAtIndexPath:(NSIndexPath *)indexPath {
    AnimatedTableCell *cell = (AnimatedTableCell *)[self cellForRowAtIndexPath:indexPath];
    if (cell.cellPosition == 1) {
        return YES;
    }
    return  NO;
}

-(NSMutableArray *)editingDoneWithArray:(NSMutableArray *)array {
    int sections = [self numberOfSections];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < sections; i++) {
        int rows = [self numberOfRowsInSection:i];
        for (int j = 0 ; j< rows; j++) {
            if (![self deletedCellAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]]) {
                [arr addObject:[array objectAtIndex:j]];
            }
            else {
                AnimatedTableCell *cell = (AnimatedTableCell *)[self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
                cell.cellPosition = -1;
            }
        }
    }
    return arr;
}

- (void) reloadDataWithAnimation :(NSString *)direction1 : (NSString *)direction2
{
    [self reloadData];
    for (AnimatedTableCell *atCell in self.visibleCells) {
        if ([self.visibleCells indexOfObject:atCell] % 2 == 0)
            [atCell pushCellWithAnimation:YES direction:direction1];
        else
            [atCell pushCellWithAnimation:YES direction:direction2];
    }
}
-(void)setEditing :(BOOL)flag {
    
    int sections = [self numberOfSections];
    if (self.isEditing) {
        for (int i = 0 ; i < sections; i++) {
            int rows = [self numberOfRowsInSection:i];
            for (int j = 0 ; j< rows; j++) {
                AnimatedTableCell *cell = (AnimatedTableCell *)[self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
                cell.swipeImageView.hidden = YES;
            }
        }
    }
    else {
        for (int i = 0 ; i < sections; i++) {
            int rows = [self numberOfRowsInSection:i];
            for (int j = 0 ; j< rows; j++) {
                AnimatedTableCell *cell = (AnimatedTableCell *)[self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
                cell.swipeImageView.hidden = NO;

            }
        }
    }
    
    self.isEditing = flag;

}
-(BOOL)getEditing {
    return self.isEditing;
}


@end
