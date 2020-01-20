#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "ZumeroSync.h"
#import "ZumeroUtil.h"
#import "zumero_client_api.h"

FOUNDATION_EXPORT double ZumeroSyncVersionNumber;
FOUNDATION_EXPORT const unsigned char ZumeroSyncVersionString[];

