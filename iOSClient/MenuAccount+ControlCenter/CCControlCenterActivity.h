//
//  CCControlCenterActivity.h
//  Nextcloud
//
//  Created by Marino Faggiana on 01/03/17.
//  Copyright © 2017 TWS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCControlCenterActivity : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property NSUInteger pageIndex;
@property (nonatomic, strong) NSString *pageType;

- (void)reloadDatasource;

@end
