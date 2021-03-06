//
//  Tree.h
//  octochef
//
//  Created by Clay Smith on 7/16/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ObjectMapperDelegate;
@class Leaf;

@interface Tree : NSObject {
    NSArray * _tree;
}

@property (nonatomic, retain) NSArray * tree;
-(void)getRecipies: (ObjectMapperDelegate*) omDelegate;

@end
