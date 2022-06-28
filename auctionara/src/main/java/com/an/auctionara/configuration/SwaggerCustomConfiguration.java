package com.an.auctionara.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.web.bind.annotation.RestController;

import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@EnableSwagger2		//swagger에서 사용하는 자원들을 활성화 시키는 annotation
public class SwaggerCustomConfiguration {

	
	//<bean id="api" class="springfox.documentation.spring.web.plugins.Docket"/>과 같은 의미이나 프로그래밍 코드를 사용할 수 있다
	//@Bean은 custom 설정이 가능한 구조
	@Bean
	public Docket api() {
		return new Docket(DocumentationType.SWAGGER_2)		//문서화 유형
				.select()
//					.apis(RequestHandlerSelectors.any())		//분석할 클래스 유형
//					.apis(RequestHandlerSelectors.basePackage("com.kh.springhome.rest"))			//restController만 분석하라는 코드 => 특정하기
					.apis(RequestHandlerSelectors.withClassAnnotation(RestController.class))
					.paths(PathSelectors.any())					//분석할 주소 유형
				.build()
					.apiInfo(									//문서의 대표정보를 설정하는 명령어
							new ApiInfoBuilder()
								.title("Auctionara REST API")
								.description("To explain Auctionara REST API")
								.version("0.0.1")				//초기 버전으로 설정함
								.license("MIT License")
							.build()
							)
					
				.useDefaultResponseMessages(false);				//기본메세지 OFF -> 401, 402, 403, 404 Error code 생략이 가능하다
	}
}
