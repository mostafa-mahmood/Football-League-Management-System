package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Database connection parameters
    private static final String URL = "jdbc:postgresql://localhost:5432/Football-League-Management-System";
    private static final String USERNAME = "postgres";
    private static final String PASSWORD = "2004k";

    // Private constructor to prevent instantiation
    private DBConnection() {}

    // Static method to get database connection
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
}