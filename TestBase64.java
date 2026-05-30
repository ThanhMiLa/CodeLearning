import java.util.Base64;

public class TestBase64 {
    public static void main(String[] args) {
        String s = "MTQ0NTQ1OSA5MDA3NTMzMDYgMjU3OTk4OTU4IC00MTg3MDA4NTQgOTQ5NTQxMzE2IDIzNTMyMDg1NCAyNzc";
        try {
            System.out.println("Trying strict decoder...");
            Base64.getDecoder().decode(s);
            System.out.println("Strict decoder success!");
        } catch (Exception e) {
            System.out.println("Strict decoder failed: " + e.getMessage());
        }
        
        try {
            System.out.println("Trying strict decoder with padding...");
            Base64.getDecoder().decode(s + "==");
            System.out.println("Strict decoder with padding success!");
        } catch (Exception e) {
            System.out.println("Strict decoder with padding failed: " + e.getMessage());
        }
    }
}
