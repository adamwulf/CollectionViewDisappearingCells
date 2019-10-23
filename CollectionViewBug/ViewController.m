//
//  ViewController.m
//  CollectionViewBug
//
//  Created by Adam Wulf on 10/23/19.
//  Copyright © 2019 Milestone Made. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    [self.collectionView setBackgroundColor:[UIColor lightGrayColor]];

    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    UILabel *lbl;
    
    [cell setBackgroundColor:[UIColor whiteColor]];
    [[cell layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[cell layer] setBorderWidth:1];
    
    if(![[[cell contentView] subviews] count]){
        lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 400, 400)];
        [lbl setFont:[UIFont systemFontOfSize:90]];
        [lbl setAutoresizingMask:UIViewAutoresizingNone];
        [[cell contentView] addSubview:lbl];
    }else{
        lbl = (UILabel*)[[[cell contentView] subviews] firstObject];
    }
    
    [lbl setText:[NSString stringWithFormat:@"%@,%@", @(indexPath.section), @(indexPath.row)]];

    return cell;
}

@end
