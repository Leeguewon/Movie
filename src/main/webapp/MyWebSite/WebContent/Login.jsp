<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://kit.fontawesome.com/8414862e5c.js" crossorigin="anonymous"></script>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="css/Login.css">
</head>
<body>

<h1> 로그인 </h1>
  <a id="logo" href="index.jsp">Megaflix</a>

  <table border="1">
      <form name="regForm" method="get" action="<%= request.getContextPath() %>/Login.do">
          <tr> 
              <td colspan="5">로그인</td>
          </tr>
          <tr> 
              <td width="30%"><i class="fa-solid fa-user">아이디</i></td>
              <td width="70%"> 
                  <input type="text" name="id" size="20">
              </td>
          </tr>
          <tr> 
              <td><i class="fa-solid fa-lock">비밀번호</i></td>
              <td><input type="password" name="password" size="20"></td>
          </tr>
          <tr> 
              <td colspan="5" align="center"> 
                <input type="submit" value="로그인">
              </td>             
          </tr>
      </form>
  </table>

</body>
</html>