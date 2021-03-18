//
//  swizzlerTests.m
//  swizzlerTests
//
//  Created by Amresh Kumar on 02/03/21.
//

#import <XCTest/XCTest.h>

@import ObjectiveC.runtime;

@interface Test : NSObject

- (int) value;

@end

@implementation Test

- (int) value {
    return 12;
}

@end

@interface swizzlerTests : XCTestCase

@end

@implementation swizzlerTests

static int loaded;

static void load(Class self, SEL _cmd)
{
    loaded++;
}

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    
    Class a, b, c, d, e;

    assert(class_getInstanceSize(objc_allocateClassPair(Nil, "Empty", 0)) == sizeof(Class));
    a = objc_allocateClassPair([Test class], "A", 0);
    objc_registerClassPair(a);

    b = objc_allocateClassPair(a, "B", 0);
    class_addMethod(object_getClass(b), @selector(load), (IMP)load, "@:");

    class_addIvar(b, "anIvar", 4, 2, "i");
    objc_registerClassPair(b);

    Ivar iv = class_getInstanceVariable(b, "anIvar");
    size_t superSize = class_getInstanceSize([Test class]);
    assert(ivar_getOffset(iv) == superSize);

    class_getSuperclass(b);

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
