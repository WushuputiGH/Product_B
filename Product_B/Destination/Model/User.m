//
//  User.m
//  Product_B
//
//  Created by by wushuputi on 16/7/13.
//  Copyright © 2016年 H. All rights reserved.
//

#import "User.h"

@implementation User


+ (User *)defaultUser{
    static User *defaultUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultUser = [[User alloc] init];
        
    });
    return defaultUser;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.avatar_l forKey:@"avatar_l"];
    [aCoder encodeObject:self.avatar_m forKey:@"avatar_m"];
    [aCoder encodeObject:self.avatar_s forKey:@"avatar_s"];
    
    [aCoder encodeObject:self.avatar_l_Data forKey:@"avatar_l_Data"];
    [aCoder encodeObject:self.avatar_m_Data forKey:@"avatar_m_Data"];
    [aCoder encodeObject:self.avatar_s_Data forKey:@"avatar_s_Data"];
    
    [aCoder encodeObject:self.birthday forKey:@"birthday"];
    [aCoder encodeObject:self.country_code forKey:@"country_code"];
    [aCoder encodeObject:self.country_num forKey:@"country_num"];
    [aCoder encodeObject:self.cover forKey:@"cover"];
    [aCoder encodeObject:self.coverData forKey:@"coverData"];
    
    [aCoder encodeObject:self.custom_url forKey:@"custom_url"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:@(self.email_verified) forKey:@"email_verified"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeObject:@(self.is_hunter) forKey:@"is_hunter"];
    [aCoder encodeObject:self.location_name forKey:@"location_name"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.resident_city_id forKey:@"resident_city_id"];
    [aCoder encodeObject:self.user_desc forKey:@"user_desc"];
    [aCoder encodeObject:self.experience forKey:@"experience"];
    
    
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super init];
    if (self) {
        self.avatar_l = [aDecoder decodeObjectForKey:@"avatar_l"];
        self.avatar_m = [aDecoder decodeObjectForKey:@"avatar_m"];
        self.avatar_s = [aDecoder decodeObjectForKey:@"avatar_s"];
        
        self.avatar_l_Data = [aDecoder decodeObjectForKey:@"avatar_l_Data"];
        self.avatar_m_Data = [aDecoder decodeObjectForKey:@"avatar_m_Data"];
        self.avatar_s_Data = [aDecoder decodeObjectForKey:@"avatar_s_Data"];

        
        self.birthday = [aDecoder decodeObjectForKey:@"birthday"];
        self.country_code = [aDecoder decodeObjectForKey:@"country_code"];
        self.country_num = [aDecoder decodeObjectForKey:@"country_num"];
        self.cover = [aDecoder decodeObjectForKey:@"cover"];
        self.coverData = [aDecoder decodeObjectForKey:@"coverData"];
        
        self.custom_url = [aDecoder decodeObjectForKey:@"custom_url"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.email_verified = [[aDecoder decodeObjectForKey:@"email_verified"] boolValue];
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.is_hunter = [[aDecoder decodeObjectForKey:@"is_hunter"] boolValue];
        self.location_name = [aDecoder decodeObjectForKey:@"location_name"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.resident_city_id = [aDecoder decodeObjectForKey:@"resident_city_id"];
        self.user_desc = [aDecoder decodeObjectForKey:@"user_desc"];
        self.experience = [aDecoder decodeObjectForKey:@"experience"];
    }
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        self.userId = value;
    }
}

@end
