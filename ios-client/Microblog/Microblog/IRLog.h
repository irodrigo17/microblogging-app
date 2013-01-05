//
//  IRLog.h
//  Microblog
//
//  Created by Ignacio Rodrigo on 1/5/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#ifndef Microblog_IRLog_h
#define Microblog_IRLog_h

#define IR_LOG_LEVEL_DEBUG      0
#define IR_LOG_LEVEL_INFO       1
#define IR_LOG_LEVEL_WARNING    2
#define IR_LOG_LEVEL_ERROR      3

#define IR_LOG_LEVEL            IR_LOG_LEVEL_DEBUG

#if IR_LOG_LEVEL <= IR_LOG_LEVEL_DEBUG
#   define IRDLog(fmt, ...) NSLog((@"[DEBUG] %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define IRDLog(...)
#endif

#if IR_LOG_LEVEL <= IR_LOG_LEVEL_INFO
#   define IRILog(fmt, ...) NSLog((@"[INFO] %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define IRILog(...)
#endif

#if IR_LOG_LEVEL <= IR_LOG_LEVEL_WARNING
#   define IRWLog(fmt, ...) NSLog((@"[WARNING] %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define IRWLog(...)
#endif

#if IR_LOG_LEVEL <= IR_LOG_LEVEL_ERROR
#   define IRELog(fmt, ...) NSLog((@"[ERROR] %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define IRELog(...)
#endif

#endif
