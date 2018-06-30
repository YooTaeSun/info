package algorism.recursive;

/*
 * http://ict-nroo.tistory.com/51
 */
public class Powerset {

//	private static char data[] = {'a','b','c','d','e','f'};
	private static char data[] = {'a','b'};
	private static int n=data.length;
	private static boolean [] include = new boolean [n];//트리상에서 현재 나의 위치를 표현한다.

	public static void main(String[] args) {
		powerSet(0);
	}

	public static void powerSet(int k) {//트리상에서 현재 나의 위치를 표현한다.
		if (k == n) {//만약 내 위치가 리프노드라면
			for (int i = 0; i < n; i++) {
				if (include[i])
					//System.out.println(" [i >> " + i + " " + Arrays.toString(include) + "]");
					System.out.print(data[i] + " ");
			}
			System.out.println();
			return;
		}
		include[k] = false;
		powerSet(k + 1);//먼저 왼쪽으로 내려갔다가
		include[k] = true;
		powerSet(k + 1);//이번에 오른쪽으로 내려간다.
		
	}
}
 