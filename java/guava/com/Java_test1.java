//package www.townsi.com;
//
//import java.time.DayOfWeek;
//import java.time.LocalDate;
//import java.time.temporal.ChronoField;
//import java.time.temporal.TemporalField;
//import java.time.temporal.WeekFields;
//import java.util.ArrayList;
//import java.util.List;
//import java.util.Map;
//import java.util.stream.Collectors;
//
//public class Java_test1 {
//	enum CompressionType {
//		DAY, WEEK, MONTH, YEAR;
//	}
//
//	public static void main(String[] args) {
//
//
//		List<LocalDate> dates = new ArrayList<LocalDate>();
//		dates.add(LocalDate.of(2017, 1, 1));
//		dates.add(LocalDate.of(2017, 1, 1));
//		dates.add(LocalDate.of(2017, 1, 4));
//		dates.add(LocalDate.of(2017, 1, 5));
//		dates.add(LocalDate.of(2017, 1, 29));
//		dates.add(LocalDate.of(2017, 10, 1));
//		dates.add(LocalDate.of(2018, 4, 5));
//
//		CompressionType compression = CompressionType.MONTH;// get CompressionType from user input
//
//		final TemporalField groupField;
//		switch (compression) {
//		    case DAY:
//		        groupField = ChronoField.DAY_OF_YEAR;
//		        break;
//		    case WEEK:
//		    // week starts at Sunday, minimum of 1 day in the first week
//		        groupField = WeekFields.of(DayOfWeek.SUNDAY, 1).weekOfWeekBasedYear();
//		        break;
//		    case MONTH:
//		        groupField = ChronoField.MONTH_OF_YEAR;
//		        break;
//		    case YEAR:
//		        groupField = ChronoField.YEAR;
//		        break;
//		    default:
//		        groupField = null;
//		}
//		if (groupField != null) {
//		    Map<Integer, List<LocalDate>> result = dates.stream().collect(Collectors.groupingBy(d -> d.get(groupField)));
//		   String str = "";
//		}
//
//	}
//
//}