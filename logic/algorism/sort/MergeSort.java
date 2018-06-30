package algorism.sort;

import java.util.Arrays;

/*
 * 
 * Sort - 기본적인 정렬 알고리즘(선택,삽입,버블)
 * http://new93helloworld.tistory.com/103?category=691028 
 * 
 * 퀵정렬(Quick sort) 
 * http://new93helloworld.tistory.com/105?category=691028
 * 
 * 합병정렬(Merge sort)​
	mergeSort(A[], p, r) {
	  base case 정의; //p>=r인 경우
	  if (p < r) then {
	    q <- (p + q) / 2;       //p, q의 중간 지점 계산
	    mergeSort(A, p, q);     //전반부 정렬
	    mergeSort(A, q+1, r);   //후반부 정렬
	    merge(A, p, q, r);      //합병
	  }
	}
	​
	merge(A[], p, q, r) {
	  정렬되어 있는 두 배열 A[p...q]와 A[q+1...r]을 합하여
	  정렬된 하나의 배열A[p...r]을 만든다.
	}
 * 
 */
public class MergeSort {

	public static void main(String[] args) {
//		char[] data = {'A','L','G','O','R','I','T','H','M','S'};
		int[] data = {1,5,10,15,20,200,         2,3,11,12,45,70,90,100};
//		merge(data, 0, data.length/2, data.length-1);
		merge(data, 0, 5, data.length-1);
		
		print(data);
	}
	
	static void merge(int data[], int p, int q, int r){                                                               
	    int i=p, j=q+1, k=p;
	    int[] tmp = new int[data.length];
	    
	    //두 list 비교해서 작은 값 tmp로 내려준다.
	    while(i<=q && j<=r){
	        if(data[i]<=data[j]) {
	        	tmp[k++] = data[i++];
	        }else {
	        	tmp[k++] = data[j++];
	        }
	    }
	    
	    //앞쪽 리스트에 데이타가 남아있다면, 두 while문 하나만 실행
	    while (i<=q) {
	    	tmp[k++] = data[i++];
	    }
	    //뒤쪽에 남아있는 데이타가 있다면 
	    while (j<=r) {
	    	tmp[k++] = data[j++];
	    }
	    
	    //tmp에 데이타 옮겨주는 원래 배열로 옮겨준다.
	    for(i = p; i <= r; i++){
	        data[i] =  tmp[i];
	    }
	}
	
	private static void print(int[] data) {
		System.out.println(Arrays.toString(data));
	} 
}