//
//  DBModel.swift
//  TAC-DM
//
//  Created by teng on 8/24/15.
//  Copyright (c) 2015 TAC. All rights reserved.
//
//  BorrowInfo Manage functions

import Foundation

class SocketManager: AsyncSocketDelegate {
    
    var socketServer:SocketManager? = nil
    var socket:AsyncSocket? = nil;
    
    func sharedSocketServer() -> SocketManager {
        if let server = socketServer {
            return server
        } else {
            socketServer = SocketManager()
            return socketServer!
        }
    }
    
    func startConnectSocket() {
        self.socket = AsyncSocket()
        
       // self.socket!.setRunLoopModes()
        
        
    }
    
    //
    func SocketOpen(address:String, port:Int) -> Int {
        
        return 0;
    }
    
    //
    func onSocket(sock:AsyncSocket, didConnectToHost host:String, port:Int16) {
        //这是异步返回的连接成功
        print("didConnectToHost")
        
        //通过定时器不断发送消息，来检测长连接
        
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
    func onSocket(sock:AsyncSocket, didWriteDataWithTag tag:Double) {
        
    }
    
    
    //接受消息成功之后回调
    func onSocket(sock:AsyncSocket, didReadData data:NSData, withTag tag:Double) {
        
    }
    
    
}