//
//  Coolblue.h
//  Coolblue
//
//  Created by Anil Can Baykal on 1/4/16.
//  Copyright © 2016 HappyBlueDuck. All rights reserved.
//

#ifndef Coolblue_h
#define Coolblue_h
#import <objc/runtime.h>

/*
 Some usefull macros for dealing nib creation
 */

//==============================================================================
#define _className(x)		        [NSString stringWithCString:class_getName([x class]) encoding:NSUTF8StringEncoding]

#if __has_feature(objc_arc)

#define _create(x)		(x*)[[x alloc] initWithNibName:_className(x) bundle:nil]

#else

#define _create(x)		(x*)[[[x alloc] initWithNibName:_className(x) bundle:nil] autorelease]

#endif

#endif /* Coolblue_h */
