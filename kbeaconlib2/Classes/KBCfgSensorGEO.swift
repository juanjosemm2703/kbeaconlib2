//
//  KBCfgSensorGeomagnetic.swift
//  KBeaconPro
//
//  Created by hogen hu on 2024/7/10.
//

import UIKit

public class KBCfgSensorGEO: KBCfgSensorBase {

    public static let MAX_PARKING_CHANGE_THD = 65535;
    public static let MIN_PARKING_CHANGE_THD = 100;
    public static let DEFAULT_PARKING_CHANGE_THD = 1000;
    
    public static let MAX_PARKING_DELAY_THD = 200;
    public static let MIN_PARKING_DELAY_THD = 1;
    public static let DEFAULT_PARKING_DELAY_THD = 9;
    
    public static let JSON_SENSOR_TYPE_GEO_PTHD = "pThd"

    public static let JSON_SENSOR_TYPE_GEO_PDLY = "pDly"
    
    public static let JSON_SENSOR_TYPE_GEO_TAG = "tag"
    
    public static let JSON_SENSOR_TYPE_GEO_FCL = "fcl"

    //measure interval
    var measureInterval: Int?
    
    //parking GEO sensor change threshold
    var parkingThreshold: Int?
    
    //parking delay
    var parkingDelay: Int?
    
    //idle parking tag
    var parkingTag: Int?
    
    //force GEO sensor calibration
    var calibration: Int?
    
    public required init()
    {
        super.init(sensorType:KBSensorType.GEO)
    }
    
    public func getParkingThreshold() -> Int {
        if let value = parkingThreshold {
            return value
        }
        return KBCfgSensorGEO.DEFAULT_PARKING_CHANGE_THD
    }
    
    @discardableResult public func setParkingThreshold(_ parkThd:Int) ->Bool{
        if (parkThd <= KBCfgSensorGEO.MAX_PARKING_CHANGE_THD
            && parkThd >= KBCfgSensorGEO.MIN_PARKING_CHANGE_THD)
        {
            parkingThreshold = parkThd
            return true
        }
        else
        {
            return false
        }
    }
    
    public func getPakingDelay() -> Int {
        if let value = parkingDelay {
            return value
        }
        return KBCfgSensorGEO.DEFAULT_PARKING_DELAY_THD
    }
    
    @discardableResult public func setParkingDelay(_ parkDly:Int) ->Bool{
        if (parkDly <= KBCfgSensorGEO.MAX_PARKING_DELAY_THD
            && parkDly >= KBCfgSensorGEO.MIN_PARKING_DELAY_THD)
        {
            parkingDelay = parkDly
            return true
        }
        else
        {
            return false
        }
    }
    
    public func isParkingTaged() -> Bool {
        return parkingTag == 1
    }
    
    public func setParkingTag(_ tag: Bool)
    {
        parkingTag = tag ? 1 : 0;
    }
    
    public func isCalibrated() -> Bool {
        return calibration == 1
    }
    
    public func setCalibration(_ forceCalibration: Bool)
    {
        calibration = forceCalibration ? 1 : 0;
    }

    public override func updateConfig(_ para: Dictionary<String, Any>) -> Int {
        var nUpdatePara = super.updateConfig(para)
        if let tempValue = para[KBCfgSensorBase.JSON_SENSOR_TYPE_MEASURE_INTERVAL] as? Int {
            measureInterval = tempValue
            nUpdatePara += 1
        }
        if let tempValue = para[KBCfgSensorGEO.JSON_SENSOR_TYPE_GEO_PTHD] as? Int {
            parkingThreshold = tempValue
            nUpdatePara += 1
        }
        if let tempValue = para[KBCfgSensorGEO.JSON_SENSOR_TYPE_GEO_PDLY] as? Int {
            parkingDelay = tempValue
            nUpdatePara += 1
        }
        if let tempValue = para[KBCfgSensorGEO.JSON_SENSOR_TYPE_GEO_TAG] as? Int {
            parkingTag = tempValue
            nUpdatePara += 1
        }
        if let tempValue = para[KBCfgSensorGEO.JSON_SENSOR_TYPE_GEO_FCL] as? Int {
            calibration = tempValue
            nUpdatePara += 1
        }
        return nUpdatePara
    }
    
    public override func toJsonObject() -> [String : Any] {
        return super.toJsonObject();
    }
    
    public override func toDictionary() -> Dictionary<String, Any> {
        var cfgDicts = super.toDictionary()

        if let tempValue = measureInterval {
            cfgDicts[KBCfgSensorBase.JSON_SENSOR_TYPE_MEASURE_INTERVAL]  = tempValue
        }
        if let tempValue =  parkingThreshold {
            cfgDicts[KBCfgSensorGEO.JSON_SENSOR_TYPE_GEO_PTHD] = tempValue
        }
        if let tempValue =  parkingDelay {
            cfgDicts[KBCfgSensorGEO.JSON_SENSOR_TYPE_GEO_PDLY] = tempValue
        }
        if let tempValue =  parkingTag {
            cfgDicts[KBCfgSensorGEO.JSON_SENSOR_TYPE_GEO_TAG] = tempValue
        }
        if let tempValue = calibration {
            cfgDicts[KBCfgSensorGEO.JSON_SENSOR_TYPE_GEO_FCL]  = tempValue
        }
        return cfgDicts
    }
}
