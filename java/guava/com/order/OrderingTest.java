package www.townsi.com.order;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

import org.junit.Test;

import com.google.common.collect.Ordering;
import com.google.common.primitives.Ints;

public class OrderingTest {
	@Test
	public static void main(String[] args) {
		// given
		Geek g1 = new Geek("nephlim", 40);
		Geek g2 = new Geek("Anarcher", 35);
		Geek g3 = new Geek("fupfin", 43);
		Geek g4 = new Geek("Arawn", 33);

		List<Geek> list = new ArrayList<Geek>();
		list.add(g1);
		list.add(g2);
		list.add(g3);
		list.add(g4);

		Ordering<Geek> byAge = new Ordering<Geek>() {
			@Override
			public int compare(Geek left, Geek right) {
				return Ints.compare(left.getAge(), right.getAge());
			}
		};

		Collections.sort(list, byAge);
		System.out.println();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			Geek geek = (Geek) iterator.next();

		}

		Ordering<Geek> ordering = new Ordering<Geek>() {
		    @Override
		    public int compare(Geek left, Geek right) {
		        return Ints.compare(left.getAge(), right.getAge());
		    }
		};

		Geek maxGeek = ordering.max(list);
		System.out.println(maxGeek.getAge());
		Geek mingeek = ordering.min(list);
		System.out.println(mingeek.getAge());
	}
}

class Geek {
	private String name;
	private int age;

	public Geek(String name, int age) {
		this.name = name;
		this.age = age;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}
}
