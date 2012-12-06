/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package testserial;


import java.util.*;

/**
 *
 * @author bekeband
 */
public class ModbusImage {

  /*
   * List of Process Images for modbus slave procedures.
   */
  
  private List<ProcessImage> ImageList;
  
  private int ModbusAddress;
  
  public ModbusImage() { this(1);
  }
  public ModbusImage(int aModbusAddress){
    ModbusAddress = aModbusAddress;
    ImageList.add(new ProcessImage());
  }
  public List GetImageList() {return ImageList;};
  
}
