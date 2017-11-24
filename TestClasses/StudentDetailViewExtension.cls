public class StudentDetailViewExtension {
    public String First_Name { get{ return Label.First_Name; } }
    public String Last_Name { get{ return Label.Last_Name; } }
    public String ClassLabel { get{ return Label.ClassLabel; } }
    
    public StudentDetailViewExtension(ApexPages.StandardController controller){
    }
}