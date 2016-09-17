//
//  GameScene.m
//  Hexagon
//
//  Created by Cheenar Gupte on 7/12/15.
//  Copyright (c) 2015 Chi Corp. All rights reserved.
//

#import "GameScene.h"
#import "LevelMenu.h"

#define MAX_LEVEL_CAP 15

@implementation GameScene

Level *level;
int curr_level;

-(instancetype) initWithSize:(CGSize)size andWithLevelID:(int)levelId
{
    self = [super initWithSize:size];
    if(self)
    {
        if(levelId > MAX_LEVEL_CAP)
        {
            curr_level = MAX_LEVEL_CAP;
        }
        else
        {
            curr_level = levelId;
        }
        
        //init
        self.backgroundColor = [UIColor colorWithRed:0 green:197 blue:233 alpha:1.0];
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"background.png"]];
        background.size = size;
        background.zPosition = 0;
        background.position = CGPointMake(self.size.width/2, self.size.height/2);
        background.name = @"BACKGROUND_IMG";
        [self addChild:background];
        
        level = [[Level alloc] initWithData:[NSArray arrayWithObjects: self, [NSString stringWithFormat:@"Level_%i", curr_level], nil]];
    }
    return self;
}

#pragma mark reset level code

-(void)resetLevel:(NSString *) lvl
{
    for(SKNode *node in self.children)
    {
       if(![node.name isEqualToString:@"BACKGROUND_IMG"])
       {
           [node runAction:[SKAction sequence:[NSArray arrayWithObjects:[SKAction removeFromParent], nil]]];
       }
    }
    level = [[Level alloc] initWithData:[NSArray arrayWithObjects: self, lvl, nil]];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    //detecting touch movements ;)
    UITouch *touch = [touches anyObject];
    
    if([[self childNodeWithName:@"reset"] containsPoint:[touch locationInNode:self]])
    {
        [self resetLevel:[NSString stringWithFormat:@"Level_%i", curr_level]];
    }
    
    if([[self childNodeWithName:@"home_button"] containsPoint:[touch locationInNode:self]])
    {
        LevelMenu *scene = [[LevelMenu alloc] initWithSize:self.view.bounds.size];
        SKTransition *transitionCrossFade = [SKTransition  revealWithDirection:SKTransitionDirectionUp duration:1.0];
        transitionCrossFade.pausesIncomingScene = TRUE;
        [[self view] presentScene:scene transition:transitionCrossFade];
    }
    
    if([level isLevelWon])
    {
        curr_level++;
        if(curr_level > MAX_LEVEL_CAP)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You've Tried to Call Another Level That Doesn't Exist!" message:@"Alert the shitty developer, he might fix it!" delegate:self cancelButtonTitle:@"K" otherButtonTitles:nil, nil];
            [alert show];
            curr_level--;
        }
        else
        {
            
            //draw the bo
            SKEffectNode *blurNode = [[SKEffectNode alloc] init];
            CIFilter *blur = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:@"inputRadius", @1.0f, nil];
            [blurNode setFilter:blur];
            [self addChild:blurNode];
            
            //add the screen to continue onto next level, limit the levels, add more levels and more level boxes, and make it gui
            
            
            //[self resetLevel:[NSString stringWithFormat:@"Level_%i", curr_level]]; //continues the game
        }
    }
    else
    {
        [level touchLogicWithTouch:touch];
    }
    
    if([level isLevelLost])
    {
        [self resetLevel:[NSString stringWithFormat:@"Level_%i", curr_level]];
    }
}

-(void)update:(CFTimeInterval)currentTime
{
}

@end
