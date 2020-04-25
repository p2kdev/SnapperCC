#import <Preferences/Preferences.h>

@interface SNPRootListController : PSListController
@end

@implementation SNPRootListController
- (NSArray *)specifiers
{
	if(!_specifiers)
	{
		_specifiers = [self loadSpecifiersFromPlistName:@"Prefs" target:self];
	}

	return _specifiers;
}

@end
