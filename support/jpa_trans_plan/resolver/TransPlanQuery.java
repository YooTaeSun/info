package com.osstem.ows.biz.sal.sales.resolver;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.osstem.ows.biz.sal.sales.model.dto.TransPlanDTO;
import com.osstem.ows.biz.sal.sales.model.filter.TransPlanFilter;
import com.osstem.ows.biz.sal.sales.service.TransPlanService;

import graphql.kickstart.tools.GraphQLQueryResolver;

/**
 * 거래 계획 GraphQL Query
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
@Component
public class TransPlanQuery implements GraphQLQueryResolver {

	private static final Logger logger = LoggerFactory.getLogger(TransPlanMutation.class);
	
	@Autowired
	private TransPlanService transPlanService;

    /**
     * 거래 계획 단건 조회
     * @Method getTransPlan
     * @param  transPlanFilter
     * @return 조회 건
     */
    public TransPlanDTO getTransPlan(TransPlanFilter params) {
    	params = Optional.ofNullable(params).orElseGet(TransPlanFilter::new);
    	return transPlanService.selectTransPlan(params);
    }
    
    /**
     * 거래 계획 건수 조회
     * @Method getTransPlanCnt
     * @param  transPlanFilter
     * @return 건수
     */
    public int getTransPlanCnt(TransPlanFilter params){
    	params = Optional.ofNullable(params).orElseGet(TransPlanFilter::new);
    	return transPlanService.selectTransPlanCnt(params);
    }

    /**
     * 거래 계획 다건 조회
     * @Method getTransPlanList
     * @param  transPlanFilter
     * @return 조회 목록
     */
    public List<TransPlanDTO> getTransPlanList(TransPlanFilter params) {
    	params = Optional.ofNullable(params).orElseGet(TransPlanFilter::new);
    	return transPlanService.selectTransPlanList(params);
    }
}
