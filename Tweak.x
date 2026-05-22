#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

%hook AWEUserModel

// تعديل عدد المتابعين
- (long long)followerCount {
    return 5000001; 
}

// تعديل عدد اللي تتابعهم
- (long long)followingCount {
    return 20; 
}

// تفعيل التوثيق
- (BOOL)isVerifiedUser {
    return YES;
}

// تعديل اليوزر نيم (اللي يجي بعد @)
- (NSString *)uniqueID {
    return @"vi";
}

// تعديل الاسم المستعار (الاسم اللي يظهر فوق اليوزر)
- (NSString *)nickname {
    return @"vi";
}

%end
