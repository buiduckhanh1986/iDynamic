//
//  Animal.h
//  iDynamic
//
//  Created by Bui Duc Khanh on 6/28/16.
//  Copyright © 2016 Bui Duc Khanh. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Animal <NSObject>
- (NSString *) getImage;
@end


@interface Dog : NSObject <Animal>
@end

@interface Lion : NSObject <Animal>
@end

@interface Eagle : NSObject <Animal>
@end

@interface Shark : NSObject
- (NSString *) getImage;
@end

@interface Tiger : NSObject
@end
