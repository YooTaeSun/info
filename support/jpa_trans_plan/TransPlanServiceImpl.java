package com.osstem.ows.biz.sal.sales.service.impl;

import java.util.List;
import java.util.stream.Collectors;

import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.osstem.ows.biz.sal.sales.model.TransPlanMapper;
import com.osstem.ows.biz.sal.sales.model.dto.TransPlanDTO;
import com.osstem.ows.biz.sal.sales.model.entity.QTransPlan;
import com.osstem.ows.biz.sal.sales.model.entity.TransPlan;
import com.osstem.ows.biz.sal.sales.model.filter.TransPlanFilter;
import com.osstem.ows.biz.sal.sales.service.TransPlanService;
import com.osstem.ows.biz.sal.sales.service.repo.TransPlanRepo;
import com.osstem.ows.biz.sal.sales.service.repo.pred.TransPlanPred;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQueryFactory;

/**
 * 거래 계획 ServiceImpl
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
@Service
public class TransPlanServiceImpl implements TransPlanService {

	private static final Logger logger = LoggerFactory.getLogger(TransPlanServiceImpl.class);

	@Autowired
	@Qualifier("jpaQueryFactory")
	private JPAQueryFactory queryFactory;

	@Autowired
	private TransPlanRepo transPlanRepo;

	@Autowired
	private TransPlanMapper transPlanMapper;

	/**
	 * 거래 계획 등록
     * @Method insertTransPlan
	 * @param TransPlanFilter
     * @return 등록 건
	 */	
	@Override
	@Transactional
	public Boolean insertTransPlan(TransPlanFilter params) {

    	UsersInfoVo userInfo = SecurityUtils.getCurrentUserInfo();
		String userId = userInfo.getUserId();

		params.setFrstRegrId(userId);
		params.setLastUpdrId(userId);		
		
		TransPlan transPlan = transPlanMapper.toEntity(params);
		transPlanRepo.save(transPlan);
		
		return true;
	}

    /**
     * 거래 계획 수정
     * @Method updateTransPlan 
     * @param transPlanFilter
     * @Method updateTransPlan
     * @return 수정 건
     */
	@Override
	@Transactional
	public Boolean updateTransPlan(TransPlanFilter params) {

		if(StringUtils.isEmpty(params.getPlanId()))) {
			throw new RuntimeException("no pk");
		}
		
    	UsersInfoVo userInfo = SecurityUtils.getCurrentUserInfo();
		String userId = userInfo.getUserId();

		params.setLastUpdrId(userId);

		List<TransPlan> list = transPlanRepo.findByPlanId(params.getPlanId());
		TransPlan updateTransPlan = null;
		if(ObjectUtils.isNotEmpty(list) && list.size() == 1) {

			updateTransPlan = list.get(0);

			 /* id */
			if(StringUtils.isNotEmpty(params.getPlanId())) {
				updateTransPlan.setPlanId(params.getPlanId());
			}
			 /* 부모 참조 fk */
			if(StringUtils.isNotEmpty(params.getPlanPid())) {
				updateTransPlan.setPlanPid(params.getPlanPid());
			}
			 /* 시장구분코드명 */
			if(StringUtils.isNotEmpty(params.getMarket())) {
				updateTransPlan.setMarket(params.getMarket());
			}
			 /* 종목코드 */
			if(StringUtils.isNotEmpty(params.getCode())) {
				updateTransPlan.setCode(params.getCode());
			}
			 /* 종목명 */
			if(StringUtils.isNotEmpty(params.getCodeNm())) {
				updateTransPlan.setCodeNm(params.getCodeNm());
			}
			 /* 상태(시작(start), 중지(stop), 매수 중지(buy_stop), 매도 중지(sell_stop), 완료(end)) */
			if(StringUtils.isNotEmpty(params.getStatus())) {
				updateTransPlan.setStatus(params.getStatus());
			}
			 /* 거래 종류(buy, sell) */
			if(StringUtils.isNotEmpty(params.getTransKind())) {
				updateTransPlan.setTransKind(params.getTransKind());
			}
			 /* 계획 가격 */
			if(params.getPrice() != null ) {
				updateTransPlan.setPrice(params.getPrice());
			}
			 /* 계획 거래량 */
			if(params.getVolume() != null ) {
				updateTransPlan.setVolume(params.getVolume());
			}
			 /* 거래 가격 종류(시장가, 지정가) */
			if(StringUtils.isNotEmpty(params.getPriceKind())) {
				updateTransPlan.setPriceKind(params.getPriceKind());
			}
			 /* 삭제여부 */
			if(StringUtils.isNotEmpty(params.getDelYn())) {
				updateTransPlan.setDelYn(params.getDelYn());
			}
			 /* 입력날짜 */
			if(params.getInsertDate() != null ) {
				updateTransPlan.setInsertDate(params.getInsertDate());
			}
			 /* 수정날짜 */
			if(params.getUpdateDate() != null ) {
				updateTransPlan.setUpdateDate(params.getUpdateDate());
			}

			transPlanRepo.save(updateTransPlan);
		}
		return (updateTransPlan != null)? true:false;
	}

    /**
     * 거래 계획 삭제
     * @Method deleteTransPlan
     * @param transPlanFilter
     * @return 삭제 건 
     */
	@Override
	@Transactional
	public Boolean deleteTransPlan(TransPlanFilter params) {

		if(StringUtils.isEmpty(params.getPlanId()))) {
			throw new RuntimeException("no pk");
		}

		TransPlan transPlan = transPlanMapper.toEntity(params);
		//Erase only with pk.
		List<TransPlan> list = transPlanRepo.deleteByPlanId(params.getPlanId());
		return ObjectUtils.isNotEmpty(list)? true:false;
	}

    /**
     * 거래 계획 단건 조회
     * @Method selectTransPlan
     * @param  transPlanFilter
     * @return 조회 건
     */
	@Override
    public TransPlanDTO selectTransPlan(TransPlanFilter params) {

    	var qTransPlan = QTransPlan.transPlan;
    	TransPlanDTO one= queryFactory
    			.select(
	    			Projections.fields(TransPlanDTO.class
						,qTransPlan.planId			/* id */
						,qTransPlan.planPid			/* 부모 참조 fk */
						,qTransPlan.market			/* 시장구분코드명 */
						,qTransPlan.code			/* 종목코드 */
						,qTransPlan.codeNm			/* 종목명 */
						,qTransPlan.status			/* 상태(시작(start), 중지(stop), 매수 중지(buy_stop), 매도 중지(sell_stop), 완료(end)) */
						,qTransPlan.transKind			/* 거래 종류(buy, sell) */
						,qTransPlan.price			/* 계획 가격 */
						,qTransPlan.volume			/* 계획 거래량 */
						,qTransPlan.priceKind			/* 거래 가격 종류(시장가, 지정가) */
						,qTransPlan.delYn			/* 삭제여부 */
						,qTransPlan.insertDate			/* 입력날짜 */
						,qTransPlan.updateDate			/* 수정날짜 */

	    			))
    			.from(qTransPlan)
    			.where(TransPlanPred.where(params))
    			.fetchOne();

        return one;
    }

    /**
     * 거래 계획 건수 조회
     * @Method selectTransPlanCnt
     * @param  transPlanFilter
     * @return 건수
     */
    @Override
    public int selectTransPlanCnt(TransPlanFilter params){
    	return -1;
    }	
	
    /**
     * 거래 계획 다건 조회
     * @Method selectTransPlanList
     * @param  transPlanFilter
     * @return 조회 목록
     */
    @Override
	public List<TransPlanDTO> selectTransPlanList(TransPlanFilter params) {

    	var qTransPlan = QTransPlan.transPlan;
    	List<TransPlanDTO> list= queryFactory
    			.select(
	    			Projections.fields(TransPlanDTO.class
						,qTransPlan.planId			/* id */
						,qTransPlan.planPid			/* 부모 참조 fk */
						,qTransPlan.market			/* 시장구분코드명 */
						,qTransPlan.code			/* 종목코드 */
						,qTransPlan.codeNm			/* 종목명 */
						,qTransPlan.status			/* 상태(시작(start), 중지(stop), 매수 중지(buy_stop), 매도 중지(sell_stop), 완료(end)) */
						,qTransPlan.transKind			/* 거래 종류(buy, sell) */
						,qTransPlan.price			/* 계획 가격 */
						,qTransPlan.volume			/* 계획 거래량 */
						,qTransPlan.priceKind			/* 거래 가격 종류(시장가, 지정가) */
						,qTransPlan.delYn			/* 삭제여부 */
						,qTransPlan.insertDate			/* 입력날짜 */
						,qTransPlan.updateDate			/* 수정날짜 */

	    			))
    			.from(qTransPlan)
    			.where(TransPlanPred.where(params))
    			.fetch();

        return list;
	}

    /**
     * 거래 계획 다건 조회
     * @Method selectTransPlan2
     * @param  transPlanFilter
     * @return 조회 건
     */    
	@Deprecated
	public TransPlanDTO selectTransPlan2(TransPlanFilter params) {

		List<TransPlan> list = transPlanRepo.findByPlanId(params.getPlanId());
		TransPlanDTO transPlanDTO = null;

		if(ObjectUtils.isNotEmpty(list) && list.size() == 1) {
			transPlanDTO = transPlanMapper.toDto(list.get(0));
		}
		return transPlanDTO;
	}

    /**
     * 거래 계획 다건 조회
     * @Method selectTransPlanList2
     * @param  transPlanFilter
     * @return 조회 목록
     */	
	@Deprecated
	public List<TransPlanDTO> selectTransPlanList2(TransPlanFilter params) {
		List<TransPlan> list = transPlanRepo.findAll();
		List<TransPlanDTO> listDto = list.stream().map(transPlanMapper::toDto).collect(Collectors.toList());
		return listDto;
	}

}
