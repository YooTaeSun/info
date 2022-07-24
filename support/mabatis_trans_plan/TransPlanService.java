package com.osstem.ows.biz.sal.sales.service;

import java.util.List;
import com.osstem.ows.biz.sal.sales.model.dto.TransPlanDTO;
import com.osstem.ows.biz.sal.sales.model.filter.TransPlanFilter;

/**
 * 거래 계획 서비스
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
public interface TransPlanService {

	/**
	 * 거래 계획 등록
     * @Method insertTransPlan
	 * @param TransPlanFilter
	 */
    public Boolean insertTransPlan(TransPlanFilter params);

    /**
     * 거래 계획 수정
     * @Method updateTransPlan
     * @param transPlanFilter
     */
    public Boolean updateTransPlan(TransPlanFilter params);

    /**
     * 거래 계획 삭제
     * @Method deleteTransPlan
     * @param transPlanFilter
     */
    public Boolean deleteTransPlan(TransPlanFilter params);
    
    /**
     * 거래 계획 단건 조회
     * @Method selectTransPlan 
     * @param  transPlanFilter
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
     */
    public List<TransPlanDTO> selectTransPlanList(TransPlanFilter params);

}
