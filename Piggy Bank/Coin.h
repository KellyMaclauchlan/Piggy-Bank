//
//  Coin.h
//  Piggy Bank
//
//  Created by Kelly Maclauchlan on 2016-07-07.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coin : NSObject
@property double value;
@property int count;

-(id)init: (double)v;
-(void)add;
-(void)undo;
-(double)total;
-(NSString *)getCount;
-(void)reset;
-(void)setCount: (int) c;
-(double)getValue;
-(NSString *)getString;

@end
