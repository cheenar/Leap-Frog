//
//  LevelMenu.m
//  Hexagon
//
//  Created by Cheenar Gupte on 7/19/15.
//  Copyright (c) 2015 Chi Corp. All rights reserved.
//

#import "LevelMenu.h"
#import "Level.h"
#import "GameScene.h"
#import "MainMenu.h"

#define  MAX_LEVEL_CAP 15 //CHANGE THIS TO THE MAX LEVEL CAP IN THE OTHER FILE

#define page_count 1

#define level_height 3
#define level_width 5

@implementation LevelMenu

NSMutableArray *levelDesign;
NSMutableArray *pages;
int currPage = 1;

-(void)didMoveToView:(SKView *)view
{
    SKSpriteNode *home_button = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"home_button.png"]];
    [home_button setScale:0.03];
    home_button.name = @"home_button";
    home_button.zPosition = 10;
    home_button.position = CGPointMake(30, view.frame.size.height - 30);
    [self addChild:home_button];
    
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"background.png"]];
    [background setSize:view.bounds.size];
    background.zPosition = 1;
    background.position = CGPointMake(self.size.width/2, self.size.height/2);
    background.name = @"BACKGROUND_IMG";
    [self addChild:background];
    
    SKLabelNode *lblDev = [SKLabelNode labelNodeWithFontNamed:@"Heiti TC"];
    lblDev.fontSize = 32;
    lblDev.text = @"Levels";
    lblDev.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    lblDev.position = CGPointMake(view.bounds.size.width / 2, view.bounds.size.height - (view.bounds.size.height / 5));
    lblDev.fontColor = [SKColor whiteColor];
    lblDev.zPosition = 2;
    
    [self addChild:lblDev];
    
    levelDesign = [NSMutableArray array];
    pages = [NSMutableArray array];
    
    for(int i = 0; i < level_width * level_height; i++)
    {
        [levelDesign addObject:@"X"];
    }
    
    [self changePage:1];
    [self drawLevelSelector];
}

-(void)drawLevel:(int)lvlInt
{
    double screen_height = self.size.height;
    double screen_width = self.size.width;
    
    SKSpriteNode *temp_sprite = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"lily_1"]];
    [temp_sprite setScale:0.05];
    temp_sprite.name = @"bg_player";
    
    long Y_POS = (screen_height - (level_height * temp_sprite.size.height)) / 1.75;
    
    for(int i = 0; i < level_height; i++)
    {
        //long X_POS = (screen_width -  (level_width * temp_sprite.size.width)) / 1.75;
        long X_POS = (screen_width - (level_width * temp_sprite.size.width)) / 1.20;
        
        if(i > 0)
        {
            Y_POS = Y_POS + temp_sprite.size.height;
        }
        
        for(int j = 0; j < level_width; j++)
        {
            
            if(j > 0)
            {
                //X_POS = X_POS + temp_sprite.size.width;
                X_POS = X_POS - temp_sprite.size.width;
            }
            if((lvlInt <= MAX_LEVEL_CAP))
            {
                T_Type block_type = NORMAL;
                Tile *tile = [[Tile alloc] initWithScene:self andWithType:block_type andWithPos:CGPointMake(X_POS, Y_POS + 7.5)];
                [tile._tile_obj_node runAction:[SKAction setTexture:[SKTexture textureWithImageNamed:@"lily_1.png"]]];
                [tile._tile_obj_node setAlpha:1];
                [tile._tile_obj_node setName:@"Tile"];
                
                SKLabelNode *lbl = [SKLabelNode labelNodeWithText:[NSString stringWithFormat:@"%i", lvlInt]];
                lbl.position = CGPointMake(X_POS, Y_POS);
                lbl.fontName = @"MarkerFelt";
                [lbl setName:[NSString stringWithFormat:@"Level_%i", lvlInt]];
                lbl.zPosition = 10;
                lbl.fontSize = 16;
                
                [self addChild:lbl];
                [self addChild:tile._tile_obj_node];
            }
            
            lvlInt--;
            
            //[pages addObject:[NSArray arrayWithObjects:lbl, tile, nil]];
        }
    }
}

-(void) drawLevelSelector
{
    int pageInt = 1;
    
    for(int i = 0 ; i < page_count; i++)
    {
        SKSpriteNode *pageBtn = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"lily_1.png"]];
        pageBtn.name = [NSString stringWithFormat:@"Page_%i", pageInt];
        pageBtn.position = CGPointMake(((self.frame.size.width/(page_count+2)) * (i+1)) + (self.frame.size.width/(page_count+4)), 40);
        [pageBtn setScale:0.05f];
        pageBtn.zPosition = 10;
        
        SKLabelNode *lbl = [SKLabelNode labelNodeWithText:[NSString stringWithFormat:@"%i", pageInt]];
        lbl.position = CGPointMake(pageBtn.position.x, pageBtn.position.y - 10);
        lbl.fontName = @"MarkerFelt";
        [lbl setName:[NSString stringWithFormat:@"Page_%i", pageInt]];
        lbl.zPosition = 11;
        lbl.fontSize = 16;
        
        [self addChild:pageBtn];
        [self addChild:lbl];
        
        pageInt++;
    }
}

-(void)changePage:(int)ide
{
    for(SKNode *node in self.children)
    {
        if([node.name containsString:@"Tile"] || [node.name containsString:@"Level"])
        {
            [node removeFromParent];
        }
    }
    [self drawLevel:ide*15];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([[self childNodeWithName:@"home_button"] containsPoint:[[touches anyObject] locationInNode:self]])
    {
        MainMenu *scene = [[MainMenu alloc] initWithSize:self.frame.size];
        SKTransition *transitionCrossFade = [SKTransition revealWithDirection:SKTransitionDirectionUp duration:1.0];
        transitionCrossFade.pausesIncomingScene = TRUE;
        [[self view] presentScene:scene transition:transitionCrossFade];
    }
    for(SKNode *node in self.children)
    {
        if([node.name containsString:@"Level_"])
        {
            UITouch *touch = [touches anyObject];
            if([node containsPoint:[touch locationInNode:self]])
            {
                int level_id = (int)[[[node.name componentsSeparatedByString:@"_"] objectAtIndex:1] integerValue];
                GameScene *scene = [[GameScene alloc] initWithSize:self.frame.size andWithLevelID:level_id];
                SKTransition *transitionCrossFade = [SKTransition revealWithDirection:SKTransitionDirectionUp duration:1.0];
                transitionCrossFade.pausesIncomingScene = TRUE;
                [[self view] presentScene:scene transition:transitionCrossFade];
            }
        }
        if([node.name containsString:@"Page_"])
        {
            UITouch *touch = [touches anyObject];
            if([node containsPoint:[touch locationInNode:self]])
            {
                int pgID = (int)[[[node.name componentsSeparatedByString:@"_"] objectAtIndex:1] integerValue];
                if(pgID != currPage)
                {
                    currPage = pgID;
                }
                [self changePage:currPage];
            }
        }
    }
}

@end
