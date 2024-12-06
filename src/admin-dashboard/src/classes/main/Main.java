package classes.main;
import util.DBConnection;
import java.sql.Connection;
import java.sql.SQLException;

public class Main {
          public static void main(String[] args) {
                    // Try to establish a database connection
                    try {
                        // Get connection using the utility class
                        Connection connection = DBConnection.getConnection();
                        
                        // If connection is successful, print success message
                        System.out.println("Database connection established successfully!");
                        
                        // Always close the connection after use
                        connection.close();
                    } catch (SQLException e) {
                        // Print error if connection fails
                        System.out.println("Failed to connect to the database:");
                        e.printStackTrace();
                    }
                }
}
