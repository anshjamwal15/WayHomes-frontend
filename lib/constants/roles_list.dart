class Role {
  static String userRole = "ROLE_USER";
  static String modRole = "ROLE_MODERATOR";
  static String adminRole = "ROLE_ADMIN";
  static String role;
  static void setString(String value) {
    role = value;
  }
  static String getString(){
    return role;
  }
}