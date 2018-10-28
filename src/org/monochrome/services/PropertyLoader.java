package org.monochrome.services;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.List;
import java.util.Properties;

public class PropertyLoader {
    public static final String configFile = "app.properties";

    private static Properties prop = null;


    public static String getValue(String key) {
        if (prop == null) {
            load(configFile);
        }

        return prop.getProperty(key);
    }


    private static void load(String propertiesFile) {
        InputStream inStream = null;

        try {
            inStream = new FileInputStream(PropertyLoader.class.getResource("/").getPath() + configFile);

            prop = new Properties();
            prop.load(inStream);

        } catch (IOException e) {
            e.printStackTrace();

        } finally {

            try {
                if (inStream != null) {
                    inStream.close();
                }
            } catch (IOException e) {
                System.out.println("cannot close properties file «".concat(propertiesFile));
                e.printStackTrace();
            }

        }

    }
}