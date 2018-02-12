<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="java.net.InetAddress" %>
<html>
  <head>
    <title>DB Test</title>
  </head>
  <body>

  <h2>Results</h2>
  
<table>
<tr><th>Prenom</th><th>Nom</th><th>Active</th></tr>
<%
String nom;
String prenom;
boolean active;

	
InitialContext cxt = new InitialContext();
if ( cxt == null ) {
   throw new Exception("Uh oh -- no context!");
}
//Context envContext  = (Context)initContext.lookup("java:/comp/env");
//DataSource ds = (DataSource)envContext.lookup("jdbc/customer");
DataSource ds  = (DataSource) cxt.lookup("java:/comp/env/jdbc/customer");
if ( ds == null ) {
   throw new Exception("Data source not found!");
}
Connection conn = ds.getConnection();
Statement sqlStatement = conn.createStatement();

// Generate the SQL query.
String query = "select firstname, lastname, active from customers";


// Get the query results and display them.
ResultSet sqlResult = sqlStatement.executeQuery(query);
while(sqlResult.next()) {
nom = sqlResult.getString("lastname");
prenom = sqlResult.getString("firstname");
active = sqlResult.getBoolean("active");


out.println("<tr><td>" + prenom + "</td><td>" + nom + "</td><td>" + active + "</td></tr>");
}

// Close the connection.
sqlResult.close();
sqlStatement.close();
conn.close();
%>
</table>

  </body>
</html>
