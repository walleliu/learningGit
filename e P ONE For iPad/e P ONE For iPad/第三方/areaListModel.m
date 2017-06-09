//
//  areaListModel.m
//  e P ONE For iPad
//
//  Created by wall-e on 2017/5/16.
//  Copyright © 2017年 wall-e. All rights reserved.
//

#import "areaListModel.h"

@implementation areaListModel

-(void)setTemp:(NSString *)temp{
    if (_temp!=temp) {
        _temp = temp;
        _tempPercent = round(([_temp floatValue]+10)/60*100)/100;
    }
}
-(void)setHumi:(NSString *)humi{
    if (_humi!= humi) {
        _humi = humi;
        _humiPercent = round(([_humi floatValue])/100*100)/100;
    }
}
-(void)setHcho:(NSString *)hcho{
    if (_hcho!= hcho) {
        _hcho = hcho;
        _hchoPercent = round(([_hcho floatValue])/500*100)/100;
    }
}

-(void)setCo2:(NSString *)co2{
    if (_co2!= co2) {
        _co2 = co2;
        _co2Percent = round(([_co2 floatValue])/5000*100)/100;
    }
}
-(void)setVoc:(NSString *)voc{
    if (_voc!= voc) {
        _voc = voc;
        _vocPercent = round(([_voc floatValue])/6*100)/100;
    }
}
-(void)setPm25:(NSString *)pm25{
    if (_pm25!= pm25) {
        _pm25 = pm25;
        if ([_pm25 integerValue] == 0) {
            _pm25Percent =0;
        }else{
            if ([_pm25 integerValue] < 50) {
                _pm25Percent = 0.01;
            }else{
                _pm25Percent = round(([_pm25 floatValue])/500*100)/100;
            }
        }
        
        
    }
}
-(void)setPm10:(NSString *)pm10{
    if (_pm10!= pm10) {
        _pm10 = pm10;
        if ([_pm10 integerValue] == 0) {
            _pm10Percent = 0;
        }else{
            if ([_pm10 integerValue] < 30) {
                _pm10Percent = 0.01;
            }else{
                _pm10Percent = round(([_pm10 floatValue])/300*100)/100;
            }
        }
        
        
    }
}
@end
