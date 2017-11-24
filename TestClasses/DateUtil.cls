public class DateUtil {
	/**
     * Create a function which take 2 dates 
     * as argument and return number of working days between
     * two days excluding both days
     * (Saturday and Sunday is nonworking)
	*/
    public static Integer getWeekdayDifference(Date date1, Date date2){
        Integer workingWeekdays = 0;
       	DateTime startDate,endDate;
        
        if(date1 == null || date2 == null){
        	return workingWeekdays;    
        }
     
        if(date1<date2){
   			startDate = DateTime.newInstance(date1.year(),date1.month(),date1.day(),0,0,0);
           	endDate =   DateTime.newInstance(date2.year(),date2.month(),date2.day(),0,0,0);
       	}else{
           startDate = DateTime.newInstance(date2.year(),date2.month(),date2.day(),0,0,0);
           endDate =   DateTime.newInstance(date1.year(),date1.month(),date1.day(),0,0,0);
       }
        
       while (startDate <= endDate) {
          if (startDate.format('E') != 'Sat' && startDate.format('E') != 'Sun') {
               workingWeekdays++;
          }
           
       	  startDate = startDate.addDays(1);
       }
        
       return workingWeekdays;
    }
}