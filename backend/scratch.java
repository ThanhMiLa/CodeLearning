import java.net.URI;
public class scratch {
    public static void main(String[] args) {
        URI uri = URI.create("http://judge0_codelearning_server:2358/submissions/batch?base64_encoded=false");
        System.out.println("Host: " + uri.getHost());
        System.out.println("Authority: " + uri.getAuthority());
    }
}
