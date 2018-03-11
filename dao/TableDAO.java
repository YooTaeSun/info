package com.townsi.table.dao;

import com.townsi.boot.AbstractDAO;
import java.util.HashMap;
import java.util.List;
import org.springframework.stereotype.Repository;

@Repository("tableDAO")
public class TableDAO extends AbstractDAO {
	public List<HashMap> list(HashMap vo) throws Exception {
		return selectList("com.townsi.table.tableDAO.selectList", vo);
	}
}