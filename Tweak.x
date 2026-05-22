#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

%hook AWEUserModel

- (NSNumber *)followerCount {
    return [NSNumber numberWithInt:5000001];
}

- (NSNumber *)followingCount {
    return [NSNumber numberWithInt:20];
}

- (BOOL)isVerifiedUser {
    return YES;
}

%end
