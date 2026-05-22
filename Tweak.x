#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

// تعريف بسيط للكلاسات التي نتعامل معها (تجنب أخطاء التجميع)
@interface AWEUserModel : NSObject
@property long long followerCount;
@property long long followingCount;
@property BOOL isVerifiedUser;
@property (copy) NSString *uniqueID;
@property (copy) NSString *nickname;
@end

@interface AWEProfileHeaderViewController : UIViewController
- (void)reloadData;
@end

// ========== الخطافات الأساسية ==========
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
%end  // نكتفي بهذا فقط، بدون setter hooks

// ========== تحديث الواجهة عند الظهور ==========
%hook AWEProfileHeaderViewController
- (void)viewDidLoad {
    %orig;
    [self performSelector:@selector(reloadData) withObject:nil afterDelay:0.1];
}

- (void)viewWillAppear:(BOOL)animated {
    %orig;
    [self performSelector:@selector(reloadData) withObject:nil afterDelay:0.1];
}
%end
