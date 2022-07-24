package com.osstem.ows.biz.sal.sales.model.dto;
import java.util.Date;
import io.swagger.annotations.ApiModelProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class TransPlanDTO {

	/**
	 * id(PK)
	 */
	@ApiModelProperty(value = "planId: id")
	private String planId;

	/**
	 * 부모 참조 fk
	 */
	@ApiModelProperty(value = "planPid: 부모 참조 fk")
	private String planPid;

	/**
	 * 시장구분코드명
	 */
	@ApiModelProperty(value = "market: 시장구분코드명")
	private String market;

	/**
	 * 종목코드
	 */
	@ApiModelProperty(value = "code: 종목코드")
	private String code;

	/**
	 * 종목명
	 */
	@ApiModelProperty(value = "codeNm: 종목명")
	private String codeNm;

	/**
	 * 상태(시작(start), 중지(stop), 매수 중지(buy_stop), 매도 중지(sell_stop), 완료(end))
	 */
	@ApiModelProperty(value = "status: 상태(시작(start), 중지(stop), 매수 중지(buy_stop), 매도 중지(sell_stop), 완료(end))")
	private String status;

	/**
	 * 거래 종류(buy, sell)
	 */
	@ApiModelProperty(value = "transKind: 거래 종류(buy, sell)")
	private String transKind;

	/**
	 * 계획 가격
	 */
	@ApiModelProperty(value = "price: 계획 가격")
	private Integer price;

	/**
	 * 계획 거래량
	 */
	@ApiModelProperty(value = "volume: 계획 거래량")
	private Integer volume;

	/**
	 * 거래 가격 종류(시장가, 지정가)
	 */
	@ApiModelProperty(value = "priceKind: 거래 가격 종류(시장가, 지정가)")
	private String priceKind;

	/**
	 * 삭제여부
	 */
	@ApiModelProperty(value = "delYn: 삭제여부")
	private String delYn;

	/**
	 * 입력날짜
	 */
	@ApiModelProperty(value = "insertDate: 입력날짜")
	private Date insertDate;

	/**
	 * 수정날짜
	 */
	@ApiModelProperty(value = "updateDate: 수정날짜")
	private Date updateDate;


}
