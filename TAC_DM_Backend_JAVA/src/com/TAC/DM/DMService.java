package com.TAC.DM;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.Socket;

import com.TAC.Model.DBQuerrier;

public class DMService implements Runnable {
	private Socket clientSocket;
	private BufferedReader in;
	private PrintWriter out;

	public DMService(Socket serviceSocket) {
		this.clientSocket = serviceSocket;
	}

	public String execute(String command) {
		String request = "";
		String result;
		try {
			request = command.substring(1, command.length() - 1);
			result = "";
			System.out.println(request);
			switch (request.split("|")[1]) {
			case "1":
				result = DBQuerrier.getDeviceList(request.substring(2));
				break;
			case "2":
				result = DBQuerrier.getRecordList();
				break;
			case "3":
				result = DBQuerrier.getDevice(request.substring(2));
				break;
			case "4":
				result = DBQuerrier.getRecord(request.substring(2));
				break;
			case "5":
				result = DBQuerrier.borrowItem(request.substring(2));
				break;
			case "6":
				result = DBQuerrier.returnItem(request.substring(2));
				break;
			case "7":
				result = DBQuerrier.adminLogin(request.substring(2));
				break;
			case "8":
				result = DBQuerrier.getDeviceListAsAdmin(request.substring(2));
				break;
			case "9":
				result = DBQuerrier.editLeftNumber(request.substring(2));
				break;

			default:
				result = DBQuerrier.wrongCode(request.substring(2));
				break;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "[]";
		}
		System.out.println(result);
		return result;
	}

	@Override
	public void run() {
		// TODO Auto-generated method stub
		try {
			// TODO Auto-generated method stub
			System.out.println("---start Service----");
			in = new BufferedReader(new InputStreamReader(
					clientSocket.getInputStream()));
			out = new PrintWriter(new BufferedWriter(new OutputStreamWriter(
					clientSocket.getOutputStream())), true);
			String request = "";
			while (true) {
				String str = in.readLine();
				request = request + str;
				System.out.println(request);
				if (request.contains("]")) {
					System.out.println("Request:" + str);
					// out.println("Request:" + str);
					String resultString = execute(request);
					out.println(resultString);
					out.flush();
					break;
				}
				// else { // closeconnection
				// System.out.println("read nulg and out");
				// break;
				// }
			}
			out.close();
			in.close();
			clientSocket.close();

			// Close the connection, but not the server socket
			System.out.println("--end service--");
		} catch (IOException e) {
			System.out.println(e.getMessage());

		}
	}
}
