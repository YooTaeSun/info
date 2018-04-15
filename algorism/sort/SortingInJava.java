package algorism.sort;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

//http://ict-nroo.tistory.com/60?category=698685

public class SortingInJava {

	private static int capacity = 10;
	private static int size = 10;

	public static void main(String[] args) {
		// basicSort();
		// stringSort();
		// arrayListSort();
//		objectSortComparable();
		objectSortComparator();
	}

	// 기본 타입 데이터의 정렬
	public static void basicSort() {
		int[] data = new int[capacity];
		Arrays.fill(data, 0);
		data[3] = 3;
		// data[0]에서 data[capacity-1]까지 데이터가 꽉 차있는 경우에는 다음과 같이 정렬한다.
		Arrays.sort(data);
		// 배열이 꽉 차있지 않고 size개의 데이터만 있다면 다음과 같이 정렬한다.
		Arrays.sort(data, 0, size);
		System.out.println(Arrays.toString(data));
	}

	// 객체의 정렬: 문자열
	public static void stringSort() {
		String[] fruits = new String[] { "pineapple", "apple", "orange", "banana" };
		Arrays.sort(fruits);
		System.out.println(Arrays.toString(fruits));
	}

	// ArrayList 정렬: 문자열
	public static void arrayListSort() {
		List<String> fruits = new ArrayList<>();
		fruits.add("pineapple");
		fruits.add("apple");
		fruits.add("orange");
		fruits.add("banana");
		Collections.sort(fruits);
		fruits.forEach(System.out::println);
	}

	// 객체의 정렬: 사용자 정의 객체
	public static void objectSortComparable() {
		Fruit[] fruits = new Fruit[4];
		fruits[0] = new Fruit("pineapple", 70);
		fruits[1] = new Fruit("apple", 100);
		fruits[2] = new Fruit("orange", 80);
		fruits[3] = new Fruit("banana", 90);

		Arrays.sort(fruits);
		for (Fruit fruit : fruits)
			System.out.println(fruit);
	}

	// 객체의 정렬: 사용자 정의 객체
	public static void objectSortComparator() {
		Fruit[] fruits = new Fruit[4];
		fruits[0] = new Fruit("pineapple", 70);
		fruits[1] = new Fruit("apple", 100);
		fruits[2] = new Fruit("orange", 80);
		fruits[3] = new Fruit("banana", 90);

		Arrays.sort(fruits, Fruit.nameComparator);
		for (Fruit fruit : fruits) {
			System.out.println(fruit);
		}
		
		System.out.println();
		Arrays.sort(fruits, Fruit.quantityComparator);
		for (Fruit fruit : fruits) {
			System.out.println(fruit);
		}
	}
}

class Fruit implements Comparable<Fruit> {
	public String name;
	public int quantity;

	public Fruit(String name, int quantity) {
		this.name = name;
		this.quantity = quantity;
	}

	// @Override
	// public int compareTo(Fruit other) {
	// return name.compareTo(other.name);
	// }

	@Override
	public int compareTo(Fruit other) {
		return quantity - other.quantity;
	}

	@Override
	public String toString() {
		return name + " " + quantity;
	}

	public static Comparator<Fruit> nameComparator = new Comparator<Fruit>() {
		public int compare(Fruit fruit1, Fruit fruit2) {
			return fruit1.name.compareTo(fruit2.name);
		}
	};
	
	public static Comparator<Fruit> quantityComparator = new Comparator<Fruit>() {
		public int compare(Fruit fruit1, Fruit fruit2) {
			return fruit1.quantity - fruit2.quantity;
		}
	};
}
