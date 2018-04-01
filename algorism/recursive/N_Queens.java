package algorism.recursive;

/*
 * N-Queens problem
 * The eight queens problem
 * 
 * 	상태공간트리
 *   - 상태공간트리란 찾는 해를 포함하는 트리
 *     즉 해가 존재한다면 그것은 반드시 이 트리의 어떤 한 노트에 해당함. 따라서 이 트리를 체계적으로 탐색하면 해를 구할수 있음
 *     
 *     뒤추적 기법(Backtracking)
 *      상태공간 트리를 깊이 우선 방식으로 탐색하여 해를 찾는 알고리즘을 말한다.
 *   
 */
public class N_Queens {
	private static int N = 4;
	static int[] cols = new int[N+1];
	
	public static void main(String[] args) {
		queens(0);
	}
	
	public static boolean queens(int level) {
		if(!promising(level)) {
			return false;
		}else if(level == N) {
			for (int i = 1; i <= N; i++) {
				System.out.println("(" + i + ", " + cols[i] + ")");
			}
			return true;
		}
		for (int i = 0; i < N; i++) {
			cols[level+1] = i;
			if(queens(level + 1)) {
				return true;
			}
		}
		return false;
	}
	
	public static boolean promising(int level) {
		for (int i = 1; i < level; i++) {
			if(cols[i] == cols[level]) {
				return false;
			}else if(level-i == Math.abs(cols[level] - cols[i])) {
				return false;
			}
		}
		return true;
	}
	
	private static void print(int[][] maze) {
		for (int i = 0; i < maze.length; i++) {
			int[] col = maze[i];
			for (int j = 0; j < col.length; j++) {
				System.out.print(col[j]);
			}
			System.out.println();
		}
	}
}
