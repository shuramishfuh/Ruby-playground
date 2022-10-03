// author of program:  Ramish
// Description:  This program is a fixed point number that can be added, subtracted, multiplied, divided, and converted to a different q value
public class FixedPointNumber {
    private int intVal;
    private int qVal = 12;

    // no method in class can call this constructor
    public FixedPointNumber(int intVal, int qVal) {
        this.intVal = intVal;
        this.qVal = qVal;
    }

    // use as default for constructor
    public FixedPointNumber(double x, int q) {
        this.intVal = (int) (x * Math.pow(2, q));
        this.qVal = q;
    }

    // to be called to string method
    public double toDouble() {
        return (double) (this.intVal / Math.pow(2, this.qVal));
    }

    //convert from one fixed point to another
    public FixedPointNumber toQval(int q) {
        FixedPointNumber number = null;
        if (this.intVal > q) {
            number = new FixedPointNumber(intVal >> (this.qVal - q), q);
        } else if (qVal < q) {
            number = new FixedPointNumber(intVal << (q - qVal), q);
        }
        return number;
    }

    // fixedpoint to string
    public String toString() {
        return String.format("%d,%d: %.6f", this.intVal, this.qVal, this.toDouble());
    }

    // two fixed point numbers equal
    public boolean equals(FixedPointNumber x) {
        return (this.intVal == x.intVal && this.qVal == x.qVal);
    }

    // add two fixed point numbers
    public FixedPointNumber plus(FixedPointNumber x, int q) {
        return new FixedPointNumber(this.toQval(q).intVal + x.toQval(q).intVal, q);
    }
}
