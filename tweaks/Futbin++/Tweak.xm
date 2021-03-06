@interface ALRootViewController
-(void)hideAdMobForPremium;
@end

%hook ALRootViewController

-(void)viewWillAppear:(BOOL)arg1 {
	%orig;
	[self hideAdMobForPremium];
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ )(void))completion {
	NSString *name = NSStringFromClass([viewControllerToPresent class]);
	if (([name isEqualToString:@"UIAlertController"]) && ([[(UIAlertController*)viewControllerToPresent title] isEqualToString:@"Old version"])) {
		return;
	}
	%orig;
}
%end

@interface ALAdView
-(void)setAlpha:(id)arg;
@end

%hook ALAdView
- (void)layoutSubviews {
	[self setAlpha: 0];
}
%end

%hook GADAd 
- (id)init { return nil; }
%end

%hook GADSlot 
- (id)init { return nil; }
%end

%hook GADRequest
- (id)init { return nil; }
%end

%hook GADNativeAd 
- (id)init { return nil; }
%end

%hook GADInterstitial 
- (id)init { return nil; }
%end

%hook ALAutoLayoutVideoViewController
-(id)initWithSdk:(id)arg2 currentAd:(id)arg3 currentPlacement:(id)arg4 wrapper:(id)arg5 { return nil; }
%end

%hook ALVASTVideoViewController
-(id)initWithSdk:(id)arg2 currentAd:(id)arg3 currentPlacement:(id)arg4 wrapper:(id)arg5 { return nil; }
%end

%ctor {
	@autoreleasepool {
		%init(ALRootViewController = NSClassFromString(@"Futbin.ALRootViewController"));
	}
}