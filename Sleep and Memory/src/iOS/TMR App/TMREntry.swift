//
//  TMREntry.swift
//  TMR App
//
//  Created by Robert Zhang on 6/15/17.
//  Copyright © 2017 iLaunch. All rights reserved.
//

import Foundation
import SpriteKit

class TMREntry {
    private var soundimageIndex:Int = 0
    private var positionX:Int = 5
    private var positionY:Int = 5
    private var isTargeted:Bool = false
    private var baseSoundName:String = "baseline.wave"
    private var baseSoundNickName:String = "baseline.wave"
    
    //Stats
    //1
    private var distance1:Float = 0
    private var distancePercent1:Float = 0
    private var distanceCM1:Float = 0
    private var timeBegin1:String = ""
    private var timeBegin1Date:Date = Date()
    private var reactionTime1:Float = 0
    private var x1:Int = 0
    private var y1:Int = 0
    private var isCorrect1:Bool = false
    
    //2
    private var distance2:Float = 0
    private var distancePercent2:Float = 0
    private var distanceCM2:Float = 0
    private var timeBegin2:String = ""
    private var timeBegin2Date:Date = Date()
    private var reactionTime2:Float = 0
    private var x2:Int = 0
    private var y2:Int = 0
    private var isCorrect2:Bool = false
    
    //pre
    private var distanceBeforeSleep:Float = 0
    private var distancePercentBeforeSleep:Float = 0
    private var distanceCMBeforeSleep:Float = 0
    private var reactionTimeBeforeSleep:Float = 0
    private var timeBeginBeforeSleep:String = ""
    private var timeBeginBeforeSleepDate:Date = Date()
    private var xBeforeSleep:Int = 0
    private var yBeforeSleep:Int = 0
    private var isCorrectBeforeSleep:Bool = false
    
    //post
    private var distanceAfterSleep:Float = 0
    private var distancePercentAfterSleep:Float = 0
    private var distanceCMAfterSleep:Float = 0
    private var timeBeginAfterSleep:String = ""
    private var timeBeginAfterSleepDate:Date = Date()
    private var reactionTimeAfterSleep:Float = 0
    private var xAfterSleep:Int = 0
    private var yAfterSleep:Int = 0
    private var isCorrectAfterSleep:Bool = false
    
    init(resourceEntryIndex : Int) {
        soundimageIndex = resourceEntryIndex
        positionX = 5
        positionY = 5
        isTargeted = false
        isCorrectBeforeSleep  = false
        isCorrectAfterSleep  = false
    }
    
    init() {
        
    }
    
    func toJSON() -> [String:Any] {
        var dictionary: [String : Any] = [:]
        
        dictionary["soundImageIndex"] = "\(self.soundimageIndex)"
        dictionary["positionX"] = "\(self.positionX)"
        dictionary["positionY"] = "\(self.positionY)"
        if ( self.isTargeted ) {
            dictionary["isTargeted"] = "True"
        }
        else {
            dictionary["isTargeted"] = "False"
        }
        if ( self.isCorrectBeforeSleep ) {
            dictionary["isCorrectBeforeSleep"] = "True"
        }
        else {
            dictionary["isCorrectBeforeSleep"] = "False"
        }
        if ( self.isCorrectAfterSleep ) {
            dictionary["isCorrectAfterSleep"] = "True"
        }
        else {
            dictionary["isCorrectAfterSleep"] = "False"
        }
        dictionary["distanceBeforeSleep"] = "\(self.distanceBeforeSleep)"
        dictionary["distanceAfterSleep"] = "\(self.distanceAfterSleep)"
        dictionary["distancePercentBeforeSleep"] = "\(self.distancePercentBeforeSleep)"
        dictionary["distancePercentAfterSleep"] = "\(self.distancePercentAfterSleep)"
        dictionary["baseSoundName"] = self.baseSoundName
        dictionary["baseSoundNickName"] = self.baseSoundNickName
        return dictionary
    }
    
    func fromJson (dictionary : [String : Any]) {
        var stringNum : String = dictionary["soundImageIndex"] as! String
        var num : Int = Int(stringNum)!
        self.soundimageIndex = num
        stringNum = dictionary["positionX"] as! String
        num = Int(stringNum)!
        self.positionX = num
        stringNum = dictionary["positionY"] as! String
        num = Int(stringNum)!
        self.positionY = num
        stringNum = dictionary["isTargeted"] as! String
        if stringNum == "True" {
            self.isTargeted = true
        }
        else {
            self.isTargeted = false
        }
        stringNum = dictionary["isCorrectBeforeSleep"] as! String
        if stringNum == "True" {
            self.isCorrectBeforeSleep = true
        }
        else {
            self.isCorrectBeforeSleep = false
        }
        stringNum = dictionary["isCoorectAfterSleep"] as! String
        if stringNum == "True" {
            self.isCorrectAfterSleep = true
        }
        else {
            self.isCorrectAfterSleep = false
        }
        stringNum = dictionary["distanceBeforeSleep"] as! String
        var numFloat:Float = Float(stringNum)!
        self.distanceBeforeSleep = numFloat
        stringNum = dictionary["distanceAfterSleep"] as! String
        numFloat = Float(stringNum)!
        self.distanceAfterSleep = numFloat
        stringNum = dictionary["distancePercentBeforeSleep"] as! String
        numFloat = Float(stringNum)!
        self.distancePercentBeforeSleep = numFloat
        stringNum = dictionary["distancePercentAfterSleep"] as! String
        numFloat = Float(stringNum)!
        self.distancePercentAfterSleep = numFloat
        stringNum = dictionary["baseSoundName"] as! String
        self.baseSoundName = stringNum
    }
    
    
    func getBaseSound() -> URL? {
        if let path = Bundle.main.path(forResource: baseSoundName, ofType:nil) {
            return URL(fileURLWithPath: path)
        }
        print("getAudioURL: \(baseSoundName)")
        return nil
    }
    
    func setBaseSoundNickname(_ index: Int){
        baseSoundNickName = TMRSoundImage.nickNames[index]
    }
    
    func getBaseSoundNickname()->String{
        return baseSoundNickName
    }
    
    func getBaseSoundName() -> String {
        return baseSoundName
    }
    
    func setBaseSoundName(baseSoundName : String) {
        self.baseSoundName = baseSoundName
    }
    
    //1
    func getDistance1() -> Float {
        return distance1
    }
    func setDistance1(distance1 : Float) {
        self.distance1 = distance1
    }
    func getDistancePercent1() -> Float {
        return distancePercent1
    }
    func setDistancePercent1(distancePercent1 : Float) {
        self.distancePercent1 = distancePercent1
    }
    func getDistanceCM1() -> Float {
        return distanceCM1
    }
    func setDistanceCM1(distanceCM1 : Float) {
        self.distanceCM1 = distanceCM1
    }
    func getTimeBegin1() -> String{
        return timeBegin1
    }
    func getTimeBegin1() -> Date{
        return timeBegin1Date
    }
    func setTimeBegin1(time:Date){
        let formatter:DateFormatter = DateFormatter();
        formatter.dateFormat = "MM/dd/yyyy HH:mm:ss";
        formatter.timeZone = TimeZone.current
        let str = formatter.string(from: time);
        timeBegin1 = str
        timeBegin1Date = time
    }

    func getReactionTime1()->Float{
        return reactionTime1
    }
    func setReactionTime1(time:Float){
        reactionTime1 = time
    }
    func getX1()->Int{
        return x1
    }
    func setX1(x:Int){
        x1 = x
    }
    func getY1()->Int{
        return y1
    }
    func setY1(y:Int){
        y1 = y
    }
    func getIsCorrect1()->Bool{
        return isCorrect1
    }
    func setIsCorrect1(correct:Bool){
        isCorrect1 = correct
    }
    
    //2
    func getDistance2() -> Float {
        return distance2
    }
    func setDistance2(distance2 : Float) {
        self.distance2 = distance2
    }
    func getDistancePercent2() -> Float {
        return distancePercent2
    }
    func setDistancePercent2(distancePercent2 : Float) {
        self.distancePercent2 = distancePercent2
    }
    func getDistanceCM2() -> Float {
        return distanceCM2
    }
    func setDistanceCM2(distanceCM2 : Float) {
        self.distanceCM2 = distanceCM2
    }
    func getTimeBegin2() -> String{
        return timeBegin2
    }
    func getTimeBegin2() -> Date{
        return timeBegin2Date
    }
    func setTimeBegin2(time:Date){
        let formatter:DateFormatter = DateFormatter();
        formatter.dateFormat = "MM/dd/yyyy HH:mm:ss";
        formatter.timeZone = TimeZone.current
        let str = formatter.string(from: time);
        timeBegin2 = str
        timeBegin2Date = time
    }
    func getReactionTime2()->Float{
        return reactionTime2
    }
    func setReactionTime2(time:Float){
        reactionTime2 = time
    }
    func getX2()->Int{
        return x2
    }
    func setX2(x:Int){
        x2 = x
    }
    func getY2()->Int{
        return y2
    }
    func setY2(y:Int){
        y2 = y
    }
    func getIsCorrect2()->Bool{
        return isCorrect2
    }
    func setIsCorrect2(correct:Bool){
        isCorrect2 = correct
    }
    
    //pre
    func getDistanceBeforeSleep() -> Float {
        return distanceBeforeSleep
    }
    func setDistanceBeforeSleep(distanceBeforeSleep : Float) {
        self.distanceBeforeSleep = distanceBeforeSleep
    }
    func getDistancePercentBeforeSleep() -> Float {
        return distancePercentBeforeSleep
    }
    func setDistancePercentBeforeSleep(distancePercentBeforeSleep : Float) {
        self.distancePercentBeforeSleep = distancePercentBeforeSleep
    }
    func getDistanceCMBeforeSleep() -> Float {
        return distanceCMBeforeSleep
    }
    func setDistanceCMBeforeSleep(distanceCMBeforeSleep : Float) {
        self.distanceCMBeforeSleep = distanceCMBeforeSleep
    }
    func getTimeBeginBeforeSleep() -> String{
        return timeBeginBeforeSleep
    }
    func getTimeBeginBeforeSleep() -> Date{
        return timeBeginBeforeSleepDate
    }
    func setTimeBeginBeforeSleep(time:Date){
        let formatter:DateFormatter = DateFormatter();
        formatter.dateFormat = "MM/dd/yyyy HH:mm:ss";
        formatter.timeZone = TimeZone.current
        let str = formatter.string(from: time);
        timeBeginBeforeSleep = str
        timeBeginBeforeSleepDate = time
    }
    func getReactionTimeBeforeSleep()->Float{
        return reactionTimeBeforeSleep
    }
    func setReactionTimeBeforeSleep(time:Float){
        reactionTimeBeforeSleep = time
    }
    func getXBeforeSleep()->Int{
        return xBeforeSleep
    }
    func setXBeforeSleep(x:Int){
        xBeforeSleep = x
    }
    func getYBeforeSleep()->Int{
        return yBeforeSleep
    }
    func setYBeforeSleep(y:Int){
        yBeforeSleep = y
    }
    
    
    //post
    func getDistanceAfterSleep() -> Float {
        return distanceAfterSleep
    }
    func setDistanceAfterSleep(distanceAfterSleep : Float) {
        self.distanceAfterSleep = distanceAfterSleep
    }
    func getDistancePercentAfterSleep() -> Float {
        return distancePercentAfterSleep
    }
    func setDistancePercentAfterSleep(distancePercentAfterSleep : Float) {
        self.distancePercentAfterSleep = distancePercentAfterSleep
    }
    func getDistanceCMAfterSleep() -> Float {
        return distanceCMAfterSleep
    }
    func setDistanceCMAfterSleep(distanceCMAfterSleep : Float) {
        self.distanceCMAfterSleep = distanceCMAfterSleep
    }
    func getTimeBeginAfterSleep() -> String{
        return timeBeginAfterSleep
    }
    func getTimeBeginAfterSleep() -> Date{
        return timeBeginAfterSleepDate
    }
    func setTimeBeginAfterSleep(time:Date){
        let formatter:DateFormatter = DateFormatter();
        formatter.dateFormat = "MM/dd/yyyy HH:mm:ss";
        formatter.timeZone = TimeZone.current
        let str = formatter.string(from: time);
        timeBeginAfterSleep = str
        timeBeginAfterSleepDate = time
    }
    func getReactionTimeAfterSleep()->Float{
        return reactionTimeAfterSleep
    }
    func setReactionTimeAfterSleep(time:Float){
        reactionTimeAfterSleep = time
    }
    func getXAfterSleep()->Int{
        return xAfterSleep
    }
    func setXAfterSleep(x:Int){
        xAfterSleep = x
    }
    func getYAfterSleep()->Int{
        return yAfterSleep
    }
    func setYAfterSleep(y:Int){
        yAfterSleep = y
    }
    
    
    func getSoundImageIndex() -> Int {
        return soundimageIndex;
    }
    
    func setSoundImageIndex(soundimageIndex : Int) {
        self.soundimageIndex = soundimageIndex
    }
    
    func getPositionX() -> Int {
        return positionX
    }
    
    func setPositionX(x : Int) {
        positionX = x
    }
    
    func getPositionY() -> Int {
        return positionY
    }

    func setPositionY(y : Int) {
        positionY = y
    }
    
    func getPosition() -> (Int, Int) {
        return (positionX, positionY)
    }
    
    func setPosition(posX : Int, posY : Int) {
        positionX = posX
        positionY = posY
    }
    
    func getIsTargeted() -> Bool {
        return isTargeted
    }
    
    func getIsCorrectBeforeSleep() -> Bool {
        return isCorrectBeforeSleep
    }

    func getIsCorrectAfterSleep() -> Bool {
        return isCorrectAfterSleep
    }
    
    func setIsTargeted(isTargeted : Bool) {
        self.isTargeted = isTargeted    }
    
    func setIsCorrectBeforeSleep(isCorrectBeforeSleep: Bool) {
        self.isCorrectBeforeSleep = isCorrectBeforeSleep
    }
    
    func setIsCorrectAfterSleep(isCorrectAfterSleep : Bool) {
        self.isCorrectAfterSleep = isCorrectAfterSleep
    }

}
