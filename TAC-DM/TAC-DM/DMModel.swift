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
    
//    var socketServer:DMModel? = nil
    var socket:AsyncSocket? = nil
    var delegate:DMDelegate? = nil
    var sendData:NSData? = nil
    
//    func sharedSocketServer() -> DMModel {
//        if let server = socketServer {
//            return server
//        } else {
//            socketServer = DMModel()
//            return socketServer!
//        }
//    }
    //abandoned
    
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
        }
        catch{
            delegate?.getRequiredInfo("failed")
        }
        
        
    }
    
    //连接主机成功之后回调
    func onSocket(sock: AsyncSocket!, didConnectToHost host: String!, port: UInt16) {
        print("didConnectToHost:"+host+" through port:"+"\(port)")
        
        //通过定时器不断发送消息，来检测长连接
        delegate?.getRequiredInfo("connect successful!")
        socket?.writeData(sendData, withTimeout: -1, tag: 0)
    }
    
    
    //发送消息成功之后回调
    func onSocket(sock: AsyncSocket!, didWriteDataWithTag tag: Int) {
        print("write successful!")
        socket?.readDataWithTimeout(-1, tag: 0)
    }
    
    
    //接受消息成功之后回调
    func onSocket(sock: AsyncSocket!, didReadData data: NSData!, withTag tag: Int) {
        var msg = String.init(data: data, encoding: NSUTF8StringEncoding)
        msg = (msg! as NSString).substringWithRange(NSMakeRange(1, (msg! as NSString).length-2))
        delegate?.getRequiredInfo(msg!)
        socket?.disconnect()
    }
    
    //MARK:- functions
    func getDeviceList(type:String){
        let sendString = "[1|"+type+"]\r\n"
        sendData = sendString.dataUsingEncoding(NSUTF8StringEncoding)
        startConnectSocket()
        
    }
    
    func getRecordList(){
        let sendString = "[2]\r\n"
        sendData = sendString.dataUsingEncoding(NSUTF8StringEncoding)
        startConnectSocket()
    }
    
    func getDevice(itemId:String){
        let sendString = "[3|"+itemId+"]\r\n"
        sendData = sendString.dataUsingEncoding(NSUTF8StringEncoding)
        startConnectSocket()
    }
    
    func getRecordList(recordId:String){
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
    
    
    
    //    func SocketOpen(address:String, port:Int) -> Int {
    //
    //        return 0;
    //    }
    
    // 心跳连接
    //        func checkLongConnectByServe() {
    //
    //        }
    
    // 断开连接
    //    func cutOffSocket() {
    //
    //    }
    
    // Wi-Fi断开后断开socket
    //    func onSocket(sock:AsyncSocket, willDisconnectWithError err:NSError) {
    //
    //    }
    
    
    // 重新连接
    //    func onSocketDidDisconnect(sock:AsyncSocket) {
    //
    //    }
    
    // 发送消息
    //    func sendMessage(message:String) {
    //
    //    }
}
