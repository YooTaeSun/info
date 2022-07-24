package com.osstem.ows.biz.sal.sales.model.filter;

import com.osstem.ows.biz.cmm.model.filter.PageFilter;
import com.osstem.ows.biz.sal.sales.model.dto.TransPlanDTO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class TransPlanFilter extends TransPlanDTO {
	
	/**
	 * pageFilter 객체
	 */
	@ApiModelProperty(value = "pageFilter: pageFilter 객체")
	private PageFilter pageFilter;
}
