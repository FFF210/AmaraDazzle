<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>페이징</title>
        <link rel="stylesheet" href="./css/common/componant.css?v=3" />
        <link rel="stylesheet" href="./css/componant/pagenation.css?v=1" />
        
        <!-- Bootstrap Icons CDN -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" />

        <!-- JQuery -->
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    </head>
    <body>
         <!-- 페이지네이션 -->
        <div class="pagination_wrap" id="paginationWrap">
            <!-- Prev button -->
            <button class="pg_nav" id="btnPrev"><i class="bi bi-chevron-left"></i>&nbsp;Prev&nbsp;</button>

            <!-- Pages container -->
            <div class="pages" id="pages">
                <button type="button" class="page_item active">1</button>
                <button type="button" class="page_item">2</button>
                <button type="button" class="page_item">12</button>
                <button type="button" class="page_item">13</button>
                <button type="button" class="page_item">111</button>
                <button type="button" class="page_item">158</button>
                <button type="button" class="page_item">1589</button>
            </div>

            <!-- Next button -->
            <button class="pg_nav" id="btnNext">&nbsp;Next&nbsp;<i class="bi bi-chevron-right"></i></button>
        </div>

        <!-- 페이지네이션 end -->
        <script src="./js/componant/pagenation.js"></script>
    </body>
</html>

