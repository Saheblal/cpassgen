/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package testserial;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.util.*;          // A soros portok listájához

/**
 *
 * @author bekeband
 */
public class TestSerial {

  static String input;
  static BufferedReader in_stream = 
          new BufferedReader(new InputStreamReader(System.in));
  
  /**
   * @param args the command line arguments
   */
  public static void main(String[] args) {
    // TODO code application logic here
  SerialComm Comm = new SerialComm();
  if (Comm.connect("/dev/ttyUSB0", 9600))
  {
    Comm.start();
  } else
  {
    System.out.println("Cannot connect port");
    System.exit(-1);
  }
    try{
    input = in_stream.readLine();
				if (input.equals("q")) {
					System.out.println("example terminated\n");
					Comm.disconnect();
					System.exit(0);   
        }
      
  } catch (IOException e) {
				System.out.println("there was an input error\n");
				System.exit(1);}
  };
}
