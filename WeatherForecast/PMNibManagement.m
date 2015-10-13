//
//  T2NibManagement.m
//  tele2
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//


#import "PMNibManagement.h"


@implementation UIView (PMNibManagement)

+ (instancetype)viewFromNib
{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
    id view = [nib instantiateWithOwner:nil options:nil].firstObject;
    NSAssert([view isKindOfClass:[self class]], @"Failed to load view from nib: %@", [self class]);
    return view;
}

@end


@implementation UITableView (PMNibManagement)

- (void)registerCellForClass:(Class)cellClass
{
    [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerCellNIBForClass:(Class)cellClass
{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerHeaderFooterViewForClass:(Class)headerFooterViewClass
{
    [self registerClass:headerFooterViewClass forHeaderFooterViewReuseIdentifier:NSStringFromClass(headerFooterViewClass)];
}

- (void)registerHeaderFooterViewNIBForClass:(Class)headerFooterViewClass
{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(headerFooterViewClass) bundle:nil];
    [self registerNib:nib forHeaderFooterViewReuseIdentifier:NSStringFromClass(headerFooterViewClass)];
}

- (id)dequeueReusableCellForClass:(Class)cellClass indexPath:(NSIndexPath *)indexPath
{
    return [self dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)
                                      forIndexPath:indexPath];
}

- (id)dequeueReusableHeaderFooterViewForClass:(Class)headerFooterViewClass
{
    return [self dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(headerFooterViewClass)];
}

@end


@implementation UICollectionView (PMNibManagement)

- (void)registerCellForClass:(Class)cellClass
{
    [self registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerCellNIBForClass:(Class)cellClass
{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil];
    [self registerNib:nib forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}

- (id)dequeueReusableCellForClass:(Class)cellClass indexPath:(NSIndexPath *)indexPath
{
    return [self dequeueReusableCellWithReuseIdentifier:NSStringFromClass(cellClass)
                                           forIndexPath:indexPath];
}

@end
