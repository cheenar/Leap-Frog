//
//  MainMenu.m
//  Hexagon
//
//  Created by Cheenar Gupte on 7/18/15.
//  Copyright (c) 2015 Chi Corp. All rights reserved.
//

#import "MainMenu.h"
#import "AboutScene.h"
#import "LevelMenu.h"

@implementation MainMenu

-(void)didMoveToView:(SKView *)view
{
    self.scaleMode = SKSceneScaleModeResizeFill;
    
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"menu_bg.png"]];
    background.position = CGPointMake(view.bounds.size.width/2, view.bounds.size.height/2);
    background.zPosition = 0;
    [background setSize:view.bounds.size];
    
    SKSpriteNode *frog = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"menu_frog.png"]];
    frog.position = CGPointMake(view.bounds.size.width - (view.bounds.size.width / 8), view.bounds.size.height/5);
    frog.zPosition = 1;
    [frog setScale:0.25];
    
    SKSpriteNode *title = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"menu_title.png"]];
    title.position = CGPointMake(view.bounds.size.width / 2, view.bounds.size.height - (view.bounds.size.height / 8));
    title.zPosition = 1;
    [title setScale:0.25];
    
    SKSpriteNode *levels = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"menu_levels.png"]];
    levels.position = CGPointMake(view.bounds.size.width / 2, view.bounds.size.height - (view.bounds.size.height/6 * 2));
    levels.zPosition = 1;
    [levels setName:@"menu_levels"];
    [levels setScale:0.35];
    
    SKSpriteNode *about = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"menu_about.png"]];
    about.position = CGPointMake(view.bounds.size.width / 2, view.bounds.size.height - (view.bounds.size.height / 2));
    about.zPosition = 1;
    [about setName:@"menu_about"];
    [about setScale:0.35];
    
    [self addChild:background];
    [self addChild:frog];
    [self addChild:title];
    [self addChild:levels];
    [self addChild:about];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if([[self childNodeWithName:@"menu_levels"] containsPoint:[touch locationInNode:self]])
    {
        LevelMenu *scene = [[LevelMenu alloc] initWithSize:self.size];
        
        SKTransition *transitionCrossFade = [SKTransition  revealWithDirection:SKTransitionDirectionUp duration:1.0];
        transitionCrossFade.pausesIncomingScene = TRUE;
        
        [[self view] presentScene:scene transition:transitionCrossFade];
    }
    if([[self childNodeWithName:@"menu_about"] containsPoint:[touch locationInNode:self]])
    {
        AboutScene *scene = [[AboutScene alloc] initWithSize:self.size];
        
        SKTransition *transitionCrossFade = [SKTransition  revealWithDirection:SKTransitionDirectionUp duration:1.0];
        transitionCrossFade.pausesIncomingScene = TRUE;
        
        [[self view] presentScene:scene transition:transitionCrossFade];
    }
}

@end
