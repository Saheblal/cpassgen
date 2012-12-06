
/* SerialComm communication class.
 * Used to simplify communication over a Serial port. Using the RXTX-library
 * (rxtx.qbang.org), one connection per instance of this class can be handled.
 * In addition to handling a connection, information about the available Serial
 * ports can be received using this class.
 * A separate {@link Thread} is started to handle messages that are being
 * received over the Serial interface.
 * A time of {@link chartime} is determine the one char's sending time. 
 * This depending the baud rate, and total bitnumber. 
 * The (@link timeout} will be calculate of this value.
 * @author Beke András (beke.andras.mkolc@gmail.com)
 * Thanks for Raphael Blatter (raphael@blatter.sg)
 * @author heavily using code examples from the RXTX-website (rxtx.qbang.org)
 */

package testserial;

import gnu.io.*;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.*;



public class SerialComm extends Thread {
    
  int ImageSize = 1000;
  
	private InputStream inputStream;
	private OutputStream outputStream;

  /*
   * Data transmission type:
   * 
   */
  
/** 
* If data transmission distinguish two consecutive packages from time of 
* received characters.
* long StartTime
* long StopTime
*/
  
 private long StartTime;  // received character time (nanosec)
 private long StopTime;   // next received character time (nanosec)

/**
  * Serial protocol class.
  */ 
 
//  private VProtocolClass Protocol;
 
/* The status of the connection. {@link connected}*/
  
	private boolean connected = false;
  
/* One character's xfer time in nanosecundum. {@link chartime}*/
  
  private double chartime;
  
/* The Thread used to receive the data from the Serial interface. */
  
//	private Thread reader;
/* The opened SerialPort object for RXTX library */
	private SerialPort serialPort;
  
/* Communicating between threads, showing the {@link #reader} when the
	 connection has been closed, so it can {@link Thread#join()}.*/
  
	private boolean end = false;
  
/* Debugger class for the in/out datas inspecting. */  
 	private DebugContact contact;

/*
   * ProcessImage object
   */
  
  ProcessImage Image;
  
/*
   * @TODO id must be declared, and used. (@link Serial class id.)
   */
	public SerialComm() {
    contact = new DebugContact();
	}
  
/**
	 * This method is used to get a list of all the available Serial ports
	 * (note: only Serial ports are considered). Any one of the elements
	 * contained in the returned {@link List} can be used as a parameter in
	 * {@link #connect(String)} or {@link #connect(String, int)} to open a
	 * Serial connection.
	 * 
	 * @return A {@link List} containing {@link String}s showing all available
	 *         Serial ports.
	 */
  
	@SuppressWarnings("unchecked")
	public List<String> getPortList() {
		Enumeration<CommPortIdentifier> portList;
		List<String> portVect = new LinkedList<String>();
		portList = CommPortIdentifier.getPortIdentifiers();

		CommPortIdentifier portId;
		while (portList.hasMoreElements()) {
			portId = (CommPortIdentifier) portList.nextElement();
			if (portId.getPortType() == CommPortIdentifier.PORT_SERIAL) {
				portVect.add(portId.getName());
			}
		}
		contact.writeLog("found the following ports:");
		for (int i = 0; i < portVect.size(); i++) {
			contact.writeLog(("   " + (String) portVect.get(i)));
		}
		return portVect;
	}

  /**
   * float CalculateDataTime(int speed, int databits, int stopbits, boolean parity)
   * Calculate the one data time (in nanosecundum)
   * @param speed 
   *    The transmitting speed.
   * @param databits  
   *    The data bits number
   * @parem stopbits
   *    The stop bits number
   * @parem parity
   *    Parity
   * @return
   *    Return time in nanosec
   */
  
  private float CalculateDataTime(int speed, int databits, int stopbits, 
          int parity) {
  int parity_bit; float stop_bit; 
  if (parity != 0) parity_bit = 1; else parity_bit = 1;
  switch (stopbits) {
    case SerialPort.STOPBITS_1: stop_bit = 1; break;
    case SerialPort.STOPBITS_1_5: stop_bit = (float)1.5; break;
    case SerialPort.STOPBITS_2: stop_bit = 2; break;
    default: stop_bit = 0;
  } 
    return (1000000/speed) * (databits + stop_bit + parity_bit);
  };
  
	/**
	 * {@link #connect(String, int)}
	 * 
	 * @param portName
	 *            The name of the port the connection should be opened to (see
	 *            {@link #getPortList()}).
   * @param speed
   *  Baud rate.
   * @param databits
   *  Databits number
   * @param stopbits
   *  Stopbits number
   * @param parity
   *  Parity or not.
	 * @return <b>true</b> if the connection has been opened successfully,
	 *         <b>false</b> otherwise.
	 * @see #connect(String)
	 */
  
	public boolean connect(String portName, int speed, int databits, int stopbits,
          int parity) {
		CommPortIdentifier portIdentifier;
		boolean conn = false;
    Image = new ProcessImage(ImageSize);
		try {
			portIdentifier = CommPortIdentifier.getPortIdentifier(portName);
			if (portIdentifier.isCurrentlyOwned()) {
        
				contact.writeLog("Error: Port is currently in use");
			} else {
        /*
         * Calculate a data time.
         */
        chartime = CalculateDataTime(speed, databits, stopbits, parity);
				serialPort = (SerialPort) portIdentifier.open("RTBug_network",
						2000);
				serialPort.setSerialPortParams(speed, databits, stopbits, parity);

				inputStream = serialPort.getInputStream();
				outputStream = serialPort.getOutputStream();
        this.start();
				connected = true;
				contact.writeLog("connection on " + portName + " established");
				contact.writeLog("Data time of (nanosec) = " + chartime);
        // TODO !! must be taken in case cycle, depending required protocol.
//        Protocol = new MBASCII(); // Only test !!!!!!!!!!
        // -------------------------------------------------------------
				conn = true;
			}
		} catch (NoSuchPortException e) {
			contact.writeLog("NoSuchPortException");
			e.printStackTrace(System.out);
		} catch (PortInUseException e) {
			contact.writeLog("PortInUseException");
			e.printStackTrace(System.out);
		} catch (UnsupportedCommOperationException e) {
			contact.writeLog("UnsupportedCommOperationException");
			e.printStackTrace(System.out);
		} catch (IOException e) {
			contact.writeLog("IOException");
			e.printStackTrace(System.out);
		}
		return conn;
	}
  
/**
* connect(String portName)
* Serial connect with standard parameters 
* @param portName 
*   PortName string
* @param speed
*   Baud rate.
* @return <b>true</b> if the connection has been opened successfully,
*         <b>false</b> otherwise.
* @see connect(String, int, int, int, int) 
*/  
  
	public boolean connect(String portName, int speed) {
    return this.connect(portName, speed, SerialPort.DATABITS_8, 
      SerialPort.STOPBITS_1, SerialPort.PARITY_NONE);
  } 
    
  public void run()
  {
    contact.writeLog("Hello from a thread!");
    
    while (!end)
    {
      
//        end = true;
    };
    contact.writeLog("Bye, bye from thread !");
    try {
      inputStream.close();
      outputStream.close();
    }catch (IOException ioe)
    {
      ioe.printStackTrace(System.out);      
    }
    serialPort.close();
		connected = false;
//	contact.networkDisconnected(id);
		contact.writeLog("connection has been ended.(from run procedure.).");
  }
  
	/**
	 * A separate class to use as the {@link net.Network#reader}. It is run as a
	 * separate {@link Thread} and manages the incoming data, packaging them
	 * using {@link net.Network#divider} into arrays of <b>int</b>s and
	 * forwarding them using
	 * 
	 */
  
/*	private class SerialReader implements Runnable {
		InputStream in;

		public SerialReader(InputStream in) {
			this.in = in;
		}

		public void run() {
        int next_data; 
				while (!end) {  
          try{              
              Protocol.ReadPacketTest(in);              
//              Protocol.ReadPacket(in);              
            }catch (ModbusASCIIException e){
              e.printStackTrace(System.out);
            }
              System.out.printf(" '%c' data received the serial port\n", 
                      next_char);  
					}
      {
				end = true;
				try {
					outputStream.close();
					inputStream.close();
				} catch (IOException e1) {
          e1.printStackTrace(System.out);
				}
				serialPort.close();
				connected = false;
//				contact.networkDisconnected(id);
				contact.writeLog(id, "connection has been interrupted");
			}
		}
	}  */
  
	/**
	 * Simple function closing the connection held by this instance of
	 * {@link net.Network}. It also ends the Thread {@link net.Network#reader}.
	 * 
	 * @return <b>true</b> if the connection could be closed, <b>false</b>
	 *         otherwise.
	 */
	public boolean disconnect() {
    boolean disconn = true;
    if (isConnected())
    { /* run() loop end */
      end = true;
      try {
        this.join(100);
      } catch (InterruptedException e1) {
			e1.printStackTrace(System.out);
			disconn = false;
		}
    
    /**
     * IOStream close throws IOException
     */
    
		try {
			outputStream.close();
			inputStream.close();
		} catch (IOException e) {
			e.printStackTrace(System.out);
			disconn = false;
		}
		serialPort.close();
		connected = false;
//		contact.networkDisconnected();
		contact.writeLog("Connection disconnected.(from disconnect procedure).");
    }
    return disconn;
	}

	/**
	 * @return Whether this instance of {@link net.Network} has currently an
	 *         open connection of not.
	 */
  
	public boolean isConnected() {
		return connected;
	}

	/**
	 * This method is included as a legacy. Depending on the other side of the
	 * Serial port, it might be easier to send using a String. Note: this method
	 * does not add the {@link #divider} to the end.
	 * 
	 * If a connection is open, a {@link String} can be sent over the Serial
	 * port using this function. If no connection is available, <b>false</b> is
	 * returned and a message is sent using
	 * {@link net.Network_iface#writeLog(int, String)}.
	 * 
	 * @param message
	 *            The {@link String} to be sent over the Serial connection.
	 * @return <b>true</b> if the message could be sent, <b>false</b> otherwise.
	 */
	public boolean writeSerial(String message) {
		boolean success = false;
		if (isConnected()) {
			try {
				outputStream.write(message.getBytes());
				success = true;
			} catch (IOException e) {
				disconnect();
			}
		} else {
			contact.writeLog("No port is connected.");
		}
		return success;
	}

	/**
	 * If a connection is open, an <b>int</b> between 0 and 255 (except the
	 * {@link net.Network#divider}) can be sent over the Serial port using this
	 * function. The message will be finished by sending the
	 * {@link net.Network#divider}. If no connection is available, <b>false</b>
	 * is returned and a message is sent using
	 * {@link net.Network_iface#writeLog(int, String)}.
	 * 
	 * @param numBytes
	 *            The number of bytes to send over the Serial port.
	 * @param message
	 *            [] The array of<b>int</b>s to be sent over the Serial
	 *            connection (between 0 and 256).
	 * @return <b>true</b> if the message could be sent, <b>false</b> otherwise
	 *         or if one of the numbers is equal to the #{@link Network#divider}
	 *         .
	 */
	public boolean writeSerial(int numBytes, int message[]) {
		boolean success = true;
		int i;
		for (i = 0; i < numBytes; ++i) {
/*			if (message[i] == divider) {
				success = false;
				break;
			}*/
		}
		if (success && isConnected()) {
			try {
				for (i = 0; i < numBytes; ++i) {
						outputStream.write(changeToByte(message[i]));
				}
//				outputStream.write(changeToByte(divider));
			} catch (IOException e) {
				success = false;
				disconnect();
			}
		} else if (!success) {
			// message contains the divider
			contact.writeLog("The message contains the divider.");
		} else {
			contact.writeLog("No port is connected.");
		}
		return success;
	}

	private byte changeToByte(int num) {
		byte number;
		int temp;
		temp = num;
		if (temp > 255)
			temp = 255;
		if (temp < 0)
			temp = 0;
		number = (byte) temp;
		return number;
	}
  
}
