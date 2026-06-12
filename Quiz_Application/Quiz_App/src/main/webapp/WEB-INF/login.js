function validateLoginForm() {
    const username = document.getElementById("username").value.trim();
    const password = document.getElementById("password").value.trim();
    const timer = document.getElementById("timer");
	
    if (username === "" || password === "") {
        alert("Please enter username and password");
        return false;
    }
    return true;
}

function confirmSubmitQuiz() {
    return confirm("Are you sure you want to submit the quiz?");
}