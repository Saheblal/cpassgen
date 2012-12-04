/*
 * This simplified class for debug information SerialComm class.
 * @author Beke András (beke.andras.mkolc@gmail.com)
 * Thanks for Raphael Blatter (raphael@blatter.sg)
 * @author heavily using code examples from the RXTX-website (rxtx.qbang.org)
 */
package testserial;

/**
 * @author bekeband
 */
public class DebugContact {

  /**
	 * Implementing {@link writeLog(int, String)}, which is
	 * used to write information concerning the connection. In this example, all
	 * the information is simply written out to command line.
	 * 
	 * @see net.Network_iface
	 */
	public void writeLog(String text) {
		System.out.println("   log:  |" + text + "|");
	}
  
	/**
	 * Is called when the network has been disconnected. This call can e.g. be
	 * used to show the connection status in a GUI or inform the user using
	 * other means.
	 * 
	 * @param id
	 *            {@link #id} of the corresponding
	 *            {@link } instance (see {@link net.Network#id}).
	 */
	public void networkDisconnected()
  {
		System.out.println("network disconnected.");    
  };
}
