//
//  AboutScene.m
//  Hexagon
//
//  Created by Cheenar Gupte on 7/19/15.
//  Copyright (c) 2015 Chi Corp. All rights reserved.
//

#import "AboutScene.h"
#import "MainMenu.h"

@implementation AboutScene

-(void)didMoveToView:(SKView *)view
{
    self.scaleMode = SKSceneScaleModeResizeFill;
    
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"menu_bg.png"]];
    background.position = CGPointMake(view.bounds.size.width/2, view.bounds.size.height/2);
    background.zPosition = 0;
    [background setScale:0.5];
    
    SKSpriteNode *arrow = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"arrow.png"]];
    arrow.position = CGPointMake(view.bounds.size.width/10, view.bounds.size.height - (view.bounds.size.height/8));
    [arrow setScale:0.5];
    arrow.zPosition = 2;
    [arrow setScale:0.1];
    [arrow setName:@"arrow"];
    
    SKSpriteNode *frog = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"menu_frog.png"]];
    frog.position = CGPointMake(view.bounds.size.width - (view.bounds.size.width / 8), view.bounds.size.height/5);
    frog.zPosition = 1;
    [frog setScale:0.25];
    
    SKSpriteNode *title = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"menu_title.png"]];
    title.position = CGPointMake(view.bounds.size.width / 2, view.bounds.size.height - (view.bounds.size.height / 8));
    title.zPosition = 1;
    [title setScale:0.25];
    
    SKLabelNode *lblDev = [SKLabelNode labelNodeWithFontNamed:@"MarkerFelt"];
    lblDev.fontSize = 16;
    lblDev.text = @"Programmer: Cheenar Gupte";
    lblDev.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    lblDev.position = CGPointMake(view.bounds.size.width / 2, view.bounds.size.height / 2);
    lblDev.fontColor = [SKColor whiteColor];
    lblDev.zPosition = 1;
    
    SKLabelNode *lblAut = [SKLabelNode labelNodeWithFontNamed:@"MarkerFelt"];
    lblAut.fontSize = 16;
    lblAut.text = @"Artist: Ryan Borzoie";
    lblAut.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    lblAut.position = CGPointMake(view.bounds.size.width / 2, (view.bounds.size.height / 2) - (view.bounds.size.height / 10));
    lblAut.fontColor = [SKColor whiteColor];
    lblAut.zPosition = 1;
    
    SKLabelNode *lblMsc = [SKLabelNode labelNodeWithFontNamed:@"MarkerFelt"];
    lblMsc.fontSize = 16;
    lblMsc.text = @"Music: Kevin MacCleood";
    lblMsc.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    lblMsc.position = CGPointMake(view.bounds.size.width / 2, (view.bounds.size.height / 2) - ((view.bounds.size.height / 10 ) * 2));
    lblMsc.fontColor = [SKColor whiteColor];
    lblMsc.zPosition = 1;
    
    SKLabelNode *lblHel = [SKLabelNode labelNodeWithFontNamed:@"MarkerFelt"];
    lblHel.fontSize = 16;
    lblHel.text = @"Help: Javier Campbell-chan (Level Design)";
    lblHel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    lblHel.position = CGPointMake(view.bounds.size.width / 2, (view.bounds.size.height / 2) - ((view.bounds.size.height / 10 ) * 3));
    lblHel.fontColor = [SKColor whiteColor];
    lblHel.zPosition = 1;
    
    [self addChild:background];
    [self addChild:arrow];
    [self addChild:frog];
    [self addChild:title];
    [self addChild:lblDev];
    [self addChild:lblAut];
    [self addChild:lblMsc];
    [self addChild:lblHel];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([[self childNodeWithName:@"arrow"] containsPoint:[[touches anyObject] locationInNode:self]])
    {
        MainMenu *menu = [[MainMenu alloc] initWithSize:self.size];
        SKTransition *transitionCrossFade = [SKTransition  revealWithDirection:SKTransitionDirectionUp duration:1.0];
        transitionCrossFade.pausesIncomingScene = TRUE;
        [[self view] presentScene:menu transition:transitionCrossFade];
    }
}

@end