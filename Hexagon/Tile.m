//
//  Tile.m
//  Hexagon
//
//  Created by Cheenar Gupte on 7/12/15.
//  Copyright (c) 2015 Chi Corp. All rights reserved.
//

#import "Tile.h"

@implementation Tile
@synthesize _tile_obj_node, isPlayer;

BOOL isRotating;
BOOL isRotatingForwards;

BOOL hasBeenSteppedOn;
SKSpriteNode *bg_fly = nil;

-(void)setHasBeenSteppedOn:(BOOL)boo
{
    hasBeenSteppedOn = boo;
}

-(BOOL)hasBeenSteppedOn
{
    return hasBeenSteppedOn;
}

-(SKSpriteNode *)getBgFly
{
    return bg_fly;
}

-(instancetype) initWithScene:(SKScene *)scene andWithType:(T_Type)type andWithPos:(CGPoint)point
{
    self = [super init];
    
    if(self)
    {
        isRotating = false;
        [self spawnTile:scene withType:type andWithPosXY:point];
    }
    
    return self;
}

-(NSString *)randomNormalLilypad
{
    int a = arc4random_uniform(3);
    a = a + 1;
    return [NSString stringWithFormat:@"lily_%i.png", a];
}

-(BOOL)isRotatingForw
{
    return isRotatingForwards;
}

-(int) generateRotationAngle
{
    
    isRotatingForwards = NO;
    int a = arc4random_uniform(30);
    a = a + 1; //no more 0s
    
    int b = arc4random_uniform(2);
    if(b == 1) //apply negative rotation
    {
        a = a * -1;
        isRotatingForwards = YES;
    }
    
    return a;
}

-(void)applyRandomTileRotation
{
    //int a = arc4random_uniform(2);
    //if(a == 1)
    //{
    isRotating = YES;
        [_tile_obj_node runAction:[SKAction repeatActionForever:[SKAction sequence:[NSArray arrayWithObjects:[SKAction rotateByAngle:[self generateRotationAngle] duration:arc4random_uniform(50) + 30], [SKAction waitForDuration:0.5], nil]]]];
    //}
}

-(void)applyRandomTileCut
{
    
}

-(SKTexture *)blockIdentity:(T_Type)type
{
    switch (type) {
            
        case NORMAL:
            _tile_obj_node.name = @"NORMAL_BLOCK";
            return [SKTexture textureWithImageNamed:[self randomNormalLilypad]];
        
        case BLACK:
            _tile_obj_node.name = @"BLACK_BLOCK";
            return [SKTexture textureWithImageNamed:@"lily_block.png"];
            
        case INVISIBLE:
            _tile_obj_node.name = @"INVISIBLE_BLOCK";
            return [SKTexture textureWithImageNamed:[self randomNormalLilypad]];
        
        case ORANGE:
            _tile_obj_node.name = @"ORANGE";
            return [SKTexture textureWithImageNamed:[self randomNormalLilypad]];
        
        case WIN:
            _tile_obj_node.name = @"WIN_BLOCK";
            return [SKTexture textureWithImageNamed:@"lily_win.png"];
        
        default:
            return [SKTexture textureWithImageNamed:[self randomNormalLilypad]];
    
    }
}

-(void)runIDChange:(T_Type)type
{
    [_tile_obj_node runAction:[SKAction setTexture:[self blockIdentity:type]]];
    
    if(type == NORMAL)
    {
        [_tile_obj_node runAction:[SKAction setTexture:[self blockIdentity:type]]];
        [self applyRandomTileRotation];
        [self applyRandomTileCut]; //TODO
    }
    
    if(type == INVISIBLE)
    {
        [_tile_obj_node runAction:[SKAction fadeAlphaTo:0 duration:0.0]];
    }
    else
    {
        [_tile_obj_node runAction:[SKAction fadeAlphaTo:1.0 duration:0.0]];
    }
}

-(void)spawnTile:(SKScene *)scene withType:(T_Type)type andWithPosXY:(CGPoint)posxy
{
    if(type == PLAYER)
    {
        isPlayer = YES;
        
        SKSpriteNode *bg_player = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"lily_1.png"]];
        bg_player.position = posxy;
        [bg_player setScale:0.05];
        bg_player.name = @"bg_player";
        [scene addChild:bg_player];
        
        _tile_obj_node = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"player.png"]];
        _tile_obj_node.name = @"PLAYER";
    }
    else if(type == FLY)
    {
        bg_fly = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"lily_1.png"]];
        bg_fly.position = posxy;
        [bg_fly setAlpha:0.0];
        [bg_fly setScale:0.05];
        bg_fly.name = @"bg_fly";
        bg_fly.zPosition = 3;
        
        _tile_obj_node = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"fly.png"]];
        _tile_obj_node.name = @"FLY";
        [_tile_obj_node runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:[NSArray arrayWithObjects:[SKTexture textureWithImageNamed:@"fly.png"], [SKTexture textureWithImageNamed:@"fly2.png"], nil] timePerFrame:0.2]]];
        
    }
    else
    {
        isPlayer = NO;
        _tile_obj_node = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"lily_1"]]; //this is just a placeholder
        _tile_obj_node.name = @"REGULAR_BLOCK";
    }
    _tile_obj_node.position = posxy;
    [_tile_obj_node setScale:0.05];
    _tile_obj_node.zPosition = 4;
    _tile_obj_node.anchorPoint = CGPointMake(0.5, 0.5);
    if(type != PLAYER)
    {
        [self runIDChange:type]; //changes the picture to a random, also adds random rotation?
    }
    
    if(type == FLY)
    {
        [scene addChild:bg_fly];
    }
}

@end
