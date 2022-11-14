<%-- 
    Document   : users
    Created on : Oct 27, 2020, 9:17:28 AM
    Author     : 584893
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Users</title>
        <style>
            .grid-container {
                display: grid;
                grid-template-columns: auto auto auto;
                padding: 10px;
            }
            .grid-item {
                margin: 15px;
            }

            .grid-item > h3 {
                /*                text-align: center;*/
            }

            table {
                width: 100%;
            }

            input, select {
                width: 100%;
                margin-bottom: 8px;
            }

            #messageBox {
                color: red;
                text-align: center;
                border-radius: 5px;
                background-color: white;
                padding: 1px;
                font-weight: bold;
                width: 250px;
                position: absolute;
                top: -300px;
                left: 50%;
                transform: translateX(-50%);
                animation: messageDropdown 4.0s ease-in-out;
                -webkit-box-shadow: 4px 4px 11px 2px #ccc; 
                -moz-box-shadow:    4px 4px 11px 2px #ccc; 
                box-shadow:         4px 4px 11px 2px #ccc;  

            }

            @keyframes messageDropdown {
                0% {top: -300px;}
                10% {top: 50px;}
                90% {top: 50px;}
                100% {top: -300px;}
            }


            .usersTable {
                font-family: Arial, Helvetica, sans-serif;
                border-collapse: collapse;
                width: 100%;
            }

            .usersTable td, .usersTable th {
                border: 1px solid #ddd;
                padding: 8px;
            }

            .usersTable tr:nth-child(even){background-color: #f2f2f2;}

            .usersTable tr:hover {background-color: #ddd;}

            .usersTable th {
                padding-top: 12px;
                padding-bottom: 12px;
                text-align: left;
            }

            input[type=text], input[type=email], input[type=password], select {
                width: 100%;
                padding: 12px 20px;
                margin: 8px 0;
                display: inline-block;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
            }

            input[type=submit] {
                width: 100%;
                background-color: #4CAF50;
                color: white;
                padding: 14px 20px;
                margin: 8px 0;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            input[type=submit]:hover {
                background-color: #45a049;
            }

            .formContainer {
                border-radius: 5px;
                background-color: #f2f2f2;
                padding: 20px;
            }


        </style>
    </head>
    <body>
        <c:if test="${message != null}">
        <div id="messageBox">
            <p>${message}</p>
        </div>
        </c:if>

        <div class="grid-container">
            <div class="grid-item">
                <div class="formContainer">
                    <h3>Add User</h3>

                    <form method="POST" action="users">
                        <input placeholder="Email" type="email" required name="email" />
                        <br>
                        <input placeholder="First Name" type="text" required name="firstname" />
                        <br>
                        <input placeholder="Last Name" type="text" required name="lastname" />
                        <br>
                        <input placeholder="Password" type="password" required name="password" />
                        <br>
                        <input type="hidden" name="action" value="add" />
                        <select name="role">
                            <option value="1" <c:if test="${user.role.id == 1}">selected</c:if>>System Admin</option>
                            <option value="2" <c:if test="${user.role.id == 2}">selected</c:if>>Regular User</option>
                            <option value="3" <c:if test="${user.role.id == 3}">selected</c:if>>Company Admin</option>
                            </select>
                            <br>
                            <input type="submit" value="Save" />
                        </form>
                    </div>
                </div>

                <div class="grid-item">
                    <h3>Manage Users</h3>
                    <table class="usersTable">
                        <tr>
                            <th>Email</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Role</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td>${user.email}</td>
                            <td>${user.firstName}</td>
                            <td>${user.lastName}</td>
                            <td>${user.role.name}</td>
                            
                            <c:url value="users" var="editurl">
                            <c:param name="action" value="edit"/>
                            <c:param name="email" value="${user.email}"/>
                            </c:url>
                            <td><a href="${editurl}">Edit</a></td>
                            
                            <c:url value="users" var="deleteurl">
                            <c:param name="action" value="delete"/>
                            <c:param name="email" value="${user.email}"/>
                            </c:url>                     
                            <td><a href="${deleteurl}">Delete</a></td>
                        </tr>

                    </c:forEach>
                </table>
            </div>

            <div class="grid-item">
                <div class="formContainer">
                    <h3>Edit User</h3>
                    <form method="POST" action="users">
                        <input placeholder="First Name" type="text" required name="firstname" value="${editUser.firstName}" />
                        <br>
                        <input placeholder="Last Name" type="text" required name="lastname" value="${editUser.lastName}" />
                        <br>
                        <input type="hidden" name="email" value="${editUser.email}" />
                        <input type="hidden" name="action" value="update" />
                        <select name="role">
                            <option value="1" <c:if test="${editUser.role.id == 1}">selected</c:if>>System Admin</option>
                            <option value="2" <c:if test="${editUser.role.id == 2}">selected</c:if>>Regular User</option>
                            <option value="3" <c:if test="${editUser.role.id == 3}">selected</c:if>>Company Admin</option>
                        </select>
                        <br>
                        <input type="submit" value="Update" />
                    </form>
                </div>
            </div>  
        </div>
    </body>
</html>
