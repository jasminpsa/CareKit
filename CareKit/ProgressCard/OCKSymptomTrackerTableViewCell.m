/*
 Copyright (c) 2016, Apple Inc. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 
 1.  Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 2.  Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation and/or
 other materials provided with the distribution.
 
 3.  Neither the name of the copyright holder(s) nor the names of any contributors
 may be used to endorse or promote products derived from this software without
 specific prior written permission. No license is granted to the trademarks of
 the copyright holders even if such marks are included in this software.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


#import "OCKSymptomTrackerTableViewCell.h"


const static CGFloat TopMargin = 30.0;
const static CGFloat BottomMargin = 30.0;
const static CGFloat ValueLabelWidth = 100.0;

@implementation OCKSymptomTrackerTableViewCell {
    UILabel *_titleLabel;
    UILabel *_textLabel;
    UILabel *_valueLabel;
    UILabel *_unitLabel;
    NSMutableArray *_constraints;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self prepareView];
    }
    return self;
}

- (void)setAssessmentEvent:(OCKCarePlanEvent *)assessmentEvent {
    _assessmentEvent = assessmentEvent;
    self.tintColor = _assessmentEvent.activity.tintColor;
    [self prepareView];
}

- (void)prepareView {
    [super prepareView];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        [self addSubview:_titleLabel];
    }
    
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_textLabel];
    }
    
    if (!_valueLabel) {
        _valueLabel = [UILabel new];;
        _valueLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_valueLabel];
    }
    
    [self updateView];
    [self setUpConstraints];
}

- (void)updateView {
    _titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    _titleLabel.text = _assessmentEvent.activity.title;
    
    _textLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    _textLabel.text = _assessmentEvent.activity.text;
    
    _valueLabel.text = (_assessmentEvent.result.valueString.length > 0) ? _assessmentEvent.result.valueString : @"";
    _valueLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleTitle1];
    _valueLabel.textColor = _assessmentEvent.activity.tintColor;
    
    if (_assessmentEvent.result.unitString.length > 0) {
        if (!_unitLabel) {
            _unitLabel = [UILabel new];
            _unitLabel.textAlignment = NSTextAlignmentRight;
            _unitLabel.textColor = [UIColor lightGrayColor];
            [self addSubview:_unitLabel];
        }
        _unitLabel.text = _assessmentEvent.result.unitString;
        _unitLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
    } else {
        [_unitLabel removeFromSuperview];
        _unitLabel = nil;
    }
}

- (void)setUpConstraints {
    [NSLayoutConstraint deactivateConstraints:_constraints];
    
    _constraints = [NSMutableArray new];
    
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _valueLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGFloat LeadingMargin = self.separatorInset.left;
    CGFloat TrailingMargin = (self.separatorInset.right > 0) ? self.separatorInset.right + 25 : 30;
    
    CGFloat unitLabelOffset = 0;
    
    if (_unitLabel) {
        _unitLabel.translatesAutoresizingMaskIntoConstraints = NO;
        unitLabelOffset = 10;
        
        [_constraints addObjectsFromArray:@[
                                            [NSLayoutConstraint constraintWithItem:_unitLabel
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:_valueLabel
                                                                         attribute:NSLayoutAttributeBottom
                                                                        multiplier:1.0
                                                                          constant:0.0],
                                            [NSLayoutConstraint constraintWithItem:_unitLabel
                                                                         attribute:NSLayoutAttributeTrailing
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:_valueLabel
                                                                         attribute:NSLayoutAttributeTrailing
                                                                        multiplier:1.0
                                                                          constant:0.0]
                                            ]];
    }

    [_constraints addObjectsFromArray:@[
                                        [NSLayoutConstraint constraintWithItem:_titleLabel
                                                                     attribute:NSLayoutAttributeLeading
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeLeading
                                                                    multiplier:1.0
                                                                      constant:LeadingMargin],
                                        [NSLayoutConstraint constraintWithItem:_titleLabel
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:TopMargin],
                                        [NSLayoutConstraint constraintWithItem:_textLabel
                                                                     attribute:NSLayoutAttributeLeading
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:_titleLabel
                                                                     attribute:NSLayoutAttributeLeading
                                                                    multiplier:1.0
                                                                      constant:0.0],
                                        [NSLayoutConstraint constraintWithItem:_textLabel
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:_titleLabel
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1.0
                                                                      constant:0.0],
                                        [NSLayoutConstraint constraintWithItem:_textLabel
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1.0
                                                                      constant:-BottomMargin],
                                        [NSLayoutConstraint constraintWithItem:_valueLabel
                                                                     attribute:NSLayoutAttributeTrailing
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeTrailing
                                                                    multiplier:1.0
                                                                      constant:-TrailingMargin],
                                        [NSLayoutConstraint constraintWithItem:_valueLabel
                                                                     attribute:NSLayoutAttributeWidth
                                                                     relatedBy:NSLayoutRelationLessThanOrEqual
                                                                        toItem:nil
                                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                                    multiplier:1.0
                                                                      constant:ValueLabelWidth],
                                        [NSLayoutConstraint constraintWithItem:_valueLabel
                                                                     attribute:NSLayoutAttributeCenterY
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeCenterY
                                                                    multiplier:1.0
                                                                      constant:-unitLabelOffset]
                                        ]];
    
    [NSLayoutConstraint activateConstraints:_constraints];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setUpConstraints];
}

@end