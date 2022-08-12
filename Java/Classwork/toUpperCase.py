import java.util.Scanner;
public class MyProgram 
{
    static Scanner enter = new Scanner(System.in);
    public static void main(String args[]){
                //Declare variables
                String prompt;
                //Input setence
                System.out.println("Enter yout setence: ");
                prompt = enter.next();
                //Output setence
                System.out.println("Setence length: "+prompt.length());
                System.out.println("In uppercase, this setence looks like: '"+prompt.toUpperCase()); // removed the concatenation symbol
    }
