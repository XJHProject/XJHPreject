//
//  ThemeProperties.h
//  neighborhood
//
//  Created by Yasin on 16/1/17.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#ifndef ThemeProperties_h
#define ThemeProperties_h

#define kMEThemeChangeNotification @"kMEThemeChangeNotificationName"
#define METhemeAnimationDuration 0.3

static NSString * ThemeTypeKey = @"ThemeType";

//背景颜色
static NSString * ViewBackgoundColor = @"ViewBackgoundColor";
//字体颜色
static NSString * CharacterColor = @"CharacterColor";
//tabbar背景色
static NSString * TabBarBackgroundColor=@"TabBarBackgroundColor";

//按钮状态字体颜色
static NSString * ButtonTypeColor = @"ButtonTypeColor";

//
static NSString * ThemeMode_Button_Sure = @"ThemeMode_Button_SureButton"; //

#define ThemeMode_Button_Sure_CapInsets UIEdgeInsetsMake(5, 5, 5, 5)
static NSString * ThemeMode_Button_NavBarRight = @"ThemeMode_Button_NavBarRight"; //
//快递，地址选择器，上部地址选择指示
static NSString * ThemeMode_Button_ExpressAddressSele = @"ThemeMode_Button_ExpressAddressSele";
//时间选择器的取消确定按钮
static NSString * ThemeModel_Button_PickerView = @"ThemeModel_Button_PickerView";


// color

// 工具租借， 我的工具租借 取消按钮
static NSString * ThemeMode_Color_ToolRental_MyToolRental_CancelButton = @"ThemeMode_Color_ToolRental_MyToolRental_CancelButton";
static NSString * ThemeMode_Color_LifeNumber_Label_CategoryItemHot = @"ThemeMode_Color_LifeNumber_Label_CategoryItemHot";

// page control
static NSString * ThemeMode_Color_UserGuide_PageControl_PageIndicatorColor = @"ThemeMode_Color_UserGuide_PageControl_PageIndicatorColor";
static NSString * ThemeMode_Color_UserGuide_PageControl_CurrentPageIndicatorColor = @"ThemeMode_Color_UserGuide_PageControl_CurrentPageIndicatorColor";

// chat
static NSString * ThemeMode_Color_Chat_MyMessage_ContentTextColor = @"ThemeMode_Color_Chat_MyMessage_ContentTextColor";

static NSString * ThemeMode_Color_BBS_Reply_Vest_Select_BackgroundColor = @"ThemeMode_Color_BBS_Reply_Vest_Select_BackgroundColor";

// StatusBarStyle
static NSString * ThemeMode_StatusBarStyle = @"StatusBarStyle";
static NSString * ThemeMode_StatusBarStyle_DefaultStyle = @"Default";
static NSString * ThemeMode_StatusBarStyleDefault = @"UIStatusBarStyleDefault";
static NSString * ThemeMode_StatusBarStyleLightContent = @"UIStatusBarStyleLightContent";

#endif /* ThemeProperties_h */
