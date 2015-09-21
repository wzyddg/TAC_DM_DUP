package com.TAC.DM;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

public class DMMainServer {
	public DMMainServer() {
		// TODO Auto-generated constructor stub
		
		System.out.println(System.getProperty("file.encoding")); //GBK
		System.out.println(System.getProperty("user.language")); //zh
		System.out.println(System.getProperty("user.region")); //CN
		
		try {
			// Create socket for TCP
			ServerSocket server = new ServerSocket(8222);	//822 means 'TACB'ackend in 9-button keypad
			//ChatServiceServer.setUserList(thread我当时就懵逼了List);
			System.out.println("TAC-DM Server Start, waitng on Port 8222...");
			
			while (true) {
				//Second socket for data 
				Socket client = server.accept();
				DMService service=new DMService(client);
				Thread serviceThread = new Thread(service);
				serviceThread.start();
			}
			
		} catch (IOException ioe) {
			System.out.println(ioe);
		}

	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		DMMainServer server = new DMMainServer();
	}

}
