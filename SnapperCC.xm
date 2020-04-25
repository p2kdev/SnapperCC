#import <objc/runtime.h>
#import <CoreFoundation/CoreFoundation.h>
#import <CoreFoundation/CFNotificationCenter.h>
#import "SnapperCC.h"

extern "C" CFNotificationCenterRef CFNotificationCenterGetDistributedCenter();

@interface UIImage ()
+ (UIImage *)imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;
@end

@implementation SnapperCC
- (UIImage *)iconGlyph {
	return [UIImage imageNamed:@"icon" inBundle:[NSBundle bundleForClass:[self class]]];
}

- (UIColor *)selectedColor {
	return nil;// not much point having this as it can confuse people
}

- (BOOL)isSelected {
	return _selected;
}

- (void)setSelected:(BOOL)selected {
	_selected = selected;
	[super refreshState];
	SBControlCenterController *instance=[objc_getClass("SBControlCenterController") sharedInstance];
	[instance dismissAnimated:YES completion:nil];

	@try
	{
		PrysmMainPageViewController *instancePrysm=[objc_getClass("PrysmMainPageViewController") sharedInstance];
		if (instancePrysm)
			[instancePrysm dismissControlCenter];
	}
	@catch (NSException *ex)
	{

	}

	// if ([[UIApplication sharedApplication] isKindOfClass:NSClassFromString(@"SpringBoard")])
  // {
	//
  //     //[(SpringBoard *)[UIApplication sharedApplication] _simulateHomeButtonPress];
  // }

	_selected = NO;
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		int mode = 1;
		id prefValue = [[[NSUserDefaults standardUserDefaults] persistentDomainForName:@"com.p2kdev.snapper2cc"] objectForKey:@"Snapper2Mode"];
		if (prefValue)
			mode = [prefValue intValue];
		if (mode == 1)
			CFNotificationCenterPostNotification(CFNotificationCenterGetDistributedCenter(), CFSTR("com.jontelang.snapper2.force.open"), NULL, NULL, YES);
		else if (mode == 2)
			CFNotificationCenterPostNotification(CFNotificationCenterGetDistributedCenter(), CFSTR("com.jontelang.snapper2.forceinstant.open"), NULL, NULL, YES);
	});
}

@end
