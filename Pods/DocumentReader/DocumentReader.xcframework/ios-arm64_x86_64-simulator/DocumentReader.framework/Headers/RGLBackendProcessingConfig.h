//
//  RGLBackendProcessingConfig.h
//  DocumentReader
//
//  Created by Dmitry Evglevsky on 18.01.24.
//  Copyright © 2024 Regula. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RGLBackendProcessingConfig : NSObject

@property(nonatomic, strong, nullable) NSString *url;
@property(nonatomic, strong, nullable) NSDictionary *httpHeaders;
@property(nonatomic, strong, nullable) NSNumber *rfidServerSideChipVerification;
/// Timeout in seconds that can be configured for backend transaction creation and package finalization.
@property(nonatomic, strong, nullable) NSNumber *timeoutConnection;

@end

NS_ASSUME_NONNULL_END
