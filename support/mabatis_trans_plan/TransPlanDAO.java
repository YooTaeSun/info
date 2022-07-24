package com.osstem.ows.biz.sal.sales.service.dao;

import java.util.List;

import com.osstem.ows.biz.cfg.datasource.OwsMapper;
import com.osstem.ows.biz.sal.sales.model.dto.TransPlanDTO;
import com.osstem.ows.biz.sal.sales.model.filter.TransPlanFilter;

/**
 * 거래 계획 DAO
 *
 * @author		system
 * @version		1.0
 * @Modification
 * <pre>
 *   	since			author         		description
 *  --------------  -----------------  -------------------------------------------------------
 *   2022.07.25.		system				최초작성
 * </pre>
 */
@OwsMapper
public interface TransPlanDAO {

	/**
     * 거래 계획 등록
     * @Method insertTransPlan
     * @param TransPlanFilter
     * @return 등록된 건수
     */	
	public int insertTransPlan(TransPlanFilter params);
	
    /**
     * 거래 계획 수정
     * @Method updateTransPlan
     * @param TransPlanFilter
     * @return 수정된 건수
     */	
	public int updateTransPlan(TransPlanFilter params);
	
    /**
     * 거래 계획 삭제 
     * @Method deleteTransPlan
     * @param TransPlanFilter
     * @return 삭제된 건수
     */	
	public int deleteTransPlan(TransPlanFilter params);
 
    /**
     * 거래 계획 단건 조회
     *
     * @param TransPlanFilter
     * @return 조회 건
     */	    
	public TransPlanDTO selectTransPlan(TransPlanFilter params);

    /**
     * 거래 계획 건수 조회
     * @Method selectTransPlanCnt
     * @param TransPlanFilter
     * @return 건수
     */	
    int selectTransPlanCnt(TransPlanFilter params);
    
    /**
     * 거래 계획 다건 조회
     * @Method selectTransPlanList
     * @param TransPlanFilter 
     * @return 조회 목록
     */	
	public List<TransPlanDTO> selectTransPlanList(TransPlanFilter params);
}
