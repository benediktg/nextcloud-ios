//
//  MWCaptionView.m
//  MWPhotoBrowser
//
//  Created by Michael Waterfall on 30/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MWCommon.h"
#import "MWCaptionView.h"
#import "MWPhoto.h"

static const CGFloat labelPadding = 10;

//TWS Private
/*
@interface MWCaptionView () {
    id <MWPhoto> _photo;
    UILabel *_label;    
}
@end
*/

@implementation MWCaptionView

- (id)initWithPhoto:(id<MWPhoto>)photo {
    self = [super initWithFrame:CGRectMake(0, 0, 320, 44)]; // Random initial frame
    if (self) {
        self.userInteractionEnabled = NO;
        _photo = photo;
        self.barStyle = UIBarStyleDefault; //TWS
        self.tintColor = nil;
        self.barTintColor = nil;
        self.barStyle = UIBarStyleDefault; //TWS
        [self setBackgroundImage:nil forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        [self setupCaption];
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat maxHeight = 9999;
    if (_label.numberOfLines > 0) maxHeight = _label.font.leading*_label.numberOfLines;
    
    //CGSize textSize = [_label.text boundingRectWithSize:CGSizeMake(size.width - labelPadding*2, maxHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_label.font} context:nil].size;
    
    //return CGSizeMake(size.width, textSize.height + labelPadding * 2);
    
    //TWS
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) return CGSizeMake(size.width, 50);
    else return CGSizeMake(size.width, 49);

}

- (void)setupCaption {
    _label = [[UILabel alloc] initWithFrame:CGRectIntegral(CGRectMake(labelPadding, 0,
                                                       self.bounds.size.width-labelPadding*2,
                                                       self.bounds.size.height))];
    _label.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _label.opaque = NO;
    _label.backgroundColor = [UIColor clearColor];
    _label.textAlignment = NSTextAlignmentLeft;
    _label.lineBreakMode = NSLineBreakByWordWrapping;

    _label.numberOfLines = 0;
    _label.textColor = COLOR_TEXT_ANTHRACITE;
    _label.font = [UIFont systemFontOfSize:12];
    if ([_photo respondsToSelector:@selector(caption)]) {
        _label.text = [_photo caption] ? [_photo caption] : @" ";
    }
    [self addSubview:_label];
}


@end
