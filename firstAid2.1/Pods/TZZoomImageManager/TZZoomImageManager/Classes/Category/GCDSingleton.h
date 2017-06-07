//
//  GCDSingleton.h
//  FamilyCare_iOS
//
//  Created by Sarinthon Mangkorn-ngam on 11/18/2558 BE.
//  Copyright © 2558 Sarinthon Mangkorn-ngam. All rights reserved.
//

#ifndef SaleWorkFlow_GCDSingleton_h
#define SaleWorkFlow_GCDSingleton_h
#define SINGLETON(block) \
static dispatch_once_t pred = 0; \
__strong static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
return _sharedObject; \

#endif
