<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>8조 회원가입 페이지</title>
    
    <!-- 외부 CSS 파일 링크 -->
<link rel="stylesheet" type="text/css" href="css/register.css">
</head>
<body>
<h1><p>MegaFlix에 오신걸 환영합니다.</p></h1>


  <a id="logo" href="index.jsp">Megaflix</a>

  <table border="1">
      <form name="regForm" method="get" action="<%= request.getContextPath() %>/Register.do">
          <tr> 
              <td colspan="2"><b>회원 가입</b></td>
          </tr>
          <tr> 
              <td width="35%">아이디</td>
              <td width="65%">
                  <input type="text" name="id" size="20">
              </td>
          </tr>
          <tr> 
              <td>비밀번호</td>
              <td><input type="password" name="password" size="20"></td>
          </tr>
          <tr> 
              <td>비밀번호 확인</td>
              <td><input type="password" name="RePassword" size="20"></td>
          </tr>
          <tr> 
              <td>이름</td>
              <td><input type="text" name="name" size="20"></td>
          </tr>
          <tr>  
              <td>역할</td>
              <td>
                  <select name="role">
                      <option value="0">선택하세요.</option>
                      <option value="관리자">관리자</option>
                      <option value="일반">일반</option>
                  </select>
              </td>
          </tr>
          <tr> 
              <td colspan="2" align="center"> 
                <input type="submit" value="회원가입">
                <input type="reset" value="초기화"> 
              </td>
          </tr>
      </form>
  </table>

</body>
</html>
