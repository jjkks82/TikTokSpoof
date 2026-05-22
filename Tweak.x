%hook AWEUserModel
- (NSNumber *)followerCount {
    return [NSNumber numberWithInt:5000001]; // عدل الرقم هنا
}
- (NSNumber *)followingCount {
    return [NSNumber numberWithInt:20]; // عدل الرقم هنا
}
- (BOOL)isVerifiedUser {
    return true; // تفعيل التوثيق
}
%end
