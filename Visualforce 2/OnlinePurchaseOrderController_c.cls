public class OnlinePurchaseOrderController_c {
    public static final String Customer_Details= Label.Customer_Details;
    public static final String Sign_In= Label.Sign_In;
    public static final String Purchase= Label.Purchase;
    public static final String Product= Label.Product;
    public static final String Filter_Results= Label.Filter_Results; 
    public static final String Search_All_available_Products= Label.Search_All_available_Products;
    public static final String First= Label.First;
    public static final String Previous= Label.Previous;
    public static final String Next= Label.Next;
    public static final String Last= Label.Last;
    public static final String Filter= Label.Filter;
    public static final String Cart= Label.Cart;
    public static final String Product_Name= Label.Product_Name;
    public static final String Product_Code= Label.Product_Code;
    public static final String Product_Category= Label.Product_Category;
    public static final String Quantity= Label.Quantity;
    public static final String Total_Price= Label.Total_Price;
    
    private final Integer SIZE = 10;

    public String searchTerm {get; set;}
    
    public PurchaseOrder__c order{get; set;}
    
    public Boolean renderProductList{get; set;}
    public Boolean renderCart {get; set;}
    
    public Id selectedProductId {get; set;}
    public Id selectedOrderItemId {get; set;}
    public String filterCategory {get; set;}

    public Map<Id, Product__c> mapOfProducts  {get; set;}
    public Map<Id, PurchaseOrderLineItem__c> mapOfOrderLineItems {get; set;}

    public OnlinePurchaseOrderController_c(){
		order = new PurchaseOrder__c();
        
        renderProductList = false;
        mapOfProducts = Product_cDAO.getAllProductDetails();
 
        renderCart = false;
        mapOfOrderLineItems = new Map<Id, PurchaseOrderLineItem__c>();
        
        searchTerm = '';
        filterCategory = '';
    }
 
    public void goToProductList(){
        if(order.Account__c != null){
        	renderProductList = true;
        }
    }
    
    public void cancel(){
    }
    
    public List<Product__c> getProducts(){
        if(this.searchTerm != ''){
			return Product_cDAO.getAllProductDetails( mapOfProducts, this.searchTerm );
        }
        
        return mapOfProducts.values();
    }

    public void addToCart(){
        if(!renderCart){            
 	       renderCart = true;
        }
        
        Product__c product = mapOfProducts.remove(selectedProductId);
		PurchaseOrderLineItem__c orderItem = new PurchaseOrderLineItem__c(
            Product__c = product.Id,
            Product__r = product,
			UnitPrice__c = product.UnitPrice__c,
            Quantity__c = 1);
        
        mapOfOrderLineItems.put( product.Id , orderItem );
    }
    
    public List<PurchaseOrderLineItem__c> getOrderLineItems(){
    	if(filterCategory != ''){
            List<PurchaseOrderLineItem__c> listOfPurchaseOrderLineItem =
                new List<PurchaseOrderLineItem__c>();
            List<Product__c> listOfProducts = 
                Product_cDAO.getProductByCategory(mapOfOrderLineItems.keySet(), filterCategory );
            
            for(Product__c product :listOfProducts){
                if( mapOfOrderLineItems.containsKey( product.Id ) ){
                    listOfPurchaseOrderLineItem.add( mapOfOrderLineItems.get(product.Id) );
                }
            }
        }

        return mapOfOrderLineItems.values();
    }
    
    public void removeFromCart(){
        Product__c product = mapOfOrderLineItems.remove( selectedOrderItemId ).Product__r;		        
        mapOfProducts.put( product.Id, product);
        
        if(mapOfOrderLineItems.size() <= 0){
            renderCart = false;
        }
    }
    
    public List<SelectOption> getFilterCategories(){
        List<SelectOption> listOfSelectOptions = new List<SelectOption>();
        
        for(String category : Product_cDAO.getProductCategory() ){
        	listOfSelectOptions.add( new SelectOption( category, category )  );
        }
        
        return listOfSelectOptions;
    }
    
    public PageReference checkout(){
        return new PageReference('/apex/CheckoutOrder_c');
    }
    
    public PageReference placeOrder(){
        insert order;

        for(PurchaseOrderLineItem__c orderItem :mapOfOrderLineItems.values() ){
        	orderItem.PurchaseOrder__c = order.Id;
            orderItem.PurchaseOrder__r = order;
        }
        insert mapOfOrderLineItems.values();
		order = PurchaseOrder_cDAO.getOrderDetails(order.Id);

        return new PageReference('/apex/OrderDetails_c');
    }
    
    public PageReference back(){
        return new PageReference('/apex/OnlinePurchaseOrder_c');
    }
    
    public void search(){
    }
    
    public Integer noOfRecords {get; set;}
    public ApexPages.StandardSetController availableProductsList {
       get {
           if(availableProductsList == null) {    
               availableProductsList = new ApexPages.StandardSetController(mapOfProducts.values());
               availableProductsList.setPageSize(SIZE);  
               noOfRecords = availableProductsList.getResultSize();
           }           
           renderProductList = true;
           return availableProductsList;
       }
       set;
   }
}