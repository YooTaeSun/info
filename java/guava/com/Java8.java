//package www.townsi.com;
//
//import java.util.Comparator;
//import java.util.List;
//import java.util.stream.Collector;
//import java.util.stream.Collectors;
//import java.util.stream.Stream;
//
//public class Java8 {
//	public static void main(String[] args) {
//		Stream<Student> students = Stream.of(new Student[]{
//			      new Student("A", 100),
//			      new Student("A", 90),
//			      new Student("A", 80),
//			      new Student("B", 100),
//			      new Student("C", 70),
//			      new Student("D", 800),
//			      new Student("E", 900)
//			});
//
//			List<Student> studentsList = students
////			      .collect(groupingBy(Student::getName, maxBy(Comparator.comparing(Student::getPoint))))
//			      .entrySet()
//			      .stream()
//			      .map(e -> e.getValue().get())
//			      .collect(Collectors.toList());
//			System.out.println(studentsList);
//	}
//
//	private static Collector groupingBy(String name, Object maxBy) {
//		// TODO Auto-generated method stub
//		return null;
//	}
//
//
//	private static Object maxBy(Comparator<Student> comparing) {
//		// TODO Auto-generated method stub
//		return null;
//	}
//}
//
//class Student {
//	private String name;
//	private int point;
//
//
//	public Student(String name, int point) {
//		this.name = name;
//		this.point = point;
//		// TODO Auto-generated constructor stub
//
//	}
//
//
//	public String getName() {
//		return name;
//	}
//
//
//	public void setName(String name) {
//		this.name = name;
//	}
//
//
//	public int getPoint() {
//		return point;
//	}
//
//
//	public void setPoint(int point) {
//		this.point = point;
//	}
//
//}