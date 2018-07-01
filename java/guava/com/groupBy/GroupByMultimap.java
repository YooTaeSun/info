package www.townsi.com.groupBy;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;

import com.google.common.base.Function;
import com.google.common.collect.ImmutableListMultimap;
import com.google.common.collect.Lists;
import com.google.common.collect.Multimaps;

import www.townsi.com.vo.Person;

@SuppressWarnings({"rawtypes","unchecked"})
public class GroupByMultimap {

	public static enum CompressionType {
		name, age, job;
	}

	public static enum searchType {
		NAME("1"),
		ID("2");

		private final String value;

		private searchType(String value) {
			this.value = value;
		}
		public String getValue() {
			return value;
		}

		public static enum base {
			NAME2("ABC"),
			ID2("ABC_ID2");

			private final String value;

			private base(String value) {
				this.value = value;
			}
			public String getValue() {
				return value;
			}
		}
	}

	final static String fieldName = "job";

	public static void main(String[] args) {
		System.out.println(searchType.NAME);
		System.out.println(searchType.NAME.getValue());
		System.out.println(searchType.base.NAME2);
		System.out.println(searchType.base.NAME2.getValue());
		System.out.println(CompressionType.name);
		System.out.println(CompressionType.name.values());
		groupBy();
//		groupBy2();

	}

	public static void groupBy() {
//		public class Person {
//			public String name;
//			public Integer age;
//			public String job;

		Person p1 = new Person("John", 30, "Doctor");
		Person p2 = new Person("John", 90, "Doctor");
		Person p3 = new Person("Sam", 30, "Teacher");
		Person p4 = new Person("Joy", 30, "Engineer");
		Person p5 = new Person("Billy", 40, "Teacher");
		Person p6 = new Person("Tom", 40, "Doctor");

		ArrayList persons = Lists.newArrayList(p1, p2, p3, p4, p5, p6);

		CompressionType compression = CompressionType.job;// get CompressionType from user input

		Function groupByJob = new Function<Person, String>() {
			@Override
			public String apply(Person in) {
				return in.getJob();
			}};
		groupByField(persons, groupByJob);


System.out.println("");
System.out.println("");
System.out.println("--------------------------------------------------");
System.out.println("");


		Function groupByAge = new Function<Person, String>() {
			@Override
			public String apply(Person input) {
				// TODO Auto-generated method stub
				String aaa = fieldName;
				return String.valueOf(input.getAge());
			}};
			groupByField(persons, groupByAge);

//		ImmutableListMultimap groupedAge = Multimaps.index(persons,groupByAge);
//
//		keyIterator = groupedAge.asMap().keySet().iterator();
//		while (keyIterator.hasNext()) {
//			String key = keyIterator.next();
//			System.out.println("");
//			System.out.println("key = " + key);
//			Collection<Person> dataRows = groupedAge.get(key);
//			for (Person person : dataRows) {
//				System.out.print(String.format("  %s : %s", person.getName(), person.getAge()));
//			}
//		}
	}

	private static void groupByField(ArrayList persons, Function f) {
		ImmutableListMultimap grouped = Multimaps.index(persons,f);


		Iterator<String> keyIterator = grouped.asMap().keySet().iterator();
		while (keyIterator.hasNext()) {
			String key = keyIterator.next();
			System.out.println("");
			System.out.println("key = " + key);
			Collection<Person> dataRows = grouped.get(key);
			for (Person person : dataRows) {
				System.out.print(String.format("  %s : %s", person.getName(), person.getAge()));
			}
		}
	}

	public static void groupBy2() {

	}
}

