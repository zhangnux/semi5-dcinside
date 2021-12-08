package utils;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtils {

	private static DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm");
	
	public static String dateToString(Date date) {
		if (date == null) {
			return "";
		}
		return dateFormat.format(date);
	}
	
}
