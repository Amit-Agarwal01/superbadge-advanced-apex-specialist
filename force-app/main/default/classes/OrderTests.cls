/**
 * @File Name          : OrderTests.cls
 * @Description        : 
 * @Author             : wbatista@moldsoft.com.br
 * @Group              : 
 * @Last Modified By   : wbatista@moldsoft.com.br
 * @Last Modified On   : 01/02/2020 12:40:07
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    01/02/2020   wbatista@moldsoft.com.br     Initial Version
**/
@isTest
private class OrderTests {

	@TestSetup
	static void setupTestData() {
		TestDataFactory.insertTestData(1);
	}

	@isTest
	private static void orderUpdate_UnitTest() {
		Order o = [SELECT Id FROM Order LIMIT 1];
		Product2 oldProduct = [SELECT Id, Family, Name, Quantity_Ordered__c, Quantity_Remaining__c FROM Product2 LIMIT 1];

		o.Status = Constants.ACTIVATED_ORDER_STATUS;

		Test.startTest();

			update o;

		Test.stopTest();

		Product2 newProduct = [SELECT Quantity_Ordered__c FROM Product2 WHERE Id = :oldProduct.Id];
		TestDataFactory.verifyQuantityOrdered(oldProduct, newProduct, Constants.DEFAULT_ROWS);
	}

	@isTest
	private static void orderExtension_UnitTest() {}
}