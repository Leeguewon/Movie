<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL, java.net.URLEncoder" %>
<%@ page import="org.json.JSONArray, org.json.JSONObject" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/common.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<script src="https://kit.fontawesome.com/8414862e5c.js" crossorigin="anonymous"></script>

<title>한번의 터치, MegaFilx </title>
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
<script>function Alert(){ alert("로그인 후 이용해주세요") }</script>
  <header>
    <section id="top">
    <a id="logo" href="index.jsp">
    Megaflix
</a>
      <nav id="top_menu">
    	<div>
    	 <ul>		
    	  <li class="green"><a href="Login.jsp"><i class="fa-solid fa-lock">로그인</i></a></li>         
          <li class="green"><a href="register.jsp"><i class="fa-solid fa-user-plus">회원가입</i> </a></li>       
          <li class="green"><a href="Login.jsp"> <i class="fa-solid fa-user">마이페이지</i></a></li>    
          <li class="green" onclick="Alert()"> <a href=""><i class="fa-solid fa-headset">고객센터</i></a></li>
          <!--<li><a href="admin.jsp"> <i class="fa-solid fa-cloud">관리자</i></a></li>
        </ul>  -->
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
<video width="800" height="350" controls autoplay>
  <source src="https://cdn.pixabay.com/video/2023/11/21/190117-887464159_tiny.mp4" type="video/mp4">
  브라우저가 영상을 지원하지 않습니다.
</video>
</div>

  <section id="main">
   <h2><a href="movie.jsp">무비차트 ></a></h2>
<%
    // KOBIS API 키
    String kobisApiKey = "4c15cd987f06b6d1e0de10660650d11d"; // 본인의 KOBIS API 키
    String kmdbApiKey = "W6XJXMN69CV244OE74HS"; // 본인의 KMDb API 키
    
    // 어제 날짜 계산
    java.util.Calendar calendar = java.util.Calendar.getInstance();
    calendar.add(java.util.Calendar.DATE, -1);  // 어제 날짜로 설정
    java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyyMMdd");
    String targetDt = dateFormat.format(calendar.getTime());  // 어제 날짜 포맷

    // KOBIS API 호출
    String kobisApiUrl = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json";
    StringBuilder kobisResult = new StringBuilder();
    try {
        URL url = new URL(kobisApiUrl + "?key=" + kobisApiKey + "&targetDt=" + targetDt);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        String line;
        while ((line = reader.readLine()) != null) {
            kobisResult.append(line);
        }
        reader.close();
        conn.disconnect();
    } catch (Exception e) {
        out.println("<p>API 호출 중 오류 발생: " + e.getMessage() + "</p>");
    }

    // KOBIS JSON 파싱 및 KMDb API 호출
    try {
        JSONObject kobisResponse = new JSONObject(kobisResult.toString());
        JSONObject boxOfficeResult = kobisResponse.getJSONObject("boxOfficeResult");
        JSONArray dailyBoxOfficeList = boxOfficeResult.getJSONArray("dailyBoxOfficeList");

        // 기본 이미지 배열 (사용자가 지정할 이미지 URL을 여기에 넣으면 됨) <<<<<  영화 이미지 없으면 1. 구글에 영화 이미지 검색 -> 2. 이미지 우클릭 이미지 주소복사 -> 3.주소 밑에 넣기
        String[] defaultImages = {
        		   "http://kobis.or.kr/common/mast/movie/2024/10/thumb_x640/thn_0301a4aa15c0472e8b44817bb8f5f1e4.jpg", // 1번째 기본 이미지
                   "http://kobis.or.kr/common/mast/movie/2024/12/thumb_x640/thn_51ef01578c3641cb9453be02a9bf159c.jpg", // 2번째 기본 이미지
        };

        // 이미지가 없는 영화 카운트
        int noImageCount = 0; 

        // 상위 4위까지 출력
        out.println("<div style='display: flex; justify-content: center; gap: 20px;'>"); // Flexbox로 가로 정렬 시작
        for (int i = 0; i < Math.min(dailyBoxOfficeList.length(), 4); i++) {
            JSONObject movie = dailyBoxOfficeList.getJSONObject(i);
            String rank = movie.getString("rank");
            String movieNm = movie.getString("movieNm");

            // KMDb API 호출
            String encodedMovieNm = URLEncoder.encode(movieNm, "UTF-8"); // 영화 이름 URL 인코딩
            String kmdbUrl = "http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&title=" + encodedMovieNm + "&ServiceKey=" + kmdbApiKey;
            StringBuilder kmdbResult = new StringBuilder();
            String posterUrl = "";

            try {
                URL kmdbApiUrl = new URL(kmdbUrl);
                HttpURLConnection kmdbConn = (HttpURLConnection) kmdbApiUrl.openConnection();
                kmdbConn.setRequestMethod("GET");

                BufferedReader kmdbReader = new BufferedReader(new InputStreamReader(kmdbConn.getInputStream(), "UTF-8"));
                String kmdbLine;
                while ((kmdbLine = kmdbReader.readLine()) != null) {
                    kmdbResult.append(kmdbLine);
                }
                kmdbReader.close();
                kmdbConn.disconnect();

                // JSON 파싱하여 포스터 URL 추출
                JSONObject kmdbResponse = new JSONObject(kmdbResult.toString());
                JSONArray data = kmdbResponse.getJSONArray("Data");

                if (data.length() > 0) {
                    JSONArray resultList = data.getJSONObject(0).getJSONArray("Result");
                    if (resultList.length() > 0) {
                        JSONObject movieData = resultList.getJSONObject(0);
                        String posters = movieData.optString("posters"); // 포스터 URL 추출
                        if (!posters.isEmpty()) {
                            String[] posterArray = posters.split("\\|");
                            posterUrl = posterArray[0]; // 첫 번째 포스터 URL 선택
                        }
                    }
                }

            } catch (Exception e) {
                out.println("<p>KMDb 호출 중 오류 발생: " + e.getMessage() + "</p>");
            }

            // 영화 제목과 포스터만 출력
            out.println("<div class='movie-item' style='text-align: center; margin-left: 5px; margin-right: 5px;'>");
            out.println("<h3 style='color: white;'>" + rank + ". " + movieNm + "</h3>");

            // 포스터가 있다면 해당 포스터 출력, 없다면 기본 이미지 사용
            if (!posterUrl.isEmpty()) {
                out.println("<div class='poster-container'>");
                out.println("<img src='" + posterUrl + "' alt='" + movieNm + " poster' class='poster' />");
                out.println("<a href='Date.jsp?movie=" + URLEncoder.encode(movieNm, "UTF-8") + "&posterUrl=" + URLEncoder.encode(posterUrl, "UTF-8") + "' class='btn-reserve'>예매하기</a>");
                out.println("</div>");
            } else {
                // 포스터가 없을 경우 기본 이미지를 순차적으로 사용
                String selectedImage = defaultImages[noImageCount];
                noImageCount = (noImageCount + 1) % defaultImages.length;  // 순차적으로 이미지 변경, 3개까지 반복

                out.println("<div class='poster-container'>");
                out.println("<img src='" + selectedImage + "' alt='" + movieNm + " poster' class='poster' />");
                out.println("<a href='Date.jsp?movie=" + URLEncoder.encode(movieNm, "UTF-8") + "&posterUrl=" + URLEncoder.encode(selectedImage, "UTF-8") + "' class='btn-reserve'>예매하기</a>");
                out.println("</div>");
            }

            out.println("</div>");
        }
        out.println("</div>"); // Flexbox로 가로 정렬 끝
    } catch (Exception e) {
        out.println("<p>JSON 파싱 중 오류 발생: " + e.getMessage() + "</p>");
    }
%>


<!-- 스타일 추가 -->
<style>
    .movie-item {
        position: relative;
        margin-bottom: 20px;
    }

    .poster-container {
        position: relative;
        display: inline-block;
    }

    .poster {
        width: 215px;
        height: auto;
        transition: opacity 0.3s ease;
    }

    .poster-container:hover .poster {
        opacity: 0.4; /* 흐릿하게 만들기 */
    }

    .btn-reserve {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background-color: #f44336;
        color: white;
        padding: 10px 20px;
        text-decoration: none;
        border-radius: 5px;
        opacity: 0;
        transition: opacity 0.3s ease;
    }

    .poster-container:hover .btn-reserve {
        opacity: 1; /* 버튼 보이기 */
    }
</style>
      <section id="single">
        <h2><a href="event.jsp">이벤트 ></a></h2>
      <div class="item">
          <ul>
            <li><img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzEyMjlfMjkz%2FMDAxNzAzODMyNzUyOTQy.BrmZuNgOA2oW_gF1DCR0oSpUHXYZvVNU_1klBfSJVrEg.EIQoOUp54hi28_jG9WlXOqoK4_Kn23T0UdN_SiuSR3Mg.JPEG.baeum00%2Fcjdf.jpg&type=a340" width="210" height="210" alt="크리스피롤12곡(180g)"></li>
            <li class="subject">용띠 30% 할인</li>
            <li class="comment"></li>
          </ul>
        </div>
      <div class="item">
          <ul>
            <li><img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMDA0MDdfMSAg%2FMDAxNTg2MjI1NDM4ODM0.9y4BAIAj4DTdmvW1v_gLCLS59Tk_gwEPN15-TWlY_P8g.h29Kyi6_C6CR1X8YTg_Hi6h9lZ6Pul0CUtcuylhEKKog.PNG.skfmtltm2%2F1.png&type=a340" width="210" height="210" alt="크리스피롤12곡(180g)"></li>
            <li class="subject">군인 할인</li>
            <li class="comment"></li>
          </ul>
      </div>
      <div class="item">
          <ul>
            <li><img src="https://search.pstatic.net/sunny/?src=https%3A%2F%2Fimg1.daumcdn.net%2Fthumb%2FR1280x0.fjpg%2F%3Ffname%3Dhttp%3A%2F%2Ft1.daumcdn.net%2Fbrunch%2Fservice%2Fuser%2FcUM5%2Fimage%2FiZg9IVQkYERRIydNNS6auxeMhAI.JPG&type=a340" width="210" height="210" alt="크리스피롤12곡(180g)"></li>
            <li class="subject">수험생 할인</li>
            <li class="comment"></li>
          </ul>
      </div>
      <div class="item">
          <ul>
            <li><img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzExMDNfMTYw%2FMDAxNjk4OTM3NDM0NjYz.56l7AHy9oD9f16qoAdSIjaM9rB00kpOvBOxFYhOQs2gg.9Gr3GFaJqsmsRjhcM6rEh6poN17yg_7ZcyD8L7ZsZeog.JPEG.kk97653%2F%25B4%25D9%25BF%25EE%25B7%25CE%25B5%25E5.jpeg%25A3%25AD26.jpg&type=a340" width="210" height="210" alt="마린크래커(25gx4개)"></li>
            <li class="subject">11월 생월자 할인</li>
            <li class="comment"></li>
          </ul>
      </div>
      <div class="item">
          <ul>
            <li><img src="https://search.pstatic.net/sunny/?src=https%3A%2F%2Fpng.pngtree.com%2Fpng-clipart%2F20231018%2Foriginal%2Fpngtree-pop-corn-food-pixelated-png-image_13355850.png&type=a340" width="210" height="210" alt="우마이봉(6gx15개)"></li>
            <li class="subject">카라멜 팝콘 할인</li>
            <li class="comment"><img src="img/portfolio/commend_02.jpg" alt="인기상품"></li>
            <li class="price">4,000원</li>
          </ul>
      </div>
      <div class="item">
          <ul>
            <li><img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNDA0MDlfMjU4%2FMDAxNzEyNjMzNTIxOTA5.1N9sXXw99i2dnRQdtKvftccKUW31mi3-3A08c0fZxO0g.iZDcic9LxEgYFA94r18L1Vo91h2Bpv_Zb0tnukTMgtQg.PNG%2Fimage.png&type=a340" width="210" height="210" alt="후룻바이더풋(10gx3개)"></li>
            <li class="subject">콜라 할인</li>
            <li class="comment"><img src="img/portfolio/commend_02.jpg" alt="인기상품"></li>
            <li class="price">1,000원</li>
          </ul>
      </div>
      <div class="item">
          <ul>
            <li><img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzA2MjVfMjQg%2FMDAxNjg3Njk0OTE2NTgy.lHpfvH0emnpndxIFS-kwZPhzp5ImuxluTR5dDmVs7LAg.wJoWBdWllgBT6JSVgQCqe0a4ny22b5uo0u8U8y9Ve3kg.JPEG.syjmaru%2FIMG_2691.jpg&type=a340" width="210" height="210" alt="미니멘토스(10gx10개)"></li>
            <li class="subject">컴포트석 할인</li>
            <li class="comment"><img src="img/portfolio/commend_02.jpg" alt="인기상품"></li>
            <li class="price">15,000원</li>
          </ul>
      </div>
      <div class="item">
          <ul>
            <li><img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNDEwMjNfMTQw%2FMDAxNzI5NjU4MjcwOTky.-m4q5lTv-0p9oKhT66CBpUdYppJ3w8zDyCJqwcXbpEIg.pbjqlfCqjruOoip_MvSyQd2tKSi88VYK_VG_sjFqk64g.PNG%2Fimage.png&type=a340" width="210" height="210" alt="카스테이블워터크래커(125g)"></li>
            <li class="subject">영화 관람시 주차 3시간 무료</li>
            <li class="comment"></li>
            <li class="price">무료</li>
          </ul>
      </div>
    </section> <!-- section single -->

    <div class="clear"></div>

 </section> <!-- section main -->

     <%-- <footer>
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
      
      
   <section id="main">
    <section id="cat1">
      <div id="cat_title"> 
        My  쇼핑
      </div>
      <ul>
        <li>과자</li>
        <li>초콜렛</li>
        <li>젤리/사탕</li>
        <li>음료</li>
        <li>세트상품</li>
        <li>미니세트</li>
        <li>개인결제</li>
      </ul>

    </section> <!-- section cat1 -->


    <section id="cat2">
      <img src="img/portfolio/main_img.jpg">
    </section> <!-- section cat2 -->

    <section id="cat3">
      <div id="customer">
         <img src="img/portfolio/customer_01.jpg" width="230" height="130" alt="고객센터/계좌정보">
      </div>
      <div id="latest_notice">
         <ul>
           <li>발렌타인데이 예약배송 안내</li>
           <li>빼빼로데이 배송공지</li>
           <li>당일배송 시스템</li>
           <li>추석 배송공지</li>
           <li>직접 보낸것처럼 신청하기</li>
           <li>배송사 및 배송비 안내</li>
         </ul>
       </div>
    </section>

    <div class="clear"></div>
--%>
 </section> <!-- section main -->

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