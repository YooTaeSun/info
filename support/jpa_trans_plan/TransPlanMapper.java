package com.osstem.ows.biz.sal.sales.model;

import org.mapstruct.Mapper;

import com.osstem.ows.biz.sal.sales.model.dto.TransPlanDTO;
import com.osstem.ows.biz.sal.sales.model.entity.TransPlan;
import com.osstem.ows.cor.model.mapper.EntityMapper;

/**
 * 거래 계획 JPA Mapper
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
@Mapper(componentModel = "spring")
public interface TransPlanMapper extends EntityMapper<TransPlanDTO, TransPlan> {

    /**
     * DTO를 Entity 변경
     * @Method toEntity
     * @param TransPlanDTO
     */
	TransPlan toEntity(TransPlanDTO dto);

    /**
     * Entity를  DTO변경
     * @Method toDto
     * @param TransPlan
     */
	TransPlanDTO toDto(TransPlan entity);
}
