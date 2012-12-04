/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package testserial;

import java.util.concurrent.*;

/**
 *
 * @author bekeband
 */
public class SerialThread extends Thread {
  
  public void run() {
    BlockingQueue queue = new SynchronousQueue();
    ThreadPoolExecutor executor = 
            new ThreadPoolExecutor(1, 10, 100, TimeUnit.SECONDS, queue);
    while (true) {
      System.out.println("ThreadPoolExecutor");
    }  
  };
}