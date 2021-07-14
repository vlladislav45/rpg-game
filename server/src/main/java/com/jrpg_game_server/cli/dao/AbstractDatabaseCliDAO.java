package com.jrpg_game_server.cli.dao;

import com.jrpg_game_server.cli.config.DatabaseConfig;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.*;

public class AbstractDatabaseCliDAO extends AbstractCliDAO {
    public AbstractDatabaseCliDAO(DatabaseConfig databaseConfig) {
        super(databaseConfig);
    }

    /**
     * ##################! Work directly to the database !##################
     * example INSERT INTO users(username, password) VALUES(?,?)
     * wildcard params are the params for the query ("?")
     *
     * @param query          the query
     * @param wildcardParams the params for the wildcard
     */
    public void executeQuery(String query, Object... wildcardParams) {
        try (Statement ignored = getConnection().createStatement();
             PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            for (int i = 0; i < wildcardParams.length; i++) {
                /*
                 For some reason LocalDateTime
                 is not accepted for {@link PreparedStatement#setObject(int, Object)}
                 */
                if (wildcardParams[i] instanceof LocalDateTime)
                    pstmt.setTimestamp(i + 1, Timestamp.valueOf((LocalDateTime) wildcardParams[i]));
                else
                    pstmt.setObject(i + 1, wildcardParams[i]);
            }

            pstmt.executeUpdate();
            logger.info("Successfully executed query: " + pstmt);
        } catch (SQLException e) {
            e.printStackTrace();
            logger.error("Failed to executeUpdate query: " + query +
                    "With values " +
                    Arrays.toString(wildcardParams), e);
        }
    }

    /**
     * Executes a SELECT query with multiple results
     * every entity is represented as Map<String, Object>
     * where String is the column name, Object is the column value
     * if there are no entities from the result return empty List
     *
     * @param query the query
     * @return list of entities represented as described above
     */
    public List<Map<String, Object>> executeQueryWithMultipleResult(String query) {
        List<Map<String, Object>> objectsList = new ArrayList<>();
        try (Statement stmt = getConnection().createStatement();
             PreparedStatement ignored = getConnection().prepareStatement(query)) {
            ResultSet r = stmt.executeQuery(query);
            objectsList = parseResultSetToMap(r);
            logger.info("Successfully fetched query: " + query);
        } catch (SQLException e) {
            logger.error("Failed to execute query: " + query, e);
        }
        return objectsList;
    }

    /**
     * Get count of all rows of given table
     *
     * @param tableName   the table name
     * @param whereClause where clause for the count query (optional)
     * @return the number of rows
     */
    public int getCount(String tableName, String whereClause) {
        String query = "SELECT COUNT(*) FROM " + tableName +
                (whereClause == null ? "" : " " + whereClause);
        try (Statement stmt = getConnection().createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            rs.next();
            return rs.getInt(1);
        } catch (SQLException e) {
            logger.error("Error executing query " + query, e);
        }
        return -1;
    }

    /**
     * execute a SELECT query where the result is only 1 entity
     *
     * @param query the query
     * @return a key - value pair -> column name - column value, empty map if no entity is found
     */
    public Map<String, Object> executeQueryWithSingleResult(String query) {
        Map<String, Object> resultColumnsMap = new HashMap<>();

        try (Statement stmt = getConnection().createStatement();
             PreparedStatement ignored = getConnection().prepareStatement(query)) {
            ResultSet r = stmt.executeQuery(query);
            //Since we are sure it will be only 1 entity, and parseResultSetToMap returns List<Map>
            //we get the first element of the List
            //if the result returned no values, it will throw IndexOutOfBoundException
            //and will return empty Map
            resultColumnsMap = parseResultSetToMap(r).get(0);
            logger.info("Successfully fetched query: " + query);
            return resultColumnsMap;
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IndexOutOfBoundsException iob) {
            //Thrown when #parseResultSetToMap returns empty list ( ResultSet was empty)
            logger.warn("No results found for query: " + query);
        }

        return resultColumnsMap;
    }

    private List<Map<String, Object>> parseResultSetToMap(ResultSet r) throws SQLException {
        ResultSetMetaData metadata = r.getMetaData();
        int columnCount = metadata.getColumnCount();

        List<Map<String, Object>> entitiesList = new ArrayList<>();

        int index = 0;
        //For each entity (r.next) iterate all its columns
        //and put them in a map where key is column name
        //and value is column value
        while (r.next()) {
            entitiesList.add(new HashMap<>());

            for (int i = 1; i <= columnCount; i++) {
                String col = metadata.getColumnName(i);
                Object value = r.getObject(col);
                entitiesList.get(index).put(col, value);
            }
            index++;
        }
        return entitiesList;
    }
}
