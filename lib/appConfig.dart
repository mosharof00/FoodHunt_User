
class AppConfig {
  /// Logo
  static String splashLogo = 'assets/logo/splash_app_logo.png';
  static String appLogo = 'assets/logo/app_logo.png';
  static String appName = 'WeeklyEatUser';
  static String appFirebase = 'Shopaholic_Seller';

  // static String SUPABASE_URL="https://axbajldpgtugenukkold.supabase.co";
  static String SUPABASE_URL="https://mfmzkdtgkrwwumivkgic.supabase.co";

  // static String SUPABASE_ANON_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF4YmFqbGRwZ3R1Z2VudWtrb2xkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc4NzcwNDksImV4cCI6MjA1MzQ1MzA0OX0.WjqysBZmEFliNkAMC7okAS9KsssOursItSbC9uscM1c";
  static String SUPABASE_ANON_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1mbXprZHRna3J3d3VtaXZrZ2ljIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQxMDkxMDYsImV4cCI6MjA1OTY4NTEwNn0.atapIG_srkN8j0YEmeEhYI_RQmP7QKc0PYFFl29weoM";
  static String SUPABASE_SERVICE_ROLE_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF4YmFqbGRwZ3R1Z2VudWtrb2xkIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTczNzg3NzA0OSwiZXhwIjoyMDUzNDUzMDQ5fQ.i4xdTy6IVKD_6nuP052t1CejVeVdOXOSvZszWfv330g";
  static String GOOGLE_API_KEY="AIzaSyDqY4iwIwpyzo59ZwxPpWGLUG0qvbbX6Ws";
  static String IMAGE_URL="${SUPABASE_URL}/storage/v1/object/public/";
  //Push Notification key
  static dynamic serviceAccountJson = {
    "type": "service_account",
    "project_id": "shopaholic-f3d48",
    "private_key_id": "80d68d6d9de955bc0c7b8d5609d50055c62a1335",
    "private_key":
    "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDUmzaA8jr+uysr\n3jSJN+iQV/bOP6uW3Yb5dTFV0h52XJSchu6hFaexmIF98RHlficEEXh6X5FVPWIt\n2ZLdI7+fh1ubTKCsqg8ftug7kRfXmT2UaI6llmpvnlLhZgO2XOvOBiQgkpVwfTj/\nMz2rVG5u7KCRG0QIarT9D6HbQJiPIAz3UVnveS9GlN6ep+Xrqpx0+czIzKggbnuh\nn+FabCLfXMwnqwdCAvPTO9h0DLlatntewYInrPbQrOv8l9eUDLrhrvU4wXROYfkZ\nCQ5uf5QoKIJzMMrlm/3lK/aLYKgcBwK0XHsOf56JzB/Nz9ptJnAJq1lgEGLmxkFz\nY0ovLUArAgMBAAECggEAF6hrOOS7hTEAAtJSd5p4ZJIv7Toki+smuTI979Yr0Zvy\nZYtA7pKMUIovOVEkCVeFBpeIbTBJPyT6Jy6jgGbD91UxRRISfGQyvqK0gOcKXNFj\n4CnVBb67z/kxhny67ltfWf5Q8tbyOMxBFWohnfkNONwCmg21/6xwFguGmpvmM2F3\nuPLuRCLZ0zJmx/rlo84vic9VZnKQQQHdjL7Kf/H6xub6LHe8Rn9Pb67R+pIcxVfn\nc525uHItCeAa7h1Lqc0Jpimn4wtL+cnedRvuTYS8/FwvqKQTDMgbP3iEe9GS8pbc\njqVel1rnaj9RiDGffL2WRe3A2Hzzeh2g8suy2X2joQKBgQDrP7WWbxzJFSsGAebs\nvEZWMLJc+qy+mvgpiCLnN3mOPvwGiH9ayWKgk/FUupCbyCU+39uwwyhLDiJQaN0j\ns/F0S8IvK/W/nGaD03tDXHmNvXGE70CafWQRVqGYLiN5wwLqNFovzRisjS0f4rTv\n33tuG7XCxQrd0qdiVt4bZFAq8wKBgQDnXDLgt5M1j5nAeI+5dXcE/03+Z4GF13vY\n+FyXVCVuqPmxZehpiCgb3Y2fFH50miZCSv8XsBCuzOpXrb62V0tXIskbQeC7d58y\nYFwJaR1Q9ksCroRKfob6BzBLQYdFFtclY4HdSPqWiUSOhubhV+vp9X53PNtlhJnc\nc7f6iilz6QKBgBI6T4Gmfl5+S2UdxJzXQcPv5gIaUkQ6kbv2Fm4/+CUzcCe5b9TD\nAedbTzm3cvj/GxOyGL2rgXW/VJ1SYsAfczgFnrg0+cetAKx6OHTRt4FqCl+4ghL2\nYEiPo9m8yXbny1QGVm6Zv62vCq4LzOVBNbkkYIME7YCej+WowXDx5txNAoGAJFKM\nRk1r1h/aYqZK4jH34pf2dbdoVUv0TKcJWlTCn7H1qY03RMI0kdNhtZTxGXtOAGBn\n1h81L0xKikNjypq/4Ek8y4O3NZddLfqE2JFhIeHY+u3NJSjiJgTU5yu9gfJJCryp\nmcUoWlPoqHuzabN0/UEmfq/WPgToZvzf6Hyib2kCgYEAyXb0s9uyQrcRvXKw/9ZA\np6/3rVO202IMg15VkbbWRMlNfVOrmyGiZoliPoPjlXdyOFYYtNw3TxCreHifewKS\nBadLU9f/I+FYT4Kap8il6x9kddMWjJb3+ZofrUNDc9Wh0O/t+/wH3TYmP81OuT0g\nB1V/WgL64M4JeyWylTrGJB8=\n-----END PRIVATE KEY-----\n",
    "client_email":
    "shopaholic-arcadexit@shopaholic-f3d48.iam.gserviceaccount.com",
    "client_id": "105240726136467929811",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url":
    "https://www.googleapis.com/robot/v1/metadata/x509/shopaholic-arcadexit%40shopaholic-f3d48.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  };
}

