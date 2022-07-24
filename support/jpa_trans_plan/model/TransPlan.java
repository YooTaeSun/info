package com.osstem.ows.biz.sal.sales.model.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "trans_plan")
public class TransPlan {

	/**
	 * id(PK)
	 */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "plan_id")
	private String planId;

	/**
	 * 부모 참조 fk
	 */
	@Column(name = "plan_pid")
	private String planPid;

	/**
	 * 시장구분코드명
	 */
	@Column(name = "market")
	private String market;

	/**
	 * 종목코드
	 */
	@Column(name = "code")
	private String code;

	/**
	 * 종목명
	 */
	@Column(name = "code_nm")
	private String codeNm;

	/**
	 * 상태(시작(start), 중지(stop), 매수 중지(buy_stop), 매도 중지(sell_stop), 완료(end))
	 */
	@Column(name = "status")
	private String status;

	/**
	 * 거래 종류(buy, sell)
	 */
	@Column(name = "trans_kind")
	private String transKind;

	/**
	 * 계획 가격
	 */
	@Column(name = "price")
	private Integer price;

	/**
	 * 계획 거래량
	 */
	@Column(name = "volume")
	private Integer volume;

	/**
	 * 거래 가격 종류(시장가, 지정가)
	 */
	@Column(name = "price_kind")
	private String priceKind;

	/**
	 * 삭제여부
	 */
	@Column(name = "del_Yn")
	private String delYn;

	/**
	 * 입력날짜
	 */
	@Column(name = "insert_date")
	private Date insertDate;

	/**
	 * 수정날짜
	 */
	@Column(name = "update_date")
	private Date updateDate;


}
