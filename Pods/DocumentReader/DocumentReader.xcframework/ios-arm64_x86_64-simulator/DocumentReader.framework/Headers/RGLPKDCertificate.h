#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RGLPKDResourceType) {
    /**
     Certificate file contents (.pem, .cer, .crt, .der)
     */
    RGLPKDResourceTypeCertificate_PA          = 0,
    /**
     Certificate file contents (.cvcert) and private key file contents (.pkcs8)
     */
    RGLPKDResourceTypeCertificate_TA          = 1,
    /**
     LDIF file contents (.ldif)
     */
    RGLPKDResourceTypeLDIF                    = 2,
    /**
     CRL file contents (.crl)
     */
    RGLPKDResourceTypeCRL                     = 3,
    /**
     Master List (.ml, .mls)
     */
    RGLPKDResourceTypeML                      = 4,
    /**
     Defect List (.dl, .dls, .dfl)
     */
    RGLPKDResourceTypeDefL                    = 5,
    /**
     Deviance List (.dl, .dls, .dvl)
     */
    RGLPKDResourceTypeDevL                    = 6,
    /**
     Black List (.bl, .bls)
     */
    RGLPKDResourceTypeBL                      = 7,
} NS_SWIFT_NAME(PKDResourceType);

NS_SWIFT_NAME(PKDCertificate)
@interface RGLPKDCertificate : NSObject

@property(nonatomic, strong, readonly, nonnull) NSData *binaryData;
@property(nonatomic, assign, readonly) RGLPKDResourceType resourceType;
@property(nonatomic, strong, readonly, nullable) NSData *privateKey;

- (instancetype _Nonnull)initWithBinaryData:(NSData * _Nonnull)binaryData
                               resourceType:(RGLPKDResourceType)resourceType
                                 privateKey:(NSData *_Nullable)privateKey;

@end
