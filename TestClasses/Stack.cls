public class Stack {
    private List<Object> listOfObjects;
    
    public Stack(){
        listOfObjects = new List<Object>();
    }
    
    public void push( Object element ){
        if( element == null ){
            return;
        }
        
        listOfObjects.add(element);
    }
    
    public Object pop(){
        if( listOfObjects.size() == 0){
            throw new NullPointerException();
            return null;
        }
        
        return listOfObjects.remove( listOfObjects.size()-1 );
    }
    
    public Integer size(){
        return listOfObjects.size();
    }
}