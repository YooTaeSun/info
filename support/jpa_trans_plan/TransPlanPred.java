package com.osstem.ows.biz.sal.sales.service.repo.pred;

import org.apache.commons.lang3.StringUtils;

import com.osstem.ows.biz.sal.sales.model.entity.QTransPlan;
import com.osstem.ows.biz.sal.sales.model.filter.TransPlanFilter;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.Predicate;

/**
 * 거래 계획 JPA Pred
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
public class TransPlanPred {

	public static Predicate where(TransPlanFilter params) {
 
		QTransPlan qTransPlan = QTransPlan.transPlan;

		BooleanBuilder builder = new BooleanBuilder();
		
         /* id */
        if(StringUtils.isNotEmpty(params.getPlanId())) {
            builder.and(qTransPlan.planId.eq(params.getPlanId()));
        }

         /* 부모 참조 fk */
        if(StringUtils.isNotEmpty(params.getPlanPid())) {
            builder.and(qTransPlan.planPid.eq(params.getPlanPid()));
        }

         /* 시장구분코드명 */
        if(StringUtils.isNotEmpty(params.getMarket())) {
            builder.and(qTransPlan.market.eq(params.getMarket()));
        }

         /* 종목코드 */
        if(StringUtils.isNotEmpty(params.getCode())) {
            builder.and(qTransPlan.code.eq(params.getCode()));
        }

         /* 종목명 */
        if(StringUtils.isNotEmpty(params.getCodeNm())) {
            builder.and(qTransPlan.codeNm.eq(params.getCodeNm()));
        }

         /* 상태(시작(start), */
        if(StringUtils.isNotEmpty(params.getStatus())) {
            builder.and(qTransPlan.status.eq(params.getStatus()));
        }

         /* 거래 종류(buy, sell) */
        if(StringUtils.isNotEmpty(params.getTransKind())) {
            builder.and(qTransPlan.transKind.eq(params.getTransKind()));
        }

         /* 계획 가격 */
        if(params.getPrice() != null ) {
            builder.and(qTransPlan.price.eq(params.getPrice()));
        }

         /* 계획 거래량 */
        if(params.getVolume() != null ) {
            builder.and(qTransPlan.volume.eq(params.getVolume()));
        }

         /* 거래 가격 종류(시장가, 지정가) */
        if(StringUtils.isNotEmpty(params.getPriceKind())) {
            builder.and(qTransPlan.priceKind.eq(params.getPriceKind()));
        }

         /* 삭제여부 */
        if(StringUtils.isNotEmpty(params.getDelYn())) {
            builder.and(qTransPlan.delYn.eq(params.getDelYn()));
        }

         /* 입력날짜 */
        if(params.getInsertDate() != null ) {
            builder.and(qTransPlan.insertDate.eq(params.getInsertDate()));
        }

         /* 수정날짜 */
        if(params.getUpdateDate() != null ) {
            builder.and(qTransPlan.updateDate.eq(params.getUpdateDate()));
        }


		return builder;
	}
}
