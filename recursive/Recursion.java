package algorism.recursive;

/*
 * 모든 순환함소는 반복문(iteration)으로 변경 가능
 * 그 역도 성립함. 즉 모든 반복문은 recursion으로 표현 가능함
 * 순환함수는 복잡한 알고리즘을 단순하기 알기쉽게 표현하는 것을 가능하게 함
 * 하지만 함수 호출에 따른 오버해드가 있음 (매개변수 전달, 엑티베이션 프레임 생성 등)
 * 
 * */

public class Recursion {
	public static void main(String[] args) {
//		for (int i = 0; i < 5; i++) {
//			int result = func(i);
//			System.out.println(String.format("input : %s, reuslt : %s", i, result));	
//		}
		
		
//		for (int i = 0; i < 6; i++) {
//			int result = factorial(i);
//			System.out.println(String.format("input : %s, reuslt : %s", i, result));	
//		}
		
//		for (int i = 0; i < 6; i++) {
//			double result = power(2.0d,i);
//			System.out.println(String.format("input : %s, reuslt : %s", i, result));	
//		}
		
//		토끼가 1월에 한쌍이 있고, 성인 토끼로 자라는데 한달이 필요하고, 한달에 한쌍 토끼를 낳고, 절대로 죽지 않는다고 가정한다. 그렇면 1202년 출간된 피보나치 토끼 퀴즈가 완성된다.		
//		for (int i = 0; i < 6; i++) {
//			int result = fibonacci(i);
//			System.out.println(String.format("input : %s, reuslt : %s", i, result));	
//		}
		
//		int result = length("123가나");
//		System.out.println(String.format("문자열의길이 : %s ",result));
		
//		printChars("123가나");
//		printCharsReverse("12345");
//		printInBinary(10);
		
		int[] iarray = {10,1,2,3,4,5,6,7,8};
		System.out.println(String.format("배열의 합 %s", sum(3, iarray))); 
		System.out.println(String.format("배열의 합 %s", sum(iarray.length, iarray)));
		System.out.println(String.format("search %s", search(iarray, 0, iarray.length-1, 3),3)); 
		System.out.println(String.format("search2 %s", search2(iarray, 0, iarray.length-1, 3),3)); 
		System.out.println(String.format("search3 %s", search3(iarray, 0, iarray.length-1, 8),8)); 
		System.out.println(String.format("findMax : %s", findMax(iarray, 0, iarray.length-1))); 
		System.out.println(String.format("findMax2 : %s", findMax2(iarray, 0, iarray.length-1)));
		
		String[] str_array = {"A","B","C","D","E","F"};
		System.out.println(String.format("binarySearch : %s", binarySearch(str_array, "F", 0, str_array.length-1))); 
		
	}
	
	public static int func(int n) {
		if(n == 0) {
			return 0;
		}else {
//			System.out.println(String.format("%s + func(%s-1)", n,n));
			return n + func(n-1);
		}
	}
	
	//팩토리얼
	public static int factorial(int n) {
		if(n == 0 ) {
			return 1;
		}else {
//			System.out.println(String.format("%s * func(%s-1)", n,n));
			return n * factorial(n-1);
		}
	}
	
	public static double power(double x,int n) {
		if(n == 0 ) {
			return 1;
		}else {
			return n * power(x, n-1);
		}
	}
	
	//피보나치 수
	public static int fibonacci(int n) {
		if(n < 2) {
			return n;
		}else {
			return fibonacci(n-1) + fibonacci(n-2);
		}
	}
	//최대공약수 
	public static double gcd(int p, int q) {
		if(q==0) {
			return p;
		}else {
			return gcd(q,p%q);
		}
	}
	
	//문자열의 길이
	public static int length(String str) {
		if(str.equals("")) {
			return 0;
		}else {
			return 1+length(str.substring(1));
		}
	}
	
	//문자열 하나씩 출력
	public static void printChars(String str) {
		if(str.length() == 0) {
			return;
		}else {
			System.out.println(str.charAt(0));
			printChars(str.substring(1));
		}
	}
	
	//뒤집어서 문자열 하나씩 출력
	public static void printCharsReverse(String str) {
		if(str.length() == 0) {
			return;
		}else {
			printCharsReverse(str.substring(1));
			System.out.println(str.charAt(0));
		}
	}
	
	//2진수로 변환하여 출력
	public static void printInBinary(int n) {
		if(n < 2) {
			System.out.print(n);
		}else {
			printInBinary(n/2);
			System.out.print(n%2);
		}
	}
	
	//data[0]에서 data[n-1]까지의 합을 구하여 반환한다.
	public static int sum(int n, int[] data) {
		if(n <= 0) {
			return 0;
		}else {
			return sum(n-1, data) + data[n-1];
		}
	}
	//순차 탐색
	public static int search(int[] data, int begin, int end, int target) {
		if(begin > end) {
			return -1;
		}else if(target == data[begin]){
			return begin;
		}else {
			return search(data, begin+1, end, target);
		}
	}
	//다른 방법 순차 탐색
	public static int search2(int[] data, int begin, int end, int target) {
		if(begin > end) {
			return -1;
		}else if(target == data[end]){
			return end;
		}else {
			return search2(data, begin, end-1, target);
		}
	}
	//다른 방법 순차 탐색 절반으로 나우어서 
	public static int search3(int[] data, int begin, int end, int target) {
		if(begin > end) {
			return -1;
		}else {
			int middle = (begin+end)/2;
			if(data[middle] == target) {
				return middle;
			}else {
				int index = search3(data, begin, middle-1, target);
				if(index != -1) {
					return index;
				}else {
					return search3(data, middle+1, end, target);
				}
			}
		}
	}
	
	//매개변수의 명시화 : 최대값 찾기
	public static int findMax(int[] data, int begin, int end) {
		if(begin == end) {
			System.out.println(String.format("begin == end : %s", begin));
			return data[begin];
		}else {
			System.out.println(String.format("data[%s], findMax(data, %s, %s)", begin, begin+1, end));
			return Math.max(data[begin], findMax(data, begin+1, end));
		}
	}
	//매개변수의 명시화 : 최대값 찾기(다른 버전)
	public static int findMax2(int[] data, int begin, int end) {
		if(begin == end) {
			return data[begin];
		}else {
			int middle = (begin+end)/2;
			int max1 = findMax2(data, begin, middle);
			int max2 = findMax2(data, middle+1, end);
			return Math.max(max1, max2);
		}
	}
	
	//Binary Search
	public static int binarySearch(String[] items, String target, int begin, int end) {
		if(begin > end) {
			return -1;
		}else {
			int middle = (begin+end)/2;
			int comResult = target.compareTo(items[middle]);
			if(comResult == 0) {
				return middle;
			}else if(comResult == 0) {
				return binarySearch(items, target, begin, middle-1);
			}else {
				return binarySearch(items, target, middle+1, end);
				
			}
		}
	}
}


