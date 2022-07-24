/**
 * GraphQl API
 *
 */

import axios from "./base.service.js";

class GraphqlTransPlanService {

  async postGraphQl(body) {
    try {
      let result = await axios.post(`graphql/sal/sales`, body);
      return result;
    } catch (error) {
      console.log(error);
      return error;
    }
  }

  async addTransPlan(params) {

    params = {
             planId: ''    // id
            ,planPid: ''    // 부모 참조 fk
            ,market: ''    // 시장구분코드명
            ,code: ''    // 종목코드
            ,codeNm: ''    // 종목명
            ,status: ''    // 상태(시작(start), 중지(stop), 매수 중지(buy_stop), 매도 중지(sell_stop), 완료(end))
            ,transKind: ''    // 거래 종류(buy, sell)
            ,price: ''    // 계획 가격
            ,volume: ''    // 계획 거래량
            ,priceKind: ''    // 거래 가격 종류(시장가, 지정가)
            ,delYn: ''    // 삭제여부
            ,insertDate: ''    // 입력날짜
            ,updateDate: ''    // 수정날짜

    }

    let query = `mutation addTransPlan($input: TransPlanFilter) {
      one : addTransPlan(input: $input)
    }`;
    return await this.postGraphQl({ query, variables: {input:params} });
  }

  async modifyTransPlan(params) {

    let query = `mutation modifyTransPlan($input: TransPlanFilter) {
      one : modifyTransPlan(input: $input)
    }`;

    return await this.postGraphQl({ query, variables: {input:params} });
  }

  async removeTransPlan(params) {

    params = {
    }

    let query = `mutation removeTransPlan($input: TransPlanFilter) {
      one : removeTransPlan(input: $input)
    }`;

    return await this.postGraphQl({ query, variables: {input:params} });
  }

  async getTransPlan(params) {

    params = {

    }

    let query = `
    query ($params:TransPlanFilter) {
      one: getTransPlan(filter:$params) {
			planId
			planPid
			market
			code
			codeNm
			status
			transKind
			price
			volume
			priceKind
			delYn
			insertDate
			updateDate

      }
    }
    `;

    return await this.postGraphQl({ query, variables: {params} });
  }

  async getTransPlanList(params) {

    params = {

    }

    let query = `
    query ($params:TransPlanFilter) {
      cnt: getTransPlanCnt(filter:$params)   
      list: getTransPlanList(filter:$params) {
			planId
			planPid
			market
			code
			codeNm
			status
			transKind
			price
			volume
			priceKind
			delYn
			insertDate
			updateDate

      }
    }
    `;

    return await this.postGraphQl({ query, variables: {params} });
  }
}

export default new GraphqlTransPlanService();
