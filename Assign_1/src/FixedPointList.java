// author of program:  Ramish
// Date:  1/28/2015
// Description:  This program is a fixed point list that can hold fixed point number and perform CRUD on them

import java.util.ArrayList;
import java.util.Scanner;

public class FixedPointList {
    private ArrayList<FixedPointNumber> list;

    // constructor
    public FixedPointList() {
        this.list = new ArrayList<FixedPointNumber>();
    }

    // add to list
    public void add(FixedPointNumber x) {
        this.list.add(x);
    }

    // remove first instance of x
    public void remove(FixedPointNumber x) {
        this.list.remove(x);
    }

    // print all fixed point numbers in list
    public void print() {
        System.out.println("All fixed point numbers in list:");
        if (this.list.size() == 0) {
            System.out.println(new FixedPointNumber(0,12));
        } else {
            for (FixedPointNumber number : this.list) {
                System.out.println(number);
            }
        }
    }

    //find index of first instance of x
    public int find(FixedPointNumber x) {
        return this.list.indexOf(x);
    }

    // change q value of specific fixed point number
    public void changeQ(FixedPointNumber FpNumber, int q) {
        int index = find(FpNumber);
        FixedPointNumber number = (FixedPointNumber) this.list.get(index);
        this.list.set(index, number.toQval(q));
    }

    // sum all fixed point numbers in list and print result
    public void sum() {
    }

    // end program
    public void end() {
        System.out.println("Program ended");
        System.exit(0);
    }

    // run program
    public void run() {
        System.out.println("Welcome to the Fixed Point List Program");
        System.out.println("Issue your commands to the program");
        while (true) {
            System.out.print("Enter a command: ");
            Scanner in = new Scanner(System.in);
            String operator = in.next();
            if (operator.equalsIgnoreCase("X")) end();
            else if (operator.equalsIgnoreCase("A")) add(new FixedPointNumber(in.nextDouble(), in.nextInt()));
            else if (operator.equalsIgnoreCase("D")) remove(new FixedPointNumber(in.nextDouble(), in.nextInt()));
            else if (operator.equalsIgnoreCase("P")) print();
            else if (operator.equalsIgnoreCase("Q"))
                changeQ(new FixedPointNumber(in.nextDouble(), in.nextInt()), in.nextInt());
            else if (operator.equalsIgnoreCase("S")) sum();
            else System.out.println("Invalid command");
            System.out.println(" command done");
        }

    }
}