//
//  CCPageMenuItem.m
//  CCPageViewController
//
//  Created by 詹林 on 16/8/12.
//  Copyright © 2016年 AOLC. All rights reserved.
//

#import "CCPageMenuItem.h"

#define DEFAULT_TITLE_FONTSIZE 15
#define DEFAULT_TITLE_SELECTED_FONTSIZE 15
#define DEFAULT_TITLE_COLOR [UIColor blackColor]
#define DEFAULT_TITLE_SELECTED_COLOR [UIColor orangeColor]

#define HORIZONTAL_MARGIN 10

@interface CCPageMenuItem ()

@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) CGFloat fontSize;
@property (assign, nonatomic) CGFloat selectedFontSize;
@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) UIColor *selectedColor;

@end

@implementation CCPageMenuItem

#pragma mark - Lifecircle

- (instancetype) init {
    if (self = [super init]) {
        _fontSize = DEFAULT_TITLE_FONTSIZE;
        _selectedFontSize = DEFAULT_TITLE_SELECTED_FONTSIZE;
        _color = DEFAULT_TITLE_COLOR;
        _selectedColor = DEFAULT_TITLE_SELECTED_COLOR;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        [self addGestureRecognizer:tap];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGFloat titleX = (CGRectGetWidth(self.frame) - [self titleSize].width) * 0.5;
    CGFloat titleY = (CGRectGetHeight(self.frame) - [self titleSize].height) * 0.5;
    
    CGRect titleRect = CGRectMake(titleX, titleY, [self titleSize].width, [self titleSize].height);
    NSDictionary *attributes = @{NSFontAttributeName : [self titleFont], NSForegroundColorAttributeName : [self titleColor]};
    [_title drawInRect:titleRect withAttributes:attributes];
}

#pragma mark - Custom Accessors

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    [self setNeedsDisplay];
}

#pragma mark - Public

- (void)setItemTitle:(NSString *)title {
    _title = title;
    [self setNeedsDisplay];
}

- (void)setItemTitleFont:(CGFloat)fontSize {
    _fontSize = fontSize;
    [self setNeedsDisplay];
}

- (void)setItemSelectedTileFont:(CGFloat)fontSize {
    _selectedFontSize = fontSize;
    [self setNeedsDisplay];
}

- (void)setItemTitleColor:(UIColor *)color {
    _color = color;
    [self setNeedsDisplay];
}

- (void)setItemSelectedTitleColor:(UIColor *)color {
    _selectedColor = color;
    [self setNeedsDisplay];
}

#pragma mark - Private

- (CGSize)titleSize {
    NSDictionary *attributes = @{NSFontAttributeName : [self titleFont]};
    CGSize size = [_title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    size.width = ceil(size.width);
    size.height = ceil(size.height);
    
    return size;
}

- (UIFont *)titleFont {
    UIFont *font;
    if (_selected) {
        font = [UIFont boldSystemFontOfSize:_selectedFontSize];
    } else {
        font = [UIFont systemFontOfSize:_fontSize];
    }
    return font;
}

- (UIColor *)titleColor {
    UIColor *color;
    if (_selected) {
        color = _selectedColor;
    } else {
        color = _color;
    }
    return color;
}

- (CGFloat) widthForTitle {
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:_fontSize]};
    CGSize size = [_title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    size.width = ceil(size.width) + HORIZONTAL_MARGIN * 2;
    return size.width;
}
- (void) onTap:(UITapGestureRecognizer *) gestureRecognizer {
    self.selected = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuItemSelected:)]) {
        [self.delegate menuItemSelected:self];
    }
}
@end
