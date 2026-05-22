#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

// ========== AWEUserModel ==========
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

// إجبار تحديث البيانات عند تعيينها من المصدر
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

// ========== AWEProfileHeaderViewController ==========
%hook AWEProfileHeaderViewController
- (void)viewDidLoad {
    %orig;
    // تحديث الواجهة فوراً بعد التحميل
    [self updateUIWithUserModel];
}

- (void)viewWillAppear:(BOOL)animated {
    %orig;
    [self updateUIWithUserModel];
}

%new
- (void)updateUIWithUserModel {
    // الحصول على نموذج المستخدم الحالي وإعادة تعيينه لتحديث الواجهة
    id userModel = [self valueForKey:@"_userModel"];
    if (userModel) {
        // إعادة تعيين البيانات المعدلة صراحة
        [userModel setFollowerCount:5000001];
        [userModel setFollowingCount:20];
        [userModel setIsVerifiedUser:YES];
        [userModel setUniqueID:@"vi"];
        [userModel setNickname:@"vi"];
        
        // إخبار الواجهة بالتحديث إن أمكن
        if ([self respondsToSelector:@selector(reloadData)]) {
            [self performSelector:@selector(reloadData)];
        }
    }
}
%end
