package com.osstem.ows.biz.sal.sales.service.repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.osstem.ows.biz.sal.sales.model.entity.TransPlan;

/**
 * 거래 계획 JPA Repo
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
@Repository
public interface TransPlanRepo extends JpaRepository<TransPlan, String> {
	
    /* id */
    List<TransPlan> findByPlanId(String planId);
    /* 부모 참조 fk */
    List<TransPlan> findByPlanPid(String planPid);
    /* 시장구분코드명 */
    List<TransPlan> findByMarket(String market);
    /* 종목코드 */
    List<TransPlan> findByCode(String code);
    /* 종목명 */
    List<TransPlan> findByCodeNm(String codeNm);
    /* 상태(시작(start), */
    List<TransPlan> findByStatus(String status);
    /* 거래 종류(buy, sell) */
    List<TransPlan> findByTransKind(String transKind);
    /* 계획 가격 */
    List<TransPlan> findByPrice(Integer price);
    /* 계획 거래량 */
    List<TransPlan> findByVolume(Integer volume);
    /* 거래 가격 종류(시장가, 지정가) */
    List<TransPlan> findByPriceKind(String priceKind);
    /* 삭제여부 */
    List<TransPlan> findByDelYn(String delYn);
    /* 입력날짜 */
    List<TransPlan> findByInsertDate(Date insertDate);
    /* 수정날짜 */
    List<TransPlan> findByUpdateDate(Date updateDate);


    /* id */
    List<TransPlan> deleteByPlanId(String planId);


}
