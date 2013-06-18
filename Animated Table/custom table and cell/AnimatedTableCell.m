//
//  AnimatedTableCell.m
//  Animated Cell
//
//  Created by Santosh Gupta on 18/06/13.
//

#import "AnimatedTableCell.h"
#import "UIView+Positioning.h"
#import "ViewController.h"

#define animationDelay 0.0
#define defaultDuration 0.5

@implementation AnimatedTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.cellContentView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.cellContentView resetOriginToTopLeft];
        [self addSubview:self.cellContentView];

        self.deleteBtn = [[UIButton alloc] init];
        [self.deleteBtn setBackgroundImage:[UIImage imageNamed:@"deletebtnnew.png"] forState:UIControlStateNormal];
        [self.deleteBtn addTarget:self action:@selector(deleteCell:) forControlEvents:UIControlEventTouchUpInside];
        self.swipeImageView = [[UIImageView alloc] init];
        self.swipeImageView.image = [UIImage imageNamed:@"deletearrow-right.png"];
        self.swipeImageView.hidden = YES;

        self.cellPosition = -1;

        self.textLabel.backgroundColor = [UIColor clearColor];
        self.detailTextLabel.backgroundColor = [UIColor clearColor];
        self.imageView.backgroundColor = [UIColor clearColor];

        [self.cellContentView addSubview:self.textLabel];
        [self.cellContentView addSubview:self.detailTextLabel];
        [self.cellContentView addSubview:self.imageView];
        
        [self addSubview:self.swipeImageView];

        
        [self addGesture];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


- (void) configureCellWithTable:(AnimatedTableView *) table width:(float) width height:(float)height color:(UIColor *)color
{
    self.cellHeight = height;
    self.table = table;
    [self.cellContentView setFrame:CGRectMake(1, 1, width-2, height-2)];
    self.deleteBtn.frame = CGRectMake(height*25/100, height*25/100, height - 2*height*25/100, height - 2*height*25/100);
    self.cellContentView.backgroundColor = color;
    [self.swipeImageView setFrame:CGRectMake(width - 2*(height - 2*height*30/100), height*30/100, 1.5*(height - 2*height*30/100), height - 2*height*30/100)];

}

- (void) pushCellWithAnimation:(bool)animated
{
    [self pushCellWithAnimation:animated duration:defaultDuration];
}

- (void) pushCellWithAnimation:(bool)animated direction:(NSString *)direction
{
    [self pushCellWithAnimation:animated duration:defaultDuration direction:direction];
}

- (void) pushCellWithAnimation:(bool)animated duration:(float)duration
{
    if (!animated) duration = 0.0;
    [self.deleteBtn removeFromSuperview];
    [UIView animateWithDuration:duration
                          delay:animationDelay
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{self.cellContentView.center = CGPointMake(0, 0);}
                     completion:^(BOOL finished) {
                         [self addSubview:self.deleteBtn];
                         [self addSubview:self.cellContentView];
                         [self addSubview:self.swipeImageView];


                     }];

}

- (void) pushCellWithAnimation:(bool)animated duration:(float)duration direction:(NSString *)direction
{
    if ([direction isEqualToString:@"up"])
    {
        [self.cellContentView setCenter:CGPointMake(0, -self.cellContentView.frame.size.height)];
    } else if ([direction isEqualToString:@"down"])
    {
        [self.cellContentView setCenter:CGPointMake(0, self.cellContentView.frame.size.height)];
    } else if ([direction isEqualToString:@"left"])
    {
        [self.cellContentView setCenter:CGPointMake(-self.cellContentView.frame.size.width, 0)];
    } else if ([direction isEqualToString:@"right"])
    {
        [self.cellContentView setCenter:CGPointMake(self.cellContentView.frame.size.width, 0)];
    } else {
        [self.cellContentView setCenter:CGPointMake(0, -self.cellContentView.frame.size.height)];
    }
    
    [self pushCellWithAnimation:animated duration:duration];
}


- (void) popCellWithAnimation:(bool)animated
{
    [self popCellWithAnimation:animated duration:defaultDuration];
}

- (void) popCellWithAnimation:(bool)animated duration:(float)duration
{
    self.popped = YES;
    
    if (!animated) duration = 0.0;
    [self addSubview:self.deleteBtn];
    [self addSubview:self.cellContentView];
    [self addSubview:self.swipeImageView];

    [UIView animateWithDuration:duration
                          delay:animationDelay
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{self.cellContentView.center = CGPointMake(self.cellHeight, 0);}
                     completion:nil];

}

- (void) popForDeleteCellWithAnimation:(bool)animated
{
    [self popForDeleteCellWithAnimation:animated duration:defaultDuration];
}

- (void) popForDeleteCellWithAnimation:(bool)animated duration:(float)duration
{
    self.popped = YES;
    
    if (!animated) duration = 0.0;
    [self.deleteBtn removeFromSuperview];
    [UIView animateWithDuration:duration
                          delay:animationDelay
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{self.cellContentView.center = CGPointMake(self.frame.size.width, 0);}
                     completion:nil];
    
}


-(void)addGesture {
    
    self.swipegestureLeft = [[UISwipeGestureRecognizer alloc] init];
    self.swipegestureLeft.delegate = self;
    self.swipegestureLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.swipegestureLeft addTarget:self action:@selector(swipeleft:)];
    [self.cellContentView addGestureRecognizer:self.swipegestureLeft];
    
    self.swipegestureRight = [[UISwipeGestureRecognizer alloc] init];
    self.swipegestureRight.delegate = self;
    self.swipegestureRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.swipegestureRight addTarget:self action:@selector(swiperight:)];
    [self.cellContentView addGestureRecognizer:self.swipegestureRight];
    
}

-(void)swipeleft:(id)sender {
    if ([self.table getEditing]) {
        if (self.cellPosition == 0 || self.cellPosition == 1) {
            [self pushCellWithAnimation:YES];
            self.cellPosition = -1;
            self.swipeImageView.image = [UIImage imageNamed:@"deletearrow-right.png"];

        }
    }
}

-(void)swiperight:(id)sender {
    if ([self.table getEditing]) {
        if (self.cellPosition == -1) {
            [self popCellWithAnimation:YES];
            self.cellPosition = 0;
            self.swipeImageView.image = [UIImage imageNamed:@"deletearrow-left.png"];

        }
    }
    
    
}

-(void)deleteCell:(id)sender {
    if ([self.table getEditing]) {
        if ([self.gestureRecognizers count] == 0) {
            [self addGestureRecognizer:self.swipegestureLeft];
        }
        if (self.cellPosition == 0) {
            self.cellPosition = 1;
            [self popForDeleteCellWithAnimation:YES];
        }
    }
}



@end
