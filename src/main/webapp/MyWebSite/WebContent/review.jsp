<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>영화 후기 작성</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <link rel="stylesheet" type="text/css" href="css/common.css">
    <script src="https://kit.fontawesome.com/8414862e5c.js" crossorigin="anonymous"></script>
    <style>
        body {
            font-family: "맑은 고딕", "돋움";
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            max-width: 600px;
            margin: 50px auto;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #333;
        }

        label {
            font-size: 1.2em;
            margin-bottom: 10px;
            display: block;
        }

        input, textarea, select {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1em;
        }

        .btn {
            display: inline-block;
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            font-size: 1.2em;
            text-align: center;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .alert {
            text-align: center;
            color: red;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>영화 후기 작성</h1>
        
        <% 
        String errorMsg = (String) request.getAttribute("errorMsg");
        if (errorMsg != null) { 
        %>
        <div class="alert"><%= errorMsg %></div>
        <% } %>

        <form action="saveReview.do" method="post">
            <!-- 영화 제목 입력 -->
            <label for="movieTitle">영화 제목</label>
            <input type="text" id="movieTitle" name="movieTitle" placeholder="영화 제목을 입력하세요" required>

            <!-- 평점 선택 -->
            <label for="rating">평점</label>
            <select id="rating" name="rating" required>
                <option value="">평점을 선택하세요</option>
                <option value="5">★★★★★</option>
                <option value="4">★★★★☆</option>
                <option value="3">★★★☆☆</option>
                <option value="2">★★☆☆☆</option>
                <option value="1">★☆☆☆☆</option>
            </select>

            <!-- 후기 내용 입력 -->
            <label for="review">후기</label>
            <textarea id="review" name="review" rows="5" placeholder="후기를 입력하세요" required></textarea>

            <!-- 제출 버튼 -->
            <button type="submit" class="btn">후기 제출</button>
        </form>
    </div>
</body>
</html>
