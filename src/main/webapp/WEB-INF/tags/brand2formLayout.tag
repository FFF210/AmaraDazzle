<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="title" required="true" %>
<%@ attribute name="formId" required="true" %>

<div class="wrap">
  <section class="card">
    <div class="head">${title}</div>
    <div class="body">
      <main>
        <form id="${formId}" novalidate>
          <jsp:doBody />
        </form>
      </main>
    </div>
  </section>
</div>
