package com.osstem.ows.biz.sal.sales.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.osstem.ows.biz.login.admin.domain.vo.UsersInfoVo;
import com.osstem.ows.biz.sal.sales.model.dto.TransPlanDTO;
import com.osstem.ows.biz.sal.sales.model.filter.TransPlanFilter;
import com.osstem.ows.biz.sal.sales.service.TransPlanService;
import com.osstem.ows.biz.sal.sales.service.dao.TransPlanDAO;
import com.osstem.ows.biz.sec.util.SecurityUtils;

/** 
 * 거래 계획 ServiceImpl
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
@Service("transPlanService")
public class TransPlanServiceImpl implements TransPlanService {

	private static final Logger logger = LoggerFactory.getLogger(TransPlanServiceImpl.class);
	
	@Autowired
    private TransPlanDAO transPlanDAO;
    
	/**
	 * 거래 계획 등록
     * @Method insertTransPlan
	 * @param TransPlanFilter
     * @return 등록 여부
	 */
    @Override
    public Boolean insertTransPlan(TransPlanFilter params){
    	
    	UsersInfoVo userInfo = SecurityUtils.getCurrentUserInfo();
		String userId = userInfo.getUserId();

		params.setFrstRegrId(userId);
		params.setLastUpdrId(userId);    	
    	
        int result = transPlanDAO.insertTransPlan(params);
        return (result > 0)? true:false;    	
    }

    /**
     * 거래 계획 수정
     * @Method updateTransPlan 
     * @param transPlanFilter
     * @Method updateTransPlan
     * @return 수정 여부
     */
    @Override
    public Boolean updateTransPlan(TransPlanFilter params){
    	
    	UsersInfoVo userInfo = SecurityUtils.getCurrentUserInfo();
		String userId = userInfo.getUserId();

		params.setLastUpdrId(userId);  	
    	
        int result = transPlanDAO.updateTransPlan(params);
        return (result > 0)? true:false;        
    }

    /**
     * 거래 계획 삭제
     * @Method deleteTransPlan
     * @param transPlanFilter
     * @return 삭제 여부 
     */
    @Override
    public Boolean deleteTransPlan(TransPlanFilter params){
        int result = transPlanDAO.deleteTransPlan(params);
        return (result > 0)? true:false;
    }
    
    /**
     * 거래 계획 단건 조회
     * @Method selectTransPlan
     * @param  transPlanFilter
     * @return 조회 건
     */
    @Override
    public TransPlanDTO selectTransPlan(TransPlanFilter params){
        return transPlanDAO.selectTransPlan(params);
    }
    
    /**
     * 거래 계획 건수 조회
     * @Method selectTransPlanCnt
     * @param  transPlanFilter
     * @return 건수
     */
    @Override
    public int selectTransPlanCnt(TransPlanFilter params){
        return transPlanDAO.selectTransPlanCnt(params);
    }

    /**
     * 거래 계획 다건 조회
     * @Method selectTransPlanList
     * @param  transPlanFilter
     * @return 조회 목록
     */
    @Override
    public List<TransPlanDTO> selectTransPlanList(TransPlanFilter params){
        return transPlanDAO.selectTransPlanList(params);
    }
}
