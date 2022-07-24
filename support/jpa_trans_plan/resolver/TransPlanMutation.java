package com.osstem.ows.biz.sal.sales.resolver;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.osstem.ows.biz.loe.exception.CustomGraphQLException;
import com.osstem.ows.biz.sal.sales.model.filter.TransPlanFilter;
import com.osstem.ows.biz.sal.sales.service.TransPlanService;

import graphql.kickstart.tools.GraphQLMutationResolver;

/**
 * 거래 계획 GraphQL Mutation
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
public class TransPlanMutation implements GraphQLMutationResolver {

	private static final Logger logger = LoggerFactory.getLogger(TransPlanMutation.class);
	
	@Autowired
	private TransPlanService transPlanService;
	
	/**
	 * 거래 계획 등록
     * @Method addTransPlan
	 * @param TransPlanFilter
	 */
    public Boolean addTransPlan(TransPlanFilter params) {
    	try {
    		return transPlanService.insertTransPlan(params);
		} catch (Exception e) {
			logger.error("{}", e);
			throw new CustomGraphQLException(20000, e.getMessage());
		}
    }

	/**
	 * 거래 계획 수정
     * @Method modifyTransPlan
	 * @param TransPlanFilter
	 */
	public Boolean modifyTransPlan(TransPlanFilter params) {
		try {
			return transPlanService.updateTransPlan(params);
		} catch (Exception e) {
			logger.error("{}", e);
			throw new CustomGraphQLException(20000, e.getMessage());
		}
	}

	/**
	 * 거래 계획 삭제
     * @Method removeTransPlan
	 * @param TransPlanFilter
	 */
	public Boolean removeTransPlan(TransPlanFilter params) {
		try {
			return transPlanService.deleteTransPlan(params);
		} catch (Exception e) {
			logger.error("{}", e);
			throw new CustomGraphQLException(20000, e.getMessage());
		}
	}

}
