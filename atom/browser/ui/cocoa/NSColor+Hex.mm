// Created by Mathias Leppich on 03/02/14.
// Copyright (c) 2014 Bit Bar. All rights reserved.
// Copyright (c) 2017 GitHub, Inc.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

#include "atom/browser/ui/cocoa/NSColor+Hex.h"

@implementation NSColor (Hex)

- (NSString*)RGBAValue {
  double redFloatValue, greenFloatValue, blueFloatValue, alphaFloatValue;
  int redIntValue, greenIntValue, blueIntValue, alphaIntValue;
  NSString *redHexValue, *greenHexValue, *blueHexValue, *alphaHexValue;

  NSColor* convertedColor =
      [self colorUsingColorSpaceName:NSCalibratedRGBColorSpace];

  if (convertedColor) {
    [convertedColor getRed:&redFloatValue
                     green:&greenFloatValue
                      blue:&blueFloatValue
                     alpha:&alphaFloatValue];

    redIntValue = redFloatValue * 255.99999f;
    greenIntValue = greenFloatValue * 255.99999f;
    blueIntValue = blueFloatValue * 255.99999f;
    alphaIntValue = alphaFloatValue * 255.99999f;

    redHexValue = [NSString stringWithFormat:@"%02x", redIntValue];
    greenHexValue = [NSString stringWithFormat:@"%02x", greenIntValue];
    blueHexValue = [NSString stringWithFormat:@"%02x", blueIntValue];
    alphaHexValue = [NSString stringWithFormat:@"%02x", alphaIntValue];

    return [NSString stringWithFormat:@"%@%@%@%@", redHexValue, greenHexValue,
                                      blueHexValue, alphaHexValue];
  }

  return nil;
}

- (NSString*)hexadecimalValue {
  double redFloatValue, greenFloatValue, blueFloatValue;
  int redIntValue, greenIntValue, blueIntValue;
  NSString *redHexValue, *greenHexValue, *blueHexValue;

  NSColor* convertedColor =
      [self colorUsingColorSpaceName:NSCalibratedRGBColorSpace];

  if (convertedColor) {
    [convertedColor getRed:&redFloatValue
                     green:&greenFloatValue
                      blue:&blueFloatValue
                     alpha:NULL];

    redIntValue = redFloatValue * 255.99999f;
    greenIntValue = greenFloatValue * 255.99999f;
    blueIntValue = blueFloatValue * 255.99999f;

    redHexValue = [NSString stringWithFormat:@"%02x", redIntValue];
    greenHexValue = [NSString stringWithFormat:@"%02x", greenIntValue];
    blueHexValue = [NSString stringWithFormat:@"%02x", blueIntValue];

    return [NSString
        stringWithFormat:@"#%@%@%@", redHexValue, greenHexValue, blueHexValue];
  }

  return nil;
}

+ (NSColor*)colorWithHexColorString:(NSString*)inColorString {
  unsigned colorCode = 0;
  unsigned char redByte, greenByte, blueByte;

  if (inColorString) {
    NSScanner* scanner = [NSScanner scannerWithString:inColorString];
    (void)[scanner scanHexInt:&colorCode];  // ignore error
  }
  redByte = (unsigned char)(colorCode >> 16);
  greenByte = (unsigned char)(colorCode >> 8);
  blueByte = (unsigned char)(colorCode);  // masks off high bits

  return [NSColor colorWithCalibratedRed:(CGFloat)redByte / 0xff
                                   green:(CGFloat)greenByte / 0xff
                                    blue:(CGFloat)blueByte / 0xff
                                   alpha:1.0];
}

@end
