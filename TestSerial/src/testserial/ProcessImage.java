/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package testserial;

//import java.util.Arrays;

/**
 *
 * @author bekeband
 */
public class ProcessImage {

  int DEFAULT_PROCESS_SIZE = 1000;
  
  private char[] image;
  
  private int size_in_byte;
  private int StartAddress;
  private int EndAddress;
  
  public ProcessImage() {this(1000); StartAddress = 40000; EndAddress = 41000; }
  public ProcessImage(int rq_size_in_byte){
    size_in_byte = rq_size_in_byte;
    image = new char[size_in_byte];
    ClearAll();
  };
  public char GetByte(int address){ return image[address]; }
  public void SetByte(char data, int address){ image[address] = data;}
  private void ClearAll()
  {
    for (int i = 0; i < size_in_byte; i++)
    {
      image[i] = 0;
    }
  }
  public void SetStartAddress(int new_start_address){ StartAddress = new_start_address;}
  public void SetEndAddress(int new_end_address){ EndAddress = new_end_address;}
  public int GetStartAddress(){ return StartAddress; }
  public int GetEndAddress(){ return EndAddress; }
  
}
