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
  static String PortName = "/dev/ttyUSB0";
  static BufferedReader in_stream = 
          new BufferedReader(new InputStreamReader(System.in));

  
  static void printHelp()
  {
    System.out.println("Help for test program.");
    System.out.println("q: quit from program.");
    System.out.println("c: connect serial port.");
    System.out.println("d: disconect serial port.");
  }
  
  /**
   * @param args the command line arguments
   */
  public static void main(String[] args) {
    // TODO code application logic here
  SerialComm Comm = new SerialComm();
  boolean kilep = false;
/*  if (Comm.connect(PortName, 9600))
  {
    Comm.start();
  } else
  {
    System.out.println("Cannot connect port");
    System.exit(-1);
  }*/
    try{
    while (!kilep)
    {
      printHelp();      
      input = in_stream.readLine();
      System.out.print("Input: ");    
      System.out.print(input);
    
				if (input.equals("q")) {
					System.out.println("Example terminated");
//					Comm.disconnect();
					System.exit(0);   
        }
        if (input.equals("c")) {
          if (!Comm.isConnected())
          {
            if (Comm.connect(PortName, 9600))
            {
//              Comm.Start();
            } else
            {
              System.out.println("Cannot connect port.");
              System.exit(-1);
            }
          } else
          {
            System.out.println("Port already connected.");
            System.exit(-1);            
          }
        }
        if (input.equals("d")) {
          if (Comm.isConnected())
          {
            if (Comm.disconnect())
            {
            
            } else
            {
              System.out.println("Cannot disconnect port.");
              System.exit(-1);
            }
          } else
          {
            System.out.println("Port isn't connected.");
            System.exit(-1);            
          }
        }
        if (input.equals("s")) {
          Comm.Start();
        };
        if (input.equals("a")) {
          Comm.Stop();
        };
    }
  } catch (IOException e) {
				System.out.println("There was an input error\n");
				System.exit(1);}
  };
}
