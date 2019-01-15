//
//  ViewController.m
//  Tutorial_01
//
//  Created by 周舟 on 2019/1/13.
//  Copyright © 2019 none. All rights reserved.
//

#import "ViewController.h"
#import <GLKit/GLKit.h>

@interface ViewController ()

@property (nonatomic, strong) EAGLContext *mContext;
@property (nonatomic, strong) GLKBaseEffect *mEffect;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupConfig];
    [self uploadVertexArray];
    [self uploadTexture];

}


- (void)setupConfig
{
    self.mContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    GLKView *view = (GLKView *)self.view;
    view.context = self.mContext;
    view.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    [EAGLContext setCurrentContext:self.mContext];
}

- (void)uploadVertexArray
{
    //顶点数据，前三个是顶点坐标（x、y、z轴），后面两个是纹理坐标（x，y）
    GLfloat vertexData[] =
    {
        0.0, -0.5, 0.0f,    1.0f, 0.0f, //右下
        0.0, 0.5, -0.0f,    1.0f, 1.0f, //右上
        -1.0, 0.5, 0.0f,    0.0f, 1.0f, //左上
        
        0.0, -0.5, 0.0f,    1.0f, 0.0f, //右下
        -1.0, 0.5, 0.0f,    0.0f, 1.0f, //左上
        -1.0, -0.5, 0.0f,   0.0f, 0.0f, //左下
        
        1.0, -0.5, 0.0f,    1.0f, 0.0f, //右下
        1.0, 0.5, -0.0f,    1.0f, 1.0f, //右上
        0.0, 0.5, 0.0f,    0.0f, 1.0f, //左上
        
        1.0, -0.5, 0.0f,    1.0f, 0.0f, //右下
        0.0, 0.5, 0.0f,    0.0f, 1.0f, //左上
        0.0, -0.5, 0.0f,   0.0f, 0.0f, //左下

    };
    //顶点数据缓存
    GLuint buffer;
    glGenBuffers(1, &buffer);
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertexData), vertexData, GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition); //顶点数据缓存
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 0);
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0); //纹理
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 3);

}

- (void)uploadTexture
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"for_test" ofType:@"jpg"];
    NSDictionary* options = [NSDictionary dictionaryWithObjectsAndKeys:@(1), GLKTextureLoaderOriginBottomLeft, nil];//GLKTextureLoaderOriginBottomLeft 纹理坐标系是相反的
    GLKTextureInfo *textureInfo = [GLKTextureLoader textureWithContentsOfFile:filePath options:options error:nil];
    self.mEffect = [[GLKBaseEffect alloc] init];
    self.mEffect.texture2d0.enabled = GL_TRUE;
    self.mEffect.texture2d0.name = textureInfo.name;
    
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(0.3f, 0.6f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    //启动着色器
    [self.mEffect prepareToDraw];
    glDrawArrays(GL_TRIANGLES, 0, 12);
}

@end
