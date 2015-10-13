//
//  T2NibManagement.h
//  tele2
//
//  Created by Antol Peshkov on 12.10.15.
//  Copyright © 2015 Perpetuum Mobile lab. All rights reserved.
//


@import UIKit;


@interface UIView (PMNibManagement)

+ (instancetype)viewFromNib;

@end


@interface UITableView (PMNibManagement)

- (void)registerCellForClass:(Class)cellClass;
- (void)registerCellNIBForClass:(Class)cellClass;
- (void)registerHeaderFooterViewForClass:(Class)headerFooterViewClass;
- (void)registerHeaderFooterViewNIBForClass:(Class)headerFooterViewClass;
- (id)dequeueReusableCellForClass:(Class)cellClass indexPath:(NSIndexPath *)indexPath;
- (id)dequeueReusableHeaderFooterViewForClass:(Class)cellClass;
@end


@interface UICollectionView (PMNibManagement)

- (void)registerCellForClass:(Class)cellClass;
- (void)registerCellNIBForClass:(Class)cellClass;
- (id)dequeueReusableCellForClass:(Class)cellClass indexPath:(NSIndexPath *)indexPath;

@end
