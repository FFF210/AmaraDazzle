<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="title" required="true"%>
<%@ attribute name="formId" required="true"%>
<%@ attribute name="action" required="false"%>
<%@ attribute name="method" required="false"%>
<%@ attribute name="enctype" required="false"%>

<div class="wrap">
	<section class="card">
		<div class="head">${title}</div>
		<div class="body">
			<main>
				<form id="${formId}" action="${action }"
					method="${method != null ? method : 'post'}"
					enctype="${empty enctype ? 'application/x-www-form-urlencoded' : enctype}"
					novalidate>
					<jsp:doBody />
				</form>
			</main>
		</div>
	</section>
</div>
