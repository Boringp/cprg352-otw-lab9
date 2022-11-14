package dataaccess;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import models.*;

/**
 *
 * @author Alex Tompkins - 821984
 */
public class UserDB {

    public List<User> getAll() throws Exception {
        List<User> users = new ArrayList<>();
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement statement = null;
        ResultSet usersSet = null;
        ResultSet roleSet = null;

        String getUsers = "SELECT * FROM user";
        String getRole = "SELECT role_name FROM role where role_id=?";
        try {
            statement = connection.prepareStatement(getUsers);
            usersSet = statement.executeQuery();
            while (usersSet.next()) {
                String email = usersSet.getString(1);
                boolean active = usersSet.getBoolean(2);
                String firstName = usersSet.getString(3);
                String lastName = usersSet.getString(4);
                String password = usersSet.getString(5);
                int roleId = usersSet.getInt(6);

                statement = connection.prepareStatement(getRole);
                statement.setInt(1, roleId);
                roleSet = statement.executeQuery();
                roleSet.next();
                Role role = new Role(roleId, roleSet.getString(1));

                User user = new User(email, active, firstName, lastName, password, role);
                users.add(user);

                DBUtil.closeResultSet(roleSet);
            }
        } finally {
            DBUtil.closeResultSet(usersSet);
            DBUtil.closePreparedStatement(statement);
            pool.freeConnection(connection);
        }
        return users;
    }

    public User get(String email) throws Exception {
        User user = null;
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement statement = null;
        ResultSet usersSet = null;
        ResultSet roleSet = null;
        String sql = "SELECT * FROM user WHERE email=?";
        String getRole = "SELECT role_name FROM role where role_id=?";

        try {
            statement = connection.prepareStatement(sql);
            statement.setString(1, email);
            usersSet = statement.executeQuery();
            usersSet.next();
            
            String userEmail = usersSet.getString(1);
            boolean active = usersSet.getBoolean(2);
            String firstName = usersSet.getString(3);
            String lastName = usersSet.getString(4);
            String password = usersSet.getString(5);
            int roleId = usersSet.getInt(6);

            statement = connection.prepareStatement(getRole);
            statement.setInt(1, roleId);
            roleSet = statement.executeQuery();
            roleSet.next();
            Role role = new Role(roleId, roleSet.getString(1));

            user = new User(email, active, firstName, lastName, password, role);

        } finally {
            DBUtil.closeResultSet(usersSet);
            DBUtil.closePreparedStatement(statement);
            pool.freeConnection(connection);
        }

        return user;
    }

    public void insert(User user) throws Exception {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement statement = null;
        String sql = "INSERT INTO user VALUES (?, ?, ?, ?, ?, ?)";

        try {
            statement = connection.prepareStatement(sql);
            statement.setString(1, user.getEmail());
            statement.setBoolean(2, user.getActive());
            statement.setString(3, user.getFirstName());
            statement.setString(4, user.getLastName());
            statement.setString(5, user.getPassword());
            statement.setInt(6, user.getRole().getId());
            statement.executeUpdate();
        } finally {
            DBUtil.closePreparedStatement(statement);
            pool.freeConnection(connection);
        }

    }

    public void update(User user) throws Exception {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement statement = null;
        String sql = "UPDATE user SET active=?, first_name=?, last_name=?, password=?, role=? WHERE email=?";
        try {
            statement = connection.prepareStatement(sql);
            statement.setBoolean(1, user.getActive());
            statement.setString(2, user.getFirstName());
            statement.setString(3, user.getLastName());
            statement.setString(4, user.getPassword());
            statement.setInt(5, user.getRole().getId());
            statement.setString(6, user.getEmail());
            statement.executeUpdate();
        } finally {
            DBUtil.closePreparedStatement(statement);
            pool.freeConnection(connection);
        }
    }

    public void delete(User user) throws Exception {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement statement = null;
        String sql = "DELETE FROM user WHERE email=?";
        try {
            statement = connection.prepareStatement(sql);
            statement.setString(1, user.getEmail());
            statement.executeUpdate();
        } finally {
            DBUtil.closePreparedStatement(statement);
            pool.freeConnection(connection);
        }
    }
}
