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
    
    var socketServer:DMModel? = nil
    var socket:AsyncSocket? = nil
    var delegate:DMDelegate? = nil
    var sendData:NSData? = nil
    
    func sharedSocketServer() -> DMModel {
        if let server = socketServer {
            return server
        } else {
            socketServer = DMModel()
            return socketServer!
        }
    }
    
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
    
    //
    func SocketOpen(address:String, port:Int) -> Int {
        
        return 0;
    }
    
    //这是异步返回的连接成功
    func onSocket(sock: AsyncSocket!, didConnectToHost host: String!, port: UInt16) {
        print("didConnectToHost:"+host+" through port:"+"\(port)")
        
        //通过定时器不断发送消息，来检测长连接
        delegate?.getRequiredInfo("connect successful!")
        socket?.writeData(sendData, withTimeout: -1, tag: 0)
    }
    
    // 心跳连接
    func checkLongConnectByServe() {
        
    }
    
    // 断开连接
    func cutOffSocket() {
        
    }
    
    // Wi-Fi断开后断开socket
    func onSocket(sock:AsyncSocket, willDisconnectWithError err:NSError) {
        
    }
    
    
    // 重新连接
    func onSocketDidDisconnect(sock:AsyncSocket) {
        
    }
    
    // 发送消息
    func sendMessage(message:String) {
        
    }
    
    //发送消息成功之后回调
    func onSocket(sock: AsyncSocket!, didWriteDataWithTag tag: Int) {
        print("wrtie successful!")
        socket?.readDataWithTimeout(-1, tag: 0)
    }
    
    
    //接受消息成功之后回调
    func onSocket(sock: AsyncSocket!, didReadData data: NSData!, withTag tag: Int) {
        let msg = String.init(data: data, encoding: NSUTF8StringEncoding)
        delegate?.getRequiredInfo(msg!)
        socket?.disconnect()
    }
    
    //MARK:- functions
    func getDeviceList(type:String){
        let sendString = "[1|"+type+"]\r\n"
        sendData = sendString.dataUsingEncoding(NSUTF8StringEncoding)
        startConnectSocket()
        
    }
}
