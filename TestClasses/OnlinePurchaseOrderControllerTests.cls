@isTest class OnlinePurchaseOrderControllerTests {
    static final Integer noOfProducts = 3;
    static final Integer noOfAccounts = 2;
    static final String TEST_NAME = 'Product';
    static final Decimal TEST_PRICE = 5.0;
    static final String TEST_CATEGORY = 'Grocery';
    static final String productListPage = '/apex/OnlinePurchaseOrder_c';
    static final String checkoutPage = '/apex/CheckoutOrder_c';
    static final String orderDetailsPage = '/apex/OrderDetails_c';
    
    static List<Account> getAccounts(){
        return [
            SELECT Id
            FROM Account
            WHERE Name LIKE :TEST_NAME+'%'
        ];
    }
    
    static List<Product__c> getProducts(){
        return [
            SELECT Id
            FROM Product__c
            WHERE Name LIKE :TEST_NAME+'%'
        ];
    }
    
    static OnlinePurchaseOrderController getControllerClassObject(){
        OnlinePurchaseOrderController controller;
        
        if(controller == null){
            controller = new OnlinePurchaseOrderController();
        }
        return controller;   
    }
    
    @testSetup static void setup(){
        List<Account> listOfAccounts = new List<Account>();
        for(Integer index = 0; index < noOfAccounts; index++){
            Account account = new Account(Name= TEST_NAME+index);
            listOfAccounts.add(account);
        }
        insert listOfAccounts;
        
        List<Product__c> listOfProducts = new List<Product__c>();
        for(Integer index = 0; index < noOfProducts; index++ ){
            Product__c product = new Product__c(
           	    Name = TEST_NAME + index,
                UnitPrice__c = TEST_PRICE + index,
                Category__c = TEST_CATEGORY
            );
            
            listOfProducts.add(product);
        }
        insert listOfProducts;
    }
    
    @isTest static void testGoToProductListShouldRenderProductListVisible(){
        OnlinePurchaseOrderController controller = getControllerClassObject();
        controller.order.Account__c = getAccounts()[0].Id;
        
        Test.startTest();
	        controller.goToProductList();
        Test.stopTest();
        
        Boolean expected = true;
        Boolean actual = controller.renderProductList;
        
        System.assertEquals(expected, actual, 'Should Render Product List Visible');
    }
    
    @isTest static void testCancelShouldCancelCartOrrder(){
        OnlinePurchaseOrderController controller = getControllerClassObject();
        
        Test.startTest();
		    controller.cancel();
        Test.stopTest();
        
        Integer expected = 0;
        Integer actual = controller.getOrderLineItems().size();
        
        System.assertEquals(expected, actual, 'Should cancel cart order');
    }
    
    @isTest static void testGetProductsShouldReturnListOfAllProducts(){
        OnlinePurchaseOrderController controller = getControllerClassObject();
        
        Test.startTest();
		    list<Product__c> listOfProducts = controller.getProducts();
        Test.stopTest();
        
        Integer expected = noOfProducts;
        Integer actual = listOfProducts.size();
        
        System.assertEquals(expected, actual, 'Should Return List Of All Products');
    }
    
    @isTest static void testGetProductsShouldReturnListOfAllSearchedProducts(){
        OnlinePurchaseOrderController controller = getControllerClassObject();
        controller.searchTerm = TEST_NAME+0;
        
        Test.startTest();
            List<Product__c> listOfProducts = controller.getProducts();
        Test.stopTest();
        
        Integer expected = 1;
        Integer actual = listOfProducts.size();
        
        System.assertEquals(expected, actual, 'Should Return List Of All Searched Products');
    }
    
    @isTest static void testSearchShouldRerenderProductList(){
        OnlinePurchaseOrderController controller = getControllerClassObject();
        controller.searchTerm = TEST_NAME+0;
        
        Test.startTest();
            controller.search();
        Test.stopTest();
        
        Integer expected = 1;
        Integer actual = controller.getProducts().size();
        
        System.assertEquals(expected, actual, 'Should render Product List with searched products');
    }
    
    @isTest static void testAddToCartShouldRenderCartVisible(){
        OnlinePurchaseOrderController controller = getControllerClassObject();
        controller.selectedProductId = getProducts()[0].Id;
        
        Test.startTest();
            controller.addToCart();
        Test.stopTest();
        
        Boolean expected = true;
        Boolean actual = controller.renderCart;
        
        System.assertEquals(expected, actual, 'Should render cart visible and add product to cart');
    }
    
    @isTest static void testGetOrderLineItemsShouldReturnListOfCartItems(){
        OnlinePurchaseOrderController controller = getControllerClassObject();
        controller.selectedProductId = getProducts()[0].Id;
        controller.addToCart();
        
        Test.startTest();
	        List<PurchaseOrderLineItem__c> listOfPurchaseOrderLineItems = controller.getOrderLineItems();
        Test.stopTest();
        
        Integer expected = 1;
        Integer actual = listOfPurchaseOrderLineItems.size();
        
        System.assertEquals(expected, actual, 'Should Return List Of Cart Items');
    }
    
    @isTest static void testGetOrderLineItemsShouldReturnListOfAllSearchedCartItems(){
        OnlinePurchaseOrderController controller = getControllerClassObject();
        controller.selectedProductId = getProducts()[0].Id;
        controller.addToCart();
        controller.filterCategory = TEST_CATEGORY;
        
        Test.startTest();
        	List<PurchaseOrderLineItem__c> listOfPurchaseOrderLineItems = controller.getOrderLineItems();
        Test.stopTest();
        
        Integer expected = 1;
        Integer actual = listOfPurchaseOrderLineItems.size();
        
        System.assertEquals(expected, actual, 'Should Return List Of All Searched Cart Items');
    }
    
    @isTest static void testRemoveFromCartShouldRemoveItemFromCart(){
        OnlinePurchaseOrderController controller = getControllerClassObject();
        Id product = getProducts()[0].Id;
        controller.selectedProductId = product;
        controller.addToCart();
        controller.selectedOrderItemId = product;
        
        Test.startTest();
            controller.removeFromCart();
        Test.stopTest();
        
        Boolean expected = false;
        Boolean actual = controller.renderProductList;
        
        System.assertEquals(expected, actual, 'Should Remove Item From Cart');
    }
    
    @isTest static void testGetFilterCategoriesShouldReturnListOfAvailableCategories(){
        OnlinePurchaseOrderController controller = getControllerClassObject();
        
        Test.startTest();
	        List<SelectOption> listOfSelectOptions = controller.getFilterCategories();
        Test.stopTest();
        
        Integer expected = 1;
        Integer actual = listOfSelectOptions.size();
        
        System.assertEquals(expected, actual, 'Should Return List Of Available Categories');
    }
    
    @isTest static void testCheckoutShouldRedirectToCheckoutPage(){
        OnlinePurchaseOrderController controller = getControllerClassObject();
        
        Test.startTest();
	        PageReference redirect = controller.checkout();
        Test.stopTest();
        
        String expected = checkoutPage;
        String actual = redirect.getUrl();

        System.assertEquals(expected, actual, 'Should Redirect To Checkout Page');
    }
    
    @isTest static void testPlaceOrderShouldCreateAPurchaseOrder(){
        OnlinePurchaseOrderController controller = getControllerClassObject();
        controller.order.Account__c = getAccounts()[0].Id;
        
        Test.startTest();
            PageReference redirect = controller.placeOrder();
        Test.stopTest();
        
        PurchaseOrder__c expected = null;
        PurchaseOrder__c actual = controller.order;
        
        System.assertNotEquals(expected, actual, 'Should Create A Purchase Order object');
    }
    
    @isTest static void testPlaceOrderShouldRedirectToOrderDetailsPage(){
        OnlinePurchaseOrderController controller = getControllerClassObject();
        controller.order.Account__c = getAccounts()[0].Id;
        
        Test.startTest();
            PageReference redirect = controller.placeOrder();
        Test.stopTest();
        
        String expected = orderDetailsPage;
        String actual = redirect.getUrl();
        
        System.assertEquals(expected, actual, 'ShouldRedirectToOrderDetailsPage');
    }
    
    @isTest static void testBackShouldRedirectToPurchaseOrderDetails(){
        OnlinePurchaseOrderController controller = getControllerClassObject();
        
        Test.startTest();
	        PageReference redirect = controller.back();
        Test.stopTest();
        
        String expected = productListPage;
        String actual = redirect.getUrl();
        
        System.assertEquals(expected, actual, 'Should Redirect To Purchase Order Details Page');
    }
}