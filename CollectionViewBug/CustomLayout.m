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

+(CGSize)itemSize{
    return CGSizeMake(834, 1079.2941176470588);
}

-(CGSize)collectionViewContentSize{
    return CGSizeMake(CGRectGetWidth([[self collectionView] bounds]), [[self class] itemSize].height * 20);
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

- (void)prepareLayout
{
    if(!_cache){
        _cache = [NSMutableArray array];
        CGFloat yOffset = 0;

        CGSize itemSize = [[self class] itemSize];

        for (NSInteger row=0; row<20; row++) {
            UICollectionViewLayoutAttributes *itemAttrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
            
            CGRect frame = CGRectMake(0, yOffset, itemSize.width, itemSize.height);

            // The bug appears when either:
            //
            // A. the frame.origin.x has a tiny tiny offset from zero
//            frame.origin.x =  -0.00000000000011368683772161603;

            [itemAttrs setFrame:frame];

            // or B.
            // the item has been rotated 180 degrees.
            // this rotate often creates the tiny offset
            // on the frame's origin.x
            [itemAttrs setTransform:CGAffineTransformMakeRotation(M_PI)];
            
            yOffset += CGRectGetHeight(frame);

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
