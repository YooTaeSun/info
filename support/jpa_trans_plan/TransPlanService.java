package com.osstem.ows.biz.sal.sales.service;

import java.util.List;

import com.osstem.ows.biz.sal.sales.model.dto.TransPlanDTO;
import com.osstem.ows.biz.sal.sales.model.filter.TransPlanFilter;

/**
 * 거래 계획 Service
 *
 * @author		system
 * @version		1.0
 * @Modification
 * <pre>
 *   	since			author         		description
 *  --------------  -----------------  -------------------------------------------------------
 *   2022.07.24.		system				최초작성
 * </pre>
 */
public interface TransPlanService {

	/**
	 * 거래 계획 등록
     * @Method insertTransPlan
	 * @param TransPlanFilter
	 */
	public Boolean insertTransPlan(TransPlanFilter params);

	/**
	 * 거래 계획 수정
     * @Method insertTransPlan
	 * @param TransPlanFilter
	 */
	public Boolean updateTransPlan(TransPlanFilter params);

	/**
	 * 거래 계획 삭제
     * @Method insertTransPlan
	 * @param TransPlanFilter
	 */	
	public Boolean deleteTransPlan(TransPlanFilter params);

    /**
     * 거래 계획 단건 조회
     * @Method selectTransPlan
     * @param  transPlanFilter
     * @return 조회 건
     */
	public TransPlanDTO selectTransPlan(TransPlanFilter params);
	
    /**
     * 거래 계획 건수 조회
     * @Method selectTransPlanCnt
     * @param  transPlanFilter
     */
    public int selectTransPlanCnt(TransPlanFilter params);
    
    /**
     * 거래 계획 다건 조회
     * @Method selectTransPlanList
     * @param  transPlanFilter
     * @return 조회 목록
     */	
	public List<TransPlanDTO> selectTransPlanList(TransPlanFilter params);

}
