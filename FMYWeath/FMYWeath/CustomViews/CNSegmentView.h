//
//  CNSegmentView.h
//  CNMenuDemo
//
//  Created by xuewu.long on 16/8/1.
//  Copyright © 2016年 letv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMYWObject.h"
//#import "FMYWeath-swift.h"

typedef NS_ENUM(NSUInteger, CNSegmentEvent) {
    CNSegmentEventItemClick,
    CNSegmentEventAddClick,
};

@interface CNSegmentBtn : UIButton

@property (nonatomic, strong) NSValue *valueRect;
@property (nonatomic, assign) CGFloat realW;

- (void)reloadFrame;


@end



//===

typedef void(^CNSegmentBlock)(NSInteger selectedIndex,CNSegmentEvent segEvent);

@interface CNSegmentView : UIView

@property (nonatomic, strong) NSMutableArray<FMYWNewsType *> *arrItem;
@property (nonatomic, strong) UIColor *colorSelected;
@property (nonatomic, strong) UIColor *colorNormal;
@property (nonatomic, strong) UIColor *colorHighlight;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) CGFloat mapOffsetX;

+ (CGFloat)segmentHeight;

- (void)cn_segBlock:(CNSegmentBlock )thisBlock;
- (void)insertItem:(NSString *)item atIndex:(NSInteger)index;
- (void)addItems:(NSArray *)items;



@end
