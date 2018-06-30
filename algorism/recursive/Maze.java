package algorism.recursive;

/*
 * 미로찾기 (Decision Problem)
 * 현재 위치에서 출구까지 가는 경로가 있으려면
 * 1) 현재 위치가 출구이거나 혹은
 * 2) 이웃한 셀들 중 하나에서 현재 위치를 지나지 않고 출구까지 가능 경우가 있거나
 * 
 * -PATHWAY_COLOR : visited이면 아직 출구로 가는 경로가 될 가능성이 있는   cell
 * -BLOCKED_COLOR : visited이며 출구까지의 경로상의 있지 않음이 밝혀진 cell
 */
public class Maze {
	private static int N =8;
	private static int[][] maze = {
	 {0,0,0,0,0,0,0,1},
	 {0,1,1,0,1,1,0,1},
	 {0,0,0,1,0,0,0,0},
	 {0,1,0,0,1,1,0,0},
	 {0,1,1,1,0,0,1,1},
	 {0,1,0,0,0,1,0,1},
	 {0,0,0,1,0,0,0,1},
	 {0,1,1,1,0,1,0,0}
	};
	private static final int PATHWAY_COLOR = 0;//white
	private static final int WALL_COLOR= 1;//blue
	private static final int BLOCKED_COLOR= 2;//read
	private static final int PATH_COLOR= 3;//green
	
	public static void main(String[] args) {
		  printMaze(maze);
		  findMazePath(2, 0);
		  System.out.println();
		  printMaze(maze);
	}
	
	private static void printMaze(int[][] maze) {
		for (int i = 0; i < maze.length; i++) {
			int[] col = maze[i];
			for (int j = 0; j < col.length; j++) {
				System.out.print(col[j]);
			}
			System.out.println();
		}
	}

	public static boolean findMazePath(int x, int y) {
		if(x<0 || y<0 || x>=N || y>=N) {
			return false;
		}else if(maze[x][y] != PATHWAY_COLOR) {
			return false;
		}else if(x == N-1 && y==N-1) {
			maze[x][y] = PATHWAY_COLOR;
			return true;
		} else {
			maze[x][y] = PATH_COLOR;
			if(findMazePath(x-1,y) || findMazePath(x,y+1) ||
			   findMazePath(x+1,y) || findMazePath(x,y-1)) {
				return true;
			}
			maze[x][y] = BLOCKED_COLOR;	//2 read
			return false;
		}
	}
	
}
