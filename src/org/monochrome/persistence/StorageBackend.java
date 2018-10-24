package org.monochrome.persistence;

/*
encapsulate one more level of DB interaction.
From my Point of view, this class should be static, but to follow best practice, and to be future-proof
 in case of a « more DB connections » scenario, it is instanciable */

import org.monochrome.services.SingleLogger;

import java.sql.*;

public class StorageBackend {

    private Connection connection = null;

    public StorageBackend (
            String serverURL, String db, String serverURLparameters,
            String user, String password) throws SQLException, ClassNotFoundException {

        Class.forName("com.mysql.cj.jdbc.Driver");

        this.connection = DriverManager.getConnection(
            serverURL.concat(db).concat(serverURLparameters), user, password
        );
    }



    public PreparedStatement getPreparedStatement(String query) throws SQLException {
        return this.connection.prepareStatement(query);
    }


    public ResultSet executeQuery(String query) throws SQLException {
        Statement statement = this.connection.createStatement();
        return statement.executeQuery(query);
    }



    //TODO: be sure this method is call at app' end.
    public void close() {
        if (this.connection != null) {
            try {
                this.connection.close();

            } catch (SQLException e) {
                SingleLogger.logger.severe("Cannot close DB connection.\n"
                        .concat(e.getMessage())
                        .concat("\n")
                        .concat(e.getStackTrace().toString())
                );

                System.out.println(e.getLocalizedMessage());
                e.printStackTrace();
            }
        }
    }

}
