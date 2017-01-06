//
//  FMYWObject.h
//  FMYWeath
//
//  Created by xw.long on 17/1/1.
//  Copyright © 2017年 fmylove. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "FMYWeath-swift.h"


@interface FMYWNewsType : NSObject

@property (nonatomic)id type;
@property (nonatomic)id check;
@property (nonatomic)id name;


@end

@interface FMYWNewsItemModel : NSObject

@property (nonatomic)id title;
@property (nonatomic)id date;
@property (nonatomic)id type;
@property (nonatomic)id category;
@property (nonatomic)id author_name;
@property (nonatomic)id thumbnail_pic_s;
@property (nonatomic)id url;
@property (nonatomic)id thumbnail_pic_s03;
@property (nonatomic)id thumbnail_pic_s02;
@property (nonatomic)id uniquekey;
@property (nonatomic)id realtype;

@end

@interface FMYWObject : NSObject
@end
