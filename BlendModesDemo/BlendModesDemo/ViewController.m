//
//  ViewController.m
//  BlendModesDemo
//
//  Created by ZDX on 2019/2/14.
//  Copyright © 2019 none. All rights reserved.
//

#import "ViewController.h"

CGContextRef MyCreateBitmapContext (int pixelsWide,
                                    int pixelsHigh)
{
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
    
    bitmapBytesPerRow   = (pixelsWide * 4);// 1
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);// 2
    bitmapData = calloc( bitmapByteCount, sizeof(uint8_t) );// 3
    if (bitmapData == NULL)
    {
        fprintf (stderr, "Memory not allocated!");
        return NULL;
    }
    context = CGBitmapContextCreate (bitmapData,// 4
                                     pixelsWide,
                                     pixelsHigh,
                                     8,      // bits per component
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaPremultipliedLast);
    if (context== NULL)
    {
        free (bitmapData);// 5
        fprintf (stderr, "Context not created!");
        return NULL;
    }
    CGColorSpaceRelease( colorSpace );// 6
    
    return context;// 7
}

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 128, 128)];
    self.imageView.center = self.view.center;
    [self.view addSubview:self.imageView];
    self.imageView.image = [self blendImageWithSize:CGSizeMake(256, 256)];
    self.imageView.layer.borderWidth = 1.0;
    self.imageView.layer.borderColor = [UIColor grayColor].CGColor;
}

- (UIImage *)blendImageWithSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    
    UIImage *destinationImg = [UIImage imageNamed:@"destination.png"];
    [destinationImg drawInRect:CGRectMake(0, 0, size.width, size.height) blendMode:kCGBlendModeNormal alpha:1.f];
    UIImage *sourceImg = [UIImage imageNamed:@"source.png"];
    [sourceImg drawInRect:CGRectMake(0, 0, size.width, size.height) blendMode:kCGBlendModeCopy alpha:1.f];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)genSourceImage
{
    CGContextRef context = MyCreateBitmapContext(256, 256);
    
    UIColor *color = [UIColor colorWithRed:71.0/256.0 green:151.0/256.0 blue:236.0/256.0 alpha:1.0];
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(16, 16, 146, 146));

    CGImageRef image = CGBitmapContextCreateImage(context);
    UIImage *result = [UIImage imageWithCGImage:image];
    NSData *data = UIImagePNGRepresentation(result);
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"source.png"];
    NSLog(@"filePath: %@", filePath);
    [data writeToFile:filePath atomically:YES];
    return result;
}

- (UIImage *)genDesImage
{
    CGContextRef context = MyCreateBitmapContext(256, 256);
    
    UIColor *color = [UIColor colorWithRed:214.0/256.0 green:57.0/256.0 blue:100.0/256.0 alpha:1.0];
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(146 / 2 + 16, 146 / 2 + 16, 146, 146));
    CGImageRef image = CGBitmapContextCreateImage(context);
    UIImage *result = [UIImage imageWithCGImage:image];
    NSData *data = UIImagePNGRepresentation(result);
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"destination.png"];
    NSLog(@"filePath: %@", filePath);

    [data writeToFile:filePath atomically:YES];
    return [UIImage imageWithCGImage:image];
}


@end
