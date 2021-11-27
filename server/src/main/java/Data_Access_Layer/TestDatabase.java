package Data_Access_Layer;

import Domain_Layer.Quote;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TestDatabase implements QuoteDB {

    @Override
    public Quote get(Integer id) {
        ArrayList<Quote> quotes = readData();
        return quotes.get(id);
    }

    @Override
    public List<Quote> all() {
        return readData();
    }

    @Override
    public Quote add(Quote quote) {

        return insertData(quote.getText(), quote.getName());
    }

    private Connection connect() {
        // SQLite connection string
        String url = "jdbc:sqlite:QuteQuoteDB.db";
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(url);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return conn;
    }


    public Quote insertData(String name, String text){
        Quote quote = Quote.create(text,name);
        String sql = "INSERT INTO quotes(name, text) VALUES(?, ?)";

        try(Connection conn = this.connect();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1,text);
            pstmt.setString(2, name);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return quote;

    }

    public ArrayList<Quote> readData(){

        ArrayList<Quote> _quoteList = new ArrayList<>();
        String sql = "SELECT * FROM quotes";

        try (Connection conn = this.connect();
             Statement stmt  = conn.createStatement();
             ResultSet rs    = stmt.executeQuery(sql)){

            while(rs.next()){
                Quote quote = Quote.create(rs.getString("text"), rs.getString("name"));
                quote.setId(rs.getInt("id"));
                _quoteList.add(quote);
            }
        }catch (SQLException e){
            System.out.println(e.getMessage());
        }

        return _quoteList;
    }
}
