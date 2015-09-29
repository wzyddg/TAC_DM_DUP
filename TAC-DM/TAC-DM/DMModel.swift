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

class DMModel: NSObject, AsyncSocketDelegate {
    
    var socket:AsyncSocket? = nil
    var delegate:DMDelegate? = nil
    var sendData:NSData? = nil
    
    static func getInstance()->DMModel{
        let instance = DMModel()
        return instance;
    }
    //use this for future singleton
    
    func startConnectSocket() {
        self.socket = AsyncSocket()
        socket?.setDelegate(self)
        
        if(socket==nil){
            socket = AsyncSocket()
        }
        do{
            try socket!.connectToHost("10.60.41.55", onPort: 8222)
            print("已发送连接请求")
        } catch {
            delegate?.getRequiredInfo("failed")
            print("连接失败")
        }
        
        
    }
    
    //连接主机成功之后回调
    func onSocket(sock: AsyncSocket!, didConnectToHost host: String!, port: UInt16) {
        print("didConnectToHost:"+host+" through port:"+"\(port)")
                
        //向服务器写入数据
        socket?.writeData(sendData, withTimeout: -1, tag: 0)
    }
    
    
    //发送消息成功之后回调
    func onSocket(sock: AsyncSocket!, didWriteDataWithTag tag: Int) {
        print("data write successful!")
        
        //向服务器请求数据?
        socket?.readDataWithTimeout(-1, tag: 0)
    }
    
    
    //接受消息成功之后回调
    func onSocket(sock: AsyncSocket!, didReadData data: NSData!, withTag tag: Int) {
        var msg = String.init(data: data, encoding: NSUTF8StringEncoding)
        msg = (msg! as NSString).substringWithRange(NSMakeRange(1, (msg! as NSString).length-3))
        delegate?.getRequiredInfo(msg!)
        socket?.disconnect()
        }
    
    //MARK:- functions
    func getDeviceList(type:String){
        let sendString = "[1|"+type+"]\r\n"
        sendData = sendString.dataUsingEncoding(NSUTF8StringEncoding)
        startConnectSocket()
        
    }
    
    //借东西历史记录
    func getRecordList(){
        let sendString = "[2]\r\n"
        sendData = sendString.dataUsingEncoding(NSUTF8StringEncoding)
        startConnectSocket()
    }
    
    //根据设备号得到设备详情
    func getDevice(itemId:String){
        let sendString = "[3|"+itemId+"]\r\n"
        sendData = sendString.dataUsingEncoding(NSUTF8StringEncoding)
        startConnectSocket()
    }
    
    //具体某一次借东西的详细情况
    func getRecord(recordId:String){
        let sendString = "[4|"+recordId+"]\r\n"
        sendData = sendString.dataUsingEncoding(NSUTF8StringEncoding)
        startConnectSocket()
    }
    
    //借用者名字,借用者电话,借用物Id,借用物名称,借用物描述,借用数量
    func borrowItem(borrowerName:String , tele:String , itemId:String , itemName:String , itemDescription:String , number:Int){

        var sendString = "[5|"+borrowerName+","+tele+","
        sendString += itemId+","+itemName+","+itemDescription+",\(number)]\r\n"
        sendData = sendString.dataUsingEncoding(NSUTF8StringEncoding)
        startConnectSocket()
    }
    
    func returnItem(recordId:String){
        let sendString = "[6|"+recordId+"]\r\n"
        sendData = sendString.dataUsingEncoding(NSUTF8StringEncoding)
        startConnectSocket()
    }
    
    func adminLogin(password:String){
        let sendString = "[7|"+password+"]\r\n"
        sendData = sendString.dataUsingEncoding(NSUTF8StringEncoding)
        startConnectSocket()
    }
    
    func getDeviceListAsAdmin(type:String){
        let sendString = "[8|"+type+"]\r\n"
        sendData = sendString.dataUsingEncoding(NSUTF8StringEncoding)
        startConnectSocket()
    }
    
    func editLeftNumber(itemId:String , newCount:Int , password:String){
        let sendString = "[9|"+itemId+",\(newCount)]\r\n"
        sendData = sendString.dataUsingEncoding(NSUTF8StringEncoding)
        startConnectSocket()
    }
    
    func getDeviceType() {
        let sendString = "[A]\r\n"
        sendData = sendString.dataUsingEncoding(NSUTF8StringEncoding)
        startConnectSocket()
    }
    
}
