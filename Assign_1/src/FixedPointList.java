// author of program:  Ramish
// Date:  1/28/2015
// Description:  This program is a fixed point list that can hold fixed point number and perform CRUD on them

import java.util.ArrayList;
import java.util.Scanner;

public class FixedPointList {
    final private ArrayList<FixedPointNumber> list;

    public void setListQVal(int listQVal) {
        this.listQVal = listQVal;
    }

    public int getListQVal() {
        return listQVal;
    }

    private int listQVal = 12;

    // constructor
    public FixedPointList() {
        this.list = new ArrayList<>();
    }

    // add to list
    public void add(FixedPointNumber x) {
        this.list.add(x);
        System.out.println(x + " was added to the list");
    }

    // remove first instance of x
    public boolean delete(FixedPointNumber x) {
        for (int i = 0; i < this.list.size(); i++) {
            if (this.list.get(i).equals(x)) {
                this.list.remove(i);
                return true;
            }
        }
        return false;
    }

    // print all fixed point numbers in list
    public void print() {
        System.out.println("All fixed point numbers in list:");
        if (this.list.size() == 0) {
            System.out.println(new FixedPointNumber(0, 12));
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
    public void changeToQ(FixedPointNumber FpNumber, int q) {
        int index = find(FpNumber);
        FixedPointNumber number = this.list.get(index);
        this.list.set(index, number.toQval(q));
    }

    // change q value of all fixed point numbers in list
    public void changeListQ(int q) {
        System.out.println("Current q_value was changed to " + q);
        setListQVal(q);
    }

    // sum all fixed point numbers in list and print result
    public FixedPointNumber sum(int q) {
        FixedPointNumber sum = new FixedPointNumber(0, q);
        for (FixedPointNumber number : this.list) {
            sum = sum.add(number, this.listQVal);
        }
        return sum;
    }

    // end program
    public void end() {
        System.out.println("Program ended");
    }

    // run program
    public void run() {
        System.out.println("Welcome to the Fixed Point List Program");
        while (true) {
            System.out.print("Enter a command: ");
            Scanner in = new Scanner(System.in);
            String operator = in.next();
            if (operator.equalsIgnoreCase("X")) {
                end();
                break;
            } else if (operator.equalsIgnoreCase("A")) {
                add(new FixedPointNumber(in.nextDouble(), getListQVal()));
            } else if (operator.equalsIgnoreCase("P")) print();
            else if (operator.equalsIgnoreCase("Q")) changeListQ(in.nextInt());
            else if (operator.equalsIgnoreCase("D")) {
                FixedPointNumber num = new FixedPointNumber(in.nextDouble(), listQVal);
                if (delete(num)) {
                    System.out.println(num + " was removed from the list");
                } else {
                    System.out.println(num + " was not found in the list");
                }

            } else if (operator.equalsIgnoreCase("S")) {
                System.out.println("the sum is : " + sum(listQVal));
            } else System.out.println("Invalid command");
        }

    }
}