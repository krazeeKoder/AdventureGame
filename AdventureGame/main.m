//
//  main.m
//  AdventureGame

#import <Foundation/Foundation.h>
#import "GameController.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        GameController *game = [[GameController alloc] init];
        
        [game printPath];

            NSLog(@"Welcome to Adventure game! You can see your path above.  Move by type main or side");
            char pathChoice[255];
            fgets(pathChoice, 255, stdin);
            NSString *direction = [NSString stringWithUTF8String:pathChoice];
            direction = [direction stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            [game moveDirection:direction];
            
        
    }
    return 0;
}
