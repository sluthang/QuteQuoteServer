package Data_Access_Layer;
import Domain_Layer.Quote;

import java.sql.*;
import java.util.List;


public class QuteQuoteDB {

    List <Quote> quoteList ;
    final Quote quote;

    public QuteQuoteDB(Quote quote) {
        this.quote = quote;
    }

    private Connection connect() {
        // SQLite connection string
        String url = "jdbc:sqlite://home/sinethemba/IdeaProjects/QuteQuoteServer/QuteQuoteDB.db";
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(url);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return conn;
    }


    public void insertData(String name, String text){
        String sql = "INSERT INTO quotes(name, text) VALUES(?, ?)";

        try(Connection conn = this.connect();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1,quote.getName());
            pstmt.setString(2, quote.getText());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

    }

    public static void readData(){
        String sql = "SELECT * FROM quotes";

        try (Connection conn = DriverManager.getConnection("jdbc:sqlite:QuteQuoteDB.db");
             Statement stmt  = conn.createStatement();
             ResultSet rs    = stmt.executeQuery(sql)){

            while(rs.next()){
                System.out.println(rs.getInt("id") + "\t" +
                                   rs.getString("name") + "\t" +
                                   rs.getString("text"));

            }
        }catch (SQLException e){
            System.out.println(e.getMessage());
        }
    }

    /**
     * @param args the command line arguments
     */
//    public static void main(String[] args) {
//        //QuteQuoteDB quote = new QuteQuoteDB();
//       // quote.insertData("Sinethemba", "This is a quote");
//        readData();
//        //conne
//    }
}