/**
 * @name TestDataFactory
 * @description Contains methods to construct and/or validate commonly used records
 **/
public with sharing class TestDataFactory {
	/**
	 * @name ConstructCollaborationGroup
	 * @description
	 **/
	public static CollaborationGroup ConstructCollaborationGroup() {
		CollaborationGroup chatterGroup = new CollaborationGroup(Name = 'TEST' + Constants.INVENTORY_ANNOUNCEMENTS, 
															     CollaborationType = 'Public');
		return chatterGroup;
	}

	/**
	 * @name CreateProducts
	 * @description Constructs a list of Product2 records for unit tests
	 **/
	public static List<Product2> ConstructProducts(Integer cnt) {
		List<Product2> listProducts = new List<Product2>();

		for (Integer i = 0; i < cnt; i ++) {
			Product2 prod = new Product2();
			prod.Name = 'PROD-' + i;
			prod.IsActive = true;
			prod.Initial_Inventory__c = 10;
			prod.Family = Constants.PRODUCT_FAMILY.get(math.mod(i, 4)).getValue();
			listProducts.add(prod);
		}

		return listProducts;

	}

	/**
	 * @name CreatePricebookEntries
	 * @description Constructs a list of PricebookEntry records for unit tests
	 **/
	public static List<PriceBookEntry> ConstructPricebookEntries(List<Product2> prods) {
		List<PriceBookEntry> entries = new List<PriceBookEntry>();
		for(Product2 prod :prods) {
			PriceBookEntry entry = new PriceBookEntry();
			entry.Pricebook2Id = Constants.STANDARD_PRICEBOOK_ID;
			entry.Product2Id = prod.Id;
			entry.UnitPrice = 80;
			entry.IsActive = true;
			entries.add(entry);
		}

		return entries;
	}

	/**
	 * @name CreateAccounts
	 * @description Constructs a list of Account records for unit tests
	 **/
	public static List<Account> ConstructAccounts(Integer cnt) {
		List<Account> accounts = new List<Account>();
		for(Integer i = 0; i < cnt; i ++) {
			Account acc = new Account(name = 'Account' + i);
			accounts.add(acc);
		}
		return accounts;
	}

	/**
	 * @name CreateContacts
	 * @description Constructs a list of Contacxt records for unit tests
	 **/
	public static List<Contact> ConstructContacts(Integer cnt, List<Account> accts) {
		List<Contact> contacts = new List<Contact>();
		for(Integer i = 0; i < cnt; i ++) {
			Contact con = new Contact();
			con.LastName = 'Contact' + i;
			con.AccountId = accts.get(i).Id;
			contacts.add(con);
		}
		return contacts;
	}

	/**
	 * @name CreateOrders
	 * @description Constructs a list of Order records for unit tests
	 **/
	public static List<Order> ConstructOrders(Integer cnt, List<Account> accts) {
		List<Order> orders = new List<Order>();
		for (Integer i = 0; i < cnt; i ++) {
			Order ord = new Order();
			ord.AccountId = accts.get(i).Id;
			ord.Pricebook2Id = Constants.STANDARD_PRICEBOOK_ID;
			ord.Status = 'Draft';
			ord.EffectiveDate = System.today();
			orders.add(ord);
		}
		return orders;
	}

	/**
	 * @name CreateOrderItems
	 * @description Constructs a list of OrderItem records for unit tests
	 **/
	public static List<OrderItem> ConstructOrderItems(integer cnt, list<pricebookentry> pbes, list<order> ords) {
		List<OrderItem> items = new List<OrderItem>();
		for(Integer i = 0; i < cnt; i ++) {
			OrderItem ord = new OrderItem();
			ord.PricebookEntryId = pbes.get(math.mod(i, pbes.size())).Id;
			ord.OrderId = ords.get(math.mod(i, ords.size())).Id;
			ord.Quantity = Constants.DEFAULT_ROWS;
			ord.UnitPrice = 150;
			items.add(ord);
		}

		return items;
	}

	/**
	 * @name SetupTestData
	 * @description Inserts accounts, contacts, Products, PricebookEntries, Orders, and OrderItems.
	 **/
	public static void InsertTestData(Integer cnt) {
		CollaborationGroup groups = ConstructCollaborationGroup();
		insert groups;

		List<Product2> prods = ConstructProducts(cnt);
		insert prods;

		List<PriceBookEntry> pbes = ConstructPricebookEntries(prods);
		insert pbes;

		List<Account> accts = ConstructAccounts(cnt);
		insert accts;

		List<Contact> contacts = ConstructContacts(cnt, accts);
		insert contacts;

		List<Order> ords = ConstructOrders(cnt, accts);
		insert ords;

		List<OrderItem> ordItems = ConstructOrderItems(cnt, pbes, ords);
		insert ordItems;


	}

}