package ch06_Prototype;

public class main {

	public static void main(String[] args) throws CloneNotSupportedException {

		Circle circle1 = new Circle(1, 2, 3);
		Circle circle2 = (Circle) circle1.copy();

		System.out.printf("%s,%s,%s", circle1.getX(), circle1.getY(), circle1.getR());
		System.out.println("");
		System.out.printf("%s,%s,%s", circle2.getX(), circle2.getY(), circle2.getR());
	}
}
