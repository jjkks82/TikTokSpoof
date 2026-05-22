#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/message.h>

// إعلان مسبق للدالة التي سنضيفها لاحقاً
@class AWEUserModel;
@interface AWEProfileHeaderViewController : UIViewController
- (void)_refreshProfile;
@end

// ========== تزوير قيم AWEUserModel ==========
%hook AWEUserModel
- (long long)followerCount {
    return 5000001;
}
- (long long)followingCount {
    return 20;
}
- (BOOL)isVerifiedUser {
    return YES;
}
- (NSString *)uniqueID {
    return @"vi";
}
- (NSString *)nickname {
    return @"vi";
}

// منع التطبيق من تغيير القيم المزيفة
- (void)setFollowerCount:(long long)arg1 {
    %orig(5000001);
}
- (void)setFollowingCount:(long long)arg1 {
    %orig(20);
}
- (void)setIsVerifiedUser:(BOOL)arg1 {
    %orig(YES);
}
- (void)setUniqueID:(NSString *)arg1 {
    %orig(@"vi");
}
- (void)setNickname:(NSString *)arg1 {
    %orig(@"vi");
}
%end

// ========== تحديث واجهة البروفايل تلقائياً ==========
%hook AWEProfileHeaderViewController
- (void)viewDidLoad {
    %orig;
    // تحديث فوري بعد تحميل الشاشة
    [self _refreshProfile];
}

- (void)viewWillAppear:(BOOL)animated {
    %orig;
    // تحديث كلما ظهرت الشاشة (مثلاً بعد الرجوع من علامة تبويب أخرى)
    [self _refreshProfile];
}

%new
- (void)_refreshProfile {
    id userModel = [(id)self valueForKey:@"_userModel"];
    if (userModel) {
        // استخدام cast لتجنب أخطاء objc_msgSend في السلسلة الجديدة
        ((void (*)(id, SEL, long long))objc_msgSend)(userModel, @selector(setFollowerCount:), 5000001LL);
        ((void (*)(id, SEL, long long))objc_msgSend)(userModel, @selector(setFollowingCount:), 20LL);
        ((void (*)(id, SEL, BOOL))objc_msgSend)(userModel, @selector(setIsVerifiedUser:), YES);
        ((void (*)(id, SEL, NSString *))objc_msgSend)(userModel, @selector(setUniqueID:), @"vi");
        ((void (*)(id, SEL, NSString *))objc_msgSend)(userModel, @selector(setNickname:), @"vi");
        
        // إجبار الواجهة على إعادة تحميل البيانات
        if ([(id)self respondsToSelector:@selector(reloadData)]) {
            [(id)self performSelector:@selector(reloadData)];
        }
    }
}
%end
