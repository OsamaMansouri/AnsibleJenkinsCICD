/**
 * Demo Application for Jenkins CI/CD Pipeline
 * This is a simple Java app to demonstrate the CI/CD process.
 */
public class App {

    public static String greet(String name) {
        return "Hello, " + name + "! Welcome to CI/CD with Jenkins!";
    }

    public static int add(int a, int b) {
        return a + b;
    }

    public static int multiply(int a, int b) {
        return a * b;
    }

    public static void main(String[] args) {
        System.out.println(greet("Developer"));
        System.out.println("2 + 3 = " + add(2, 3));
        System.out.println("4 * 5 = " + multiply(4, 5));
    }
}

