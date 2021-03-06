//
//  Blob.h
//  octochef
//
//  Created by Clay Smith on 7/16/11.
//  Copyright 2011 Widgetbox, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ObjectMapperDelegate;

@interface Blob : NSObject {
    NSString * _content;
    NSString * _encoding;
}
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * encoding;

-(void)writeBlobToFile:(ObjectMapperDelegate *)omDelegate;
+ (NSData *)decodeBase64WithString:(NSString *)strBase64;

@end
