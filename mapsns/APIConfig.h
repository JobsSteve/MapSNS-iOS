//
//  APIConfig.h
//  mapsns
//
//  Created by 温盛章 on 13-2-14.
//  Copyright (c) 2013年 温盛章. All rights reserved.
//

#ifndef mapsns_APIConfig_h
#define mapsns_APIConfig_h
#include "TaskId.h"
#define BASE_URL @"http://192.168.1.100:8080/MapSNS"
#define EXTEND_URL(x) [BASE_URL stringByAppendingString:x]

#define USER_LOGIN_URL EXTEND_URL(@"/user/login")

#define TIMELINE_USER_URL EXTEND_URL(@"/timeline/gettimeline")
#define TIMELINE_PUBLISH_TEXT EXTEND_URL(@"/timeline/publish/text")

#endif
