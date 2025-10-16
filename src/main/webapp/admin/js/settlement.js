function insertSettleList(){
	fetch("/admin/settleManual", {
		method: "GET"
	})
	.then(res => res.json())
	.then(data => {
		console.log(data);
		if (data.status == "ok") {
			location.reload();

		} else if (data.status == "fail") {
			showAlert("error", data.title, data.message); 
		}
	})
	.catch(err => console.log(err));
}