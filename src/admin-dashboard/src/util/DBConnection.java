package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Database connection parameters
    private static final String URL = "jdbc:postgresql://localhost:5432/test";
    private static final String USERNAME = "postgres";
    private static final String PASSWORD = "2004k";

    public static void main(String[] args) {
        try {
            // Attempt to establish a connection
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            
            // If we reach here, connection is successful
            System.out.println("Database connection successful!");
            
            // Always close the connection
            connection.close();
            
        } catch (SQLException e) {
            // Print detailed error information if connection fails
            System.out.println("Database connection failed!");
            System.out.println("Error message: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
