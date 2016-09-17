//
//  GameScene.h
//  Hexagon
//

//  Copyright (c) 2015 Chi Corp. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Level.h"
#import "Tile.h"

@interface GameScene : SKScene

-(instancetype)initWithSize:(CGSize)size andWithLevelID:(int)levelId;

@end
