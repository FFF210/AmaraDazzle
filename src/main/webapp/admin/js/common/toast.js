//알럿띄우기 
console.log("showAlert 호출!!!!");
function showAlert(type, title, message) {
	console.log("showAlert 호출");
	const icons = {
		error: '<i class="bi bi-x-circle-fill"></i>',
		warning: '<i class="bi bi-exclamation-triangle-fill"></i>',
		success: '<i class="bi bi-check-circle-fill"></i>',
		info: '<i class="bi bi-info-circle-fill"></i>'
	};
	const toast = document.getElementById("toast");
	toast.innerHTML = `
	    <div class="alert alert--${type}">
	      <div class="alert-icon">${icons[type] || ""}</div>
	      <div class="alert-content">
	        ${title ? `<div class="alert-title">${title}</div>` : ""}
	        <div class="alert-message">${message}</div>
	      </div>
	    </div> `;

		toast.classList.add("show"); 

	setTimeout(() => {
		toast.classList.remove("show");
	}, 3000);
}

