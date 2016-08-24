//
//  Coin.m
//  Piggy Bank
//
//  Created by Kelly Maclauchlan on 2016-07-07.
//  Copyright © 2016 Kelly Maclauchlan. All rights reserved.
//

#import "Coin.h"

@implementation Coin
@synthesize value,count;

-(id)init:(double)v{
    self.value=v;
    count=0;
    return self;
}
-(void)add{
    count++;
}
-(void)undo{
    count--;
}
-(double)total{
    return value*count;
}
-(NSString *)getCount{
    return [NSString stringWithFormat:@"%i",count];
}
-(void)reset{
    count=0;
}

-(double)getValue{
    return value;
}
-(NSString *)getString{
    return [NSString stringWithFormat:@"%.2f %i ",value,count];
}
    
@end
