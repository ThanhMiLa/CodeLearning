import java.net.URI;
public class scratch {
    public static void main(String[] args) {
        try {
            URI uri = URI.create(" http://judge0-server:2358/submissions/batch?base64_encoded=false");
            System.out.println("Host: " + uri.getHost());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
