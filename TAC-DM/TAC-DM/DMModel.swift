//
//  DMModel.swift
//  TAC-DM
//
//  Created by Shepard Wang on 15/9/21.
//  Copyright © 2015年 TAC. All rights reserved.
//



import Foundation

protocol DMDelegate:NSObjectProtocol{
    //回调方法
    func getRequiredInfo(Info:String)
}

class DatabaseModel:NSObject, GCDAsyncSocketDelegate {
    var gcdSocket:GCDAsyncSocket? = nil
    var delegate:DMDelegate? = nil
    var sendData:NSData? = nil
    var needConnect = true
    static var serverIP = "115.28.74.242"
    
    static func getInstance() -> DatabaseModel {
        let instance = DatabaseModel()
        
        return instance
    }
    
    func setupGCDConnection() {
        if (nil == gcdSocket) {
            gcdSocket = GCDAsyncSocket(delegate: self, delegateQueue: dispatch_get_main_queue())
        }
        do {
            try gcdSocket!.connectToHost(DatabaseModel.serverIP , onPort: 8222)
            print("GCD请求已发送")
        } catch {
            delegate?.getRequiredInfo("GCD failed")
            print("GCD连接失败")
        }
        needConnect = true
    }
    
    func isGCDConnecting() ->Bool {
        if let socket = gcdSocket {
            return socket.isConnected
        } else {
            return false
        }
    }
    
    func disGCDConnetion() {
        gcdSocket?.disconnect()
    }
    
    func getGCDConnection() {
        if !isGCDConnecting() {
            self.disGCDConnetion()
            
            self.setupGCDConnection()
        }
    }
    
    //连接主机成功之后回调
    func socket(sock: GCDAsyncSocket!, didConnectToHost host: String!, port: UInt16) {
        print("didConnectToHost:"+host+" through port:"+"\(port)")
        
        self.listenData()
    }
    
    //发送消息成功之后回调
    func socket(sock: GCDAsyncSocket!, didWriteDataWithTag tag: Int) {
        gcdSocket?.readDataWithTimeout(-1, tag: 0)
    }
    
    //接受消息成功之后回调
    func socket(sock: GCDAsyncSocket!, didReadData data: NSData!, withTag tag: Int) {
        var msg = String.init(data: data, encoding: NSUTF8StringEncoding)
        msg = (msg! as NSString).substringWithRange(NSMakeRange(1, (msg! as NSString).length-3))
        self.listenData()
        delegate?.getRequiredInfo(msg!)
        self.disGCDConnetion()
    }
    
    func socket(sock: GCDAsyncSocket!, didReadPartialDataOfLength partialLength: UInt, tag: Int) {
        print("LENGTH:\(partialLength)")
    }
    
    func socketDidDisconnect(sock: GCDAsyncSocket!, withError err: NSError!) {
        gcdSocket?.disconnect()
    }
    
    func listenData() {
        gcdSocket?.readDataToData(GCDAsyncSocket.LFData(), withTimeout: -1, tag: 1)
    }

    //MARK:- functions
    func getDeviceList(type:String){
        self.getGCDConnection()
        let sendString = "[1|\(type)]\r\n"
        sendData = sendString.dataUsingEncoding(NSUTF8StringEncoding)

        gcdSocket?.writeData(sendData, withTimeout: 20, tag: 1)
    }
    
    func getTypeList(type:String) {
        self.getGCDConnection()
        let sendString = "[1|\(type)]\r\n"
        sendData = sendString.dataUsingEncoding(NSUTF8StringEncoding)
        
        gcdSocket?.writeData(sendData, withTimeout: 20, tag: 1)
    }
    
    //借东西历史记录
    func getRecordList(){
        self.getGCDConnection()

        let sendString = "[2]\r\n"
        sendData = sendString.dataUsingEncoding(NSUTF8StringEncoding)
        
        gcdSocket?.writeData(sendData, withTimeout: 20, tag: 1)
    }
    
    //根据设备号得到设备详情
    func getDevice(itemId:String){
        self.getGCDConnection()

        let sendString = "[3|\(itemId)]\r\n"
        sendData = sendString.dataUsingEncoding(NSUTF8StringEncoding)
        
        gcdSocket?.writeData(sendData, withTimeout: 20, tag: 1)
    }
    
    //具体某一次借东西的详细情况
    func getRecord(recordId:String){
        self.getGCDConnection()

        let sendString = "[4|\(recordId)]\r\n"
        sendData = sendString.dataUsingEncoding(NSUTF8StringEncoding)
        
        gcdSocket?.writeData(sendData, withTimeout: 20, tag: 1)
    }
    
    //借用者名字,借用者电话,借用物Id,借用物名称,借用物描述,借用数量
    func borrowItem(borrowerName:String , tele:String , itemId:String , itemName:String , itemDescription:String , number:Int){
        self.getGCDConnection()
        let sendString = "[5|\(borrowerName),\(tele),\(itemId),\(itemName),\(itemDescription),\(number)]\r\n"
        sendData = sendString.dataUsingEncoding(NSUTF8StringEncoding)
        
        gcdSocket?.writeData(sendData, withTimeout: 20, tag: 1)
    }
    
    func returnItem(recordId:String){
        self.getGCDConnection()
        let sendString = "[6|\(recordId)]\r\n"
        sendData = sendString.dataUsingEncoding(NSUTF8StringEncoding)
        
        gcdSocket?.writeData(sendData, withTimeout: 20, tag: 1)
    }
    
    func adminLogin(password:String){
        self.getGCDConnection()

        let sendString = "[7|\(password)]\r\n"
        sendData = sendString.dataUsingEncoding(NSUTF8StringEncoding)
        
        gcdSocket?.writeData(sendData, withTimeout: 20, tag: 1)
    }
    
    func getDeviceListAsAdmin(type:String){
        self.getGCDConnection()

        let sendString = "[8|\(type)]\r\n"
        sendData = sendString.dataUsingEncoding(NSUTF8StringEncoding)
        
        gcdSocket?.writeData(sendData, withTimeout: 20, tag: 1)
    }
    
    func editLeftNumber(itemId:String , newCount:Int , password:String){
        self.getGCDConnection()

        let sendString = "[9|\(itemId),\(newCount)]\r\n"
        sendData = sendString.dataUsingEncoding(NSUTF8StringEncoding)
        
        gcdSocket?.writeData(sendData, withTimeout: 20, tag: 1)
    }
    
    func getDeviceType() {
        self.getGCDConnection()

        let sendString = "[A]\r\n"
        sendData = sendString.dataUsingEncoding(NSUTF8StringEncoding)
        
        gcdSocket?.writeData(sendData, withTimeout: 20, tag: 1)
    }
    
    func addNewItem(itemName:String, discription itemDesc:String, type itemType:String, count itemCount:String) {
        self.getGCDConnection()

        let sendString = "[B|\(itemName),\(itemDesc),\(itemType),\(itemCount)]\r\n"
        sendData = sendString.dataUsingEncoding(NSUTF8StringEncoding)
        
        gcdSocket?.writeData(sendData, withTimeout: 20, tag: 1)
    }
    

    
}
