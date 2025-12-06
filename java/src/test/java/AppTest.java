import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for the demo application.
 */
public class AppTest {

    @Test
    public void testGreet() {
        String result = App.greet("Jenkins");
        assertTrue(result.contains("Hello, Jenkins!"));
        System.out.println("✓ testGreet passed");
    }

    @Test
    public void testAdd() {
        assertEquals(5, App.add(2, 3));
        assertEquals(0, App.add(-1, 1));
        assertEquals(0, App.add(0, 0));
        System.out.println("✓ testAdd passed");
    }

    @Test
    public void testMultiply() {
        assertEquals(20, App.multiply(4, 5));
        assertEquals(0, App.multiply(0, 100));
        assertEquals(-6, App.multiply(-2, 3));
        System.out.println("✓ testMultiply passed");
    }
}

