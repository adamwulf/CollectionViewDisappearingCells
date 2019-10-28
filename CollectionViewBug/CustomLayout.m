//
//  CustomLayout.m
//  CollectionViewBug
//
//  Created by Adam Wulf on 10/23/19.
//  Copyright © 2019 Milestone Made. All rights reserved.
//

#import "CustomLayout.h"

@implementation CustomLayout{
    NSMutableArray<UICollectionViewLayoutAttributes*>*_cache;
}

-(CGSize)collectionViewContentSize{
    return CGSizeMake(1962.7766201843365, 49674.129492655797);
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

- (void)prepareLayout
{
    if(!_cache){
        _cache = [NSMutableArray array];
        
        NSMutableArray *frames = [NSMutableArray array];
        [frames addObject:@(CGRectMake(280.3966600263337,-220.3966600263337,595.7142857142858,834))];
        [frames addObject:@(CGRectMake(0,1461.983300131669,834,1167.6))];
        [frames addObject:@(CGRectMake(0,4209.87056838974,834,1167.6))];
        [frames addObject:@(CGRectMake(0,6957.75783664781,834,1167.6))];
        [frames addObject:@(CGRectMake(0,9705.645104905881,834,1167.6))];
        [frames addObject:@(CGRectMake(280.3966600263337,12173.13571313762,595.7142857142858,834))];
        [frames addObject:@(CGRectMake(0,13855.51567329562,834,1167.6))];
        [frames addObject:@(CGRectMake(0,16603.40294155369,834,1167.6))];
        [frames addObject:@(CGRectMake(0,19351.29020981176,834,1167.6))];
        [frames addObject:@(CGRectMake(0,22099.17747806983,834,1167.6))];
        [frames addObject:@(CGRectMake(280.3966600263337,24566.66808630157,595.7142857142858,834))];
        [frames addObject:@(CGRectMake(0,26249.04804645957,834,1167.6))];
        [frames addObject:@(CGRectMake(0,28996.93531471764,834,1167.6))];
        [frames addObject:@(CGRectMake(0,31744.82258297571,834,1167.6))];
        [frames addObject:@(CGRectMake(0,34492.70985123378,834,1167.6))];
        [frames addObject:@(CGRectMake(280.3966600263337,36960.20045946552,595.7142857142858,834))];
        [frames addObject:@(CGRectMake(0,38642.58041962352,834,1167.6))];
        [frames addObject:@(CGRectMake(0,41390.46768788159,834,1167.6))];
        [frames addObject:@(CGRectMake(0,44138.35495613966,834,1167.6))];
        [frames addObject:@(CGRectMake(0,46886.24222439773,834,1167.6))];

        CGFloat scale = 2.353449184873305;
        
        for (NSInteger row=0; row<20; row++) {
            UICollectionViewLayoutAttributes *itemAttrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
            CGRect frame = [[frames objectAtIndex:row] CGRectValue];

            frame.origin.x = round(frame.origin.x);
            frame.origin.y = round(frame.origin.y);
            frame.size.width = round(frame.size.width);
            frame.size.height = round(frame.size.height);

            [itemAttrs setFrame:frame];

            CGSize itemSize = frame.size;

            CGAffineTransform transform = CGAffineTransformTranslate(CGAffineTransformScale(CGAffineTransformMakeTranslation(-itemSize.width/2, -itemSize.height/2), scale, scale), itemSize.width/2, itemSize.height/2);

            if(row % 5 == 0){
                transform = CGAffineTransformRotate(transform, M_PI_2);
            }
            
            [itemAttrs setAlpha:1];
            [itemAttrs setHidden:NO];
            [itemAttrs setTransform:transform];
            
            [_cache addObject:itemAttrs];
        }
    }
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *ret = [_cache filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id _Nullable obj, NSDictionary<NSString *, id> *_Nullable bindings) {
        return CGRectIntersectsRect([obj frame], rect);
    }]];
    
    NSLog(@"layoutAttributesForElementsInRect: %@,%@,%@,%@", @(rect.origin.x), @(rect.origin.y), @(rect.size.width), @(rect.size.height));
    for (UICollectionViewLayoutAttributes*attrs in ret) {
        NSLog(@" - %@,%@", @([[attrs indexPath] section]), @([[attrs indexPath] row]));
    }
    
    return ret;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    for (UICollectionViewLayoutAttributes *attrs in _cache) {
        if ([attrs representedElementCategory] == UICollectionElementCategoryCell && [[attrs indexPath] isEqual:indexPath]) {
            return attrs;
        }
    }

    return nil;
}

@end
