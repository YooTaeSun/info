package algorism.sort;

import java.util.Arrays;

/*
http://ict-nroo.tistory.com/52?category=698685
*/
public class BasicSort {
	private static int[] input1 = { 5, 6, 2, 8, 7, 23, 4, 1 };
	private static int[] input2 = { 5, 6, 2, 8, 7, 23, 4, 1 };
	private static int[] input3 = { 5, 6, 2, 8, 7, 23, 4, 1 };

	public static void main(String[] args) {
		selectionSortMin(input1, input1.length);
		System.out.printf("selectionSortMin %s", Arrays.toString(input1));
		System.out.println("");

		bubbleSort(input2, input2.length);
		System.out.printf("bubbleSort %s", Arrays.toString(input2));
		System.out.println("");
		
		insertionSort(input3, input3.length);
		System.out.printf("insertionSort %s", Arrays.toString(input3));
	}

	/*
	 * 
	 * Selection Sort 각 루프마다 최대 원소를 찾는다 최대 원소와 맨 오른쪽 원소를 교환한다. 맨 오른쪽 원소를 제외한다. 하나의
	 * 원소만 남을 때까지 위의 루프를 반복한다.
	 * 
	 * 
	 * 
		selectionSort(A[], n) {
		  for last <- n downto 2 {                              == 1
		    A[1,...,last] 중 가장 큰 수 A[k]를 찾는다;               == 2
		    A[k] <-> A[last];  // A[k]와 A[last]의 값을 교환       == 3
		  }
		}
	 */
	private static void selectionSortMin(int[] input, int length) {
		int min;
		int tmp;
		for (int i = 0; i < length - 1; i++) {
			min = i;
			for (int j = i + 1; j < length; j++) {
				if (input[j] < input[min])
					min = j;
			}
			tmp = input[i];
			input[i] = input[min];
			input[min] = tmp;
		}
	}

	private static void selectionSortMax(int[] input, int length) {
		int max;
		int tmp;
		for (int i = length - 1; i > 0; i--) {
			max = i;
			for (int j = i - 1; j >= 0; j--) {
				if (input[j] > input[max])
					max = j;
			}
			tmp = input[i];
			input[i] = input[max];
			input[max] = tmp;
		}
	}

	/*
	 * Bubble Sort
	 */
	private static void bubbleSort(int[] input, int length) {
		int tmp;
		for (int i = length - 1; i > 0; i--)
			for (int j = 0; j < i; j++) {
				if (input[j] > input[j + 1]) {
					tmp = input[j];
					input[j] = input[j + 1];
					input[j + 1] = tmp;
				}
			}
	}

	/*
	 * Insertion Sort
	 */
	private static void insertionSort(int[] input, int length) {
		int tmp;
		for (int i = 1; i < length; i++) {
			for (int j = i; j > 0; j--) {
				if (input[j - 1] > input[j]) {
					tmp = input[j - 1];
					input[j - 1] = input[j];
					input[j] = tmp;
				}
			}
		}
	}
}
