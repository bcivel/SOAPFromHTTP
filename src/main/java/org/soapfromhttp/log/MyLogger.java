
package org.soapfromhttp.log;

import org.apache.log4j.Level;

public class MyLogger {

    public static void log(String className, Level level, String message) {
        org.apache.log4j.Logger.getLogger(className).log(level, message);
    }
}
