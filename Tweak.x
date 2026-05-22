#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/message.h>

// تعريفات مبدئية (لا نحتاجها بعد التعديل لكنها مفيدة)
@class AWEUserModel;
@class AWEProfileHeaderViewController;

// ========== الخطافات الأساسية لنموذج المستخدم ==========
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

// تأمين إعدادات المُعينات (عند محاولة التطبيق تغيير القيم)
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

// ========== تحديث الواجهة تلقائياً فور عرض البروفايل ==========
%hook AWEProfileHeaderViewController
- (void)viewDidLoad {
    %orig;
    // استدعاء دالة التحديث بعد تحميل المشهد
    [self _refreshProfile];
}

- (void)viewWillAppear:(BOOL)animated {
    %orig;
    // تحديث عند ظهور المشهد (مثلاً العودة من علامة تبويب أخرى)
    [self _refreshProfile];
}

%new
- (void)_refreshProfile {
    // استخدام id لتجنب أخطاء التجميع
    id userModel = [(id)self valueForKey:@"_userModel"];
    if (userModel) {
        // إعادة تعيين القيم المزيفة
        objc_msgSend(userModel, @selector(setFollowerCount:), (long long)5000001);
        objc_msgSend(userModel, @selector(setFollowingCount:), (long long)20);
        objc_msgSend(userModel, @selector(setIsVerifiedUser:), YES);
        objc_msgSend(userModel, @selector(setUniqueID:), @"vi");
        objc_msgSend(userModel, @selector(setNickname:), @"vi");
        
        // طلب إعادة تحميل الواجهة إن وُجدت هذه الدالة
        if ([(id)self respondsToSelector:@selector(reloadData)]) {
            [(id)self performSelector:@selector(reloadData)];
        }
    }
}
%end
