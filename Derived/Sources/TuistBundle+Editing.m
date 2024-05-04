#import <Foundation/Foundation.h>
#import "TuistBundle+Editing.h"

NSBundle* Editing_SWIFTPM_MODULE_BUNDLE(void) {
    NSURL *bundleURL = [[[NSBundle mainBundle] bundleURL] URLByAppendingPathComponent:@"Highlighter_Editing.bundle"];

    NSBundle *bundle = [NSBundle bundleWithURL:bundleURL];

    return bundle;
}