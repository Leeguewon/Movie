<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="admin_top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/common.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<script src="https://kit.fontawesome.com/8414862e5c.js" crossorigin="anonymous"></script>
<script>function Alert(){ alert("로그인 후 이용해주세요") }
		function Alert2(){ alert("영화를 먼저 선택해세요")}
</script>
<title> 8조 백엔드 드라마페이지 </title>
<style>
    body {
        position: relative;
        background-image: url('https://assets.nflxext.com/ffe/siteui/vlv3/9737377e-a430-4d13-ad6c-874c54837c49/945eec79-6856-4d95-b4c6-83ff5292f33d/KR-ko-20220111-popsignuptwoweeks-perspective_alpha_website_large.jpg');
        background-size: cover;
        background-position: center;
        background-attachment: fixed;
        height: 100vh;
    }

    body::after {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5); /* 반투명 검정 오버레이 */
        filter: blur(10px); /* 블러 효과 */
        pointer-events: none; /* 마우스 이벤트가 배경에 영향을 미치지 않도록 */
        z-index: -1; /* 배경 이미지를 가리지 않도록 */
    }
</style>

</head>
<body>
  <header>
  <section id="top">
    <% 
		if(mem_id != null){ 
	%>
			<a id="logo" href="index_USER.jsp">Megaflix</a>	
	<% } else { %>
		    <a id="logo" href="index.jsp">Megaflix</a>	
	<% } %>
      <nav id="top_menu">
    	<div>
    	 <ul>    
		 <% 
		 	if(mem_id != null){  %>   <!-- 로그인 함 -->
		 	<li style="color: white; font-weight: bold; font-size: 15pt;"><%= mem_id %>님</li>
		    <li class="green"><a href="<%= request.getContextPath() %>/logout.do"><i class="fa-solid fa-lock-open">로그 아웃</i></a></li>
		    <li class="green"><a href="mypage_USER.jsp"><i class="fa-solid fa-user">마이페이지</i></a></li>
          	<li class="green"><a href="customer_service.jsp"><i class="fa-solid fa-headset">고객센터</i></a></li> 
          		<%if (mem_role.equals("관리자")) {%>
          			<li class="green"><a href="admin_Approve.jsp"><i class="fa-solid fa-cloud">관리자</i></a></li>
          		<% } %>	
	    <% } else { %>
		    <li class="green"><a href="Login.jsp"><i class="fa-solid fa-lock">로그인</i></a></li>
		    <li class="green"><a href="register.jsp"><i class="fa-solid fa-user-plus">회원가입</i> </a></li>
		    <li class="green"><a href="Login.jsp"><i class="fa-solid fa-user">마이페이지</i></a></li>
          	<li class="green" onclick="Alert()"><a href=""><i class="fa-solid fa-headset">고객센터</i></a></li> 
	    <% } %>	
        </ul>
        </div>
      </nav> <!-- top_menu -->

      <div class="clear"></div>
     </section> <!-- section top -->

      <ndav id="main_menu">
      <h2><ul>
            <li><a href="movie.jsp">영화</a></li>
            <li><a href="Date.jsp">예매</a></li>
            <li><a href="theater.jsp">극장</a></li>
            <li><a href="event.jsp">이벤트</a></li>
            <li><a href="store.jsp">스토어</a></li>
            <li><a href="drama.jsp">드라마</a></li>
        </ul></h2> 
      </nav>
  </header> <!--header -->
<div style="display: flex; justify-content: center; align-items: center;">
  <iframe width="800" height="350" src="https://www.youtube.com/embed/ApaD16gn3gI" title="🤶 CGV X 모아나2 굿즈 키링 #Shorts 🎅" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
</div>

  <section id="main">

    <section id="recommend">
      <h3><a href="#">스토어 ></a></h3>
      <div class="item">
          <ul>
            <li><img src="https://search.pstatic.net/sunny/?src=https%3A%2F%2Fpng.pngtree.com%2Fpng-clipart%2F20231018%2Foriginal%2Fpngtree-pop-corn-food-pixelated-png-image_13355850.png&type=a340" width="210" height="210" alt="우마이봉(6gx15개)"></li>
            <li class="subject">카라멜 팝콘 할인</li>
            <li class="comment">
            <li class="price">4,000원</li>
          </ul>
      </div>
          <div class="item">
          <ul>
            <li><img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNDA0MDlfMjU4%2FMDAxNzEyNjMzNTIxOTA5.1N9sXXw99i2dnRQdtKvftccKUW31mi3-3A08c0fZxO0g.iZDcic9LxEgYFA94r18L1Vo91h2Bpv_Zb0tnukTMgtQg.PNG%2Fimage.png&type=a340" width="210" height="210" alt="후룻바이더풋(10gx3개)"></li>
            <li class="subject">콜라 할인</li>
            <li class="comment">
            <li class="price">1,000원</li>
          </ul>
      </div>
      <div class="item">
          <ul>
            <li><img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzA2MjVfMjQg%2FMDAxNjg3Njk0OTE2NTgy.lHpfvH0emnpndxIFS-kwZPhzp5ImuxluTR5dDmVs7LAg.wJoWBdWllgBT6JSVgQCqe0a4ny22b5uo0u8U8y9Ve3kg.JPEG.syjmaru%2FIMG_2691.jpg&type=a340" width="210" height="210" alt="미니멘토스(10gx10개)"></li>
            <li class="subject">컴포트석 할인</li>
            <li class="comment">
            <li class="price">15,000원</li>
          </ul>
      </div>
      <div class="item">
          <ul>
            <li><img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNDEwMjNfMTQw%2FMDAxNzI5NjU4MjcwOTky.-m4q5lTv-0p9oKhT66CBpUdYppJ3w8zDyCJqwcXbpEIg.pbjqlfCqjruOoip_MvSyQd2tKSi88VYK_VG_sjFqk64g.PNG%2Fimage.png&type=a340" width="210" height="210" alt="카스테이블워터크래커(125g)"></li>
            <li class="subject">영화 관람 시 주차 3시간 무료</li>
            <li class="comment"></li>
            <li class="price">무료</li>
          </ul>
      </div>
            <div class="item">
          <ul>
            <li><img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fimgnews.naver.net%2Fimage%2F5575%2F2024%2F11%2F26%2F0000521686_002_20241126084015067.jpeg&type=a340" width="210" height="210" alt="카스테이블워터크래커(125g)"></li>
            <li class="subject">모아나 심장 목걸이 키링</li>
            <li class="comment"></li>
            <li class="price">15,000원</li>
          </ul>
      </div>
            <div class="item">
          <ul>
            <li><img src="https://search.pstatic.net/common/?src=https%3A%2F%2Fimgnews.pstatic.net%2Fimage%2Forigin%2F5484%2F2024%2F11%2F26%2F163065.jpg&type=ofullfill208_208_empty&expire=2&refresh=true" width="210" height="210" alt="카스테이블워터크래커(125g)"></li>
            <li class="subject">모아나 둥둥 마그넷</li>
            <li class="comment"></li>
            <li class="price">20,000</li>
          </ul>
      </div>
            <div class="item">
           <ul>
            <li><img src="https://search.pstatic.net/common/?src=https%3A%2F%2Fimgnews.pstatic.net%2Fimage%2Forigin%2F5575%2F2024%2F11%2F26%2F521686.jpg&type=ofullfill208_208_empty&expire=2&refresh=true" width="210" height="210" alt="카스테이블워터크래커(125g)"></li>
            <li class="subject">모아나 롱 솜사탕</li>
            <li class="comment"></li>
            <li class="price">관람 시 무료</li>
          </ul>
      </div>
            <div class="item">
          <ul>
            <li><img src="https://search.pstatic.net/common/?src=https%3A%2F%2Fshopping-phinf.pstatic.net%2Fmain_8559826%2F85598268864.jpg&type=f372_372" width="210" height="210" alt="우마이봉(6gx15개)"></li>
            <li class="subject">하이네켄 생맥주</li>
            <li class="comment">
            <li class="price">4,000원</li>
          </ul>
      </div>
            <div class="item">
          <ul>
            <li><img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNDA1MTJfMTY2%2FMDAxNzE1NTIwODYyNDc2.VSpHcVs7EEl_1RY-Go6-W5nN-Eln5mnoKp-9-HL8V6Mg.Hjr2zzwG-ng_ktU18_BD1relw1NzKxHocy1s3ro0NxMg.JPEG%2FIMG_6521.jpg&type=a340" width="210" height="210" alt="우마이봉(6gx15개)"></li>
            <li class="subject">떡볶이</li>
            <li class="comment">
            <li class="price">5,000원</li>
          </ul>
      </div>
            <div class="item">
          <ul>
            <li><img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fshop1.phinf.naver.net%2F20240222_122%2F1708590748112ejrKM_PNG%2F109726590783033134_2045956166.PNG&type=a340" width="210" height="210" alt="우마이봉(6gx15개)"></li>
            <li class="subject">순살치킨</li>
            <li class="comment">
            <li class="price">10,000원</li>
          </ul>
      </div>
                  <div class="item">
          <ul>
            <li><img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzEyMDlfMjI1%2FMDAxNzAyMDQ5MzUwNjk4.wlAhle62DtSzyzldNiTlu6u_i_BOBJT7tosLcBPLklEg.nfkBdiIChojNmGRzLNZyicvmfSzipll1cKGxFPpqpN8g.JPEG.bujy9898%2FIMG_5617.JPG&type=a340" width="210" height="210" alt="우마이봉(6gx15개)"></li>
            <li class="subject">인생네컷</li>
            <li class="comment">
            <li class="price">6,000원</li>
          </ul>
      </div>
            <div class="item">
          <ul>
            <li><img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNDA4MjVfMTIy%2FMDAxNzI0NTI5NjY0OTU1.Hs7kBIF6-2rxHeFGfmPDd2Ck5ETHLi8E7PL-LbkcHAkg.wBvUWWJqRp5pFg2nBMvZUiLs1TMWZ2kARegnn5Io4eEg.JPEG%2Fimage_blog3.jpg&type=a340" width="210" height="210" alt="우마이봉(6gx15개)"></li>
            <li class="subject">투슬리스 인형</li>
            <li class="comment"><img src="img/portfolio/commend_02.jpg" alt="인기상품"></li>
            <li class="price">30,000원</li>
          </ul>
      </div>

       
      
      <div class="clear"></div>
  </section> <!-- section recommend -->

     
      <footer>
          <section id="footer_menu_box">
            <nav id="footer_menu">
            <ul>
              <li><a href="#">홈</a></li>
              <li><a href="#">회사소개</a></li>
              <li><a href="#">이용약관</a></li>
              <li><a href="#">개인정보취급방침</a></li>
              <li><a href="#">적립금</a></li>
              <li><a href="#">이용안내</a></li>
            </ul>
          </nav>
        </section> <!-- section footer_menu_box -->
        
        <section id="footer_address">
            <p>Copyright ⓒ 2024 백엔드8조 All rights reserved.</br>
            전화 : 010-1234-5678 근무시간: 오전 10:00 ~ 오후 05:00</br>
            Contact every_day_with_you@nate.com for more information</br>
            법인명(상호):Megaflix </br>
            사업자 등록번호 안내 [123-45-6789] / 통신판매업 신고 제 2024-서울-2024호 [사업자정보확인]</br>
            개인정보관리책임자 :홍길동 소분 제2024-1234567호(every_day_with_you@nate.com) / 대표자(성명):홍길동</p>
        </section> <!-- section footer_address -->
      </footer>
</body>
</html>