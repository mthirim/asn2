//global variables
//var grades = [65.95, 56.98, 78.62, 96.1, 90.3, 72.24, 92.34, 60.00, 81.43, 86.22, 88.33, 9.03, 49.93, 52.34, 53.11, 50.10, 88.88, 55.32, 55.69, 61.68, 70.44, 70.54, 90.0, 71.11, 80.01];
var gradeIndex = ["Max","A+", "A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D", "F"];
var gradeValue = [100.00, 95.00, 90.00, 85.00, 80.00, 75.00, 70.00, 65.00, 60.00, 55.00, 50.00, 0.00];
var histogramResult = [0,0,0,0,0,0,0,0,0,0,0];

<% @rubyGrades = []
//var grades=  JSON.parse<%= rubyGrades.to_json %>;
var grades = <%= JSON.parse(escape_javascript @rubyGrades.to_json) %>

//create a new histogram
function buildHistogram() {
	//outerloop = 11 different grades
	for(var i = 0; i < histogramResult.length; i++) {
		var row = document.getElementById("r"+gradeIndex[i+1]);
		//innerloop = #of students in each grade
		for (var j = 1; j <= histogramResult[i]; j++) {
			row.insertCell();	//add histogram data to a specific row
		}
	}
}
//determine if the input is within a valid range when the user finish entering the input
function calculateStanding(id) {
	checkMaxF(id);	//invoke the function to pre-set "Max" and "F"
	var num = document.getElementById(id).value;	//get a specific input from html
	//if valid input is entered, create a histogram
	if (isBetween(num,id,gradeIndex)) {
		inputValidHelper(id, true);	//invoke function to change the input field and colour and error message
		document.getElementById(id).value = num;	//set the input field to valid user input
		gradeValue[gradeIndex.indexOf(id)] = (parseFloat(num)); //change the preset grade range with user's preference
		if (isInputValid()){
			deleteHistogram();	//invoke function to  delete existing histogram
			histogramReset();	//invoke function to reset existing histogram data
			histogram();	//invoke function to create a new histogram
		}
	}
	else {
		inputValidHelper(id, false); //inovke function to change the input field and colour and error message
	}
}
//check the user input when the key is pressed or released
function createGradeEntry(id) {
	checkMaxF(id);	//invoke function to prevent user from changing the contents
	var num = document.getElementById(id).value;	//get a specific value from html
	errorInput(num,id);	//invoke function for input validity
	calculateStanding();	//invoke function to check range validity of the input.
}
//change colour of the input text and box when the user enters the invalid input.
function changeColor(unique, colour, bColour) {
	document.getElementById(unique).style.color = colour;	//change input text colour
	document.getElementById(unique).style.backgroundColor = bColour; //change input background colour
}
//prevent user from changing the lower bound grade for "F" and "Max"
function checkMaxF(id) {
	if (id === "Max") {	//if the input is for Max
		document.getElementById(id).value = "100.00";	//set the value to 100
	}
	if (id === "F") {	//if the input is for F
		document.getElementById(id).value = "0.00";	//set the value to 0
	}
}
//delete an exisiting histogram
function deleteHistogram() {
	//outerloop = 11 different grades
	for(var i = 0; i < histogramResult.length; i++) {
		var row = document.getElementById("r"+gradeIndex[i+1]);
		//innerloop = #of students in each grade
		for (var j = 1; j <= histogramResult[i]; j++) {
			row.deleteCell(-1);
		}
	}
}
//clear the input area and delete the existing histogram when the user enters input other than nonnegative and valid grade range.
function emptyInput(unique) {
	document.getElementById(unique).value = "";	//empty value
	document.getElementById("main").innerHTML = "Invalid Input!!!";	//error message displayed on html page
	document.getElementById("entry").innerHTML = "Enter a value between 0 and 100 with no duplicate and within a valid range."; //error message displayed on html page
	document.getElementById("hist").innerHTML = "No histogram will be created until all of the input fields are white.";	//display error
	deleteHistogram();	//invoke function to delete an existing histogram
	histogramReset();	//invoke function to reset the histogram data
}
//change the colour of the input area when the user enters invalid input
function errorInput(number, errorID) {
	if (number == parseFloat(number) || number == ".") {	//if the input is a nonnegative integer, change the input color back to origin
		inputValidHelper(errorID, true);	//invoke function to change the input field, colour and error message

	}
	else{
		inputValidHelper(errorID, false);	//invoke function to change the input field, colour and error message
	}
}
//retrieve a specific html input
function getValue(array, inputNum) {
	return document.getElementById(array[inputNum]).value;
}
//invoke by onload event to create a histogram
function histogram() {
	tabulateHistogram();	//invoke function to calculate the histogram data
	buildHistogram();	//invoke function to create a histogram
}
//reset the histogram data
function histogramReset() {
	for (var i = 0; i < histogramResult.length; i++) {
		histogramResult[i] = 0;	//set the histogram data to 0
	}
}
//help with calling several functions at once to change the input field and colour and error message
function inputValidHelper(id, valid) {
	if (valid) {
		changeColor((id+"e"), "black", "none");	//invoke function to change the input colour back to origin
		changeColor(id, "black", "white");	//invoke function to change the input colour back to origin
		changeColor((id+"r"), "black", "none");	//invoke function to change the input colour back to origin
		document.getElementById("main").innerHTML = "";		//change the html, so no error message is displayed
		document.getElementById("entry").innerHTML = "";
		document.getElementById("hist").innerHTML = "";
	}
	else {
		emptyInput(id);	//invoke function to empty the inputfield upon invalid input entry by the user
		changeColor(id, "purple", "red");	//invoke function to change the text and input field colour upon user's incorrect input
		changeColor((id+"e"), "red", "none");	//invoke function to change the text colour when the invalid input is entered
		changeColor((id+"r"), "red", "none");	//invoke function to change the text colour
	}
}
//check whether user input is within a valid grade range
function isBetween(number,unique,gradeIndex) {
	var result = false;	//return if current grade is in valid range
	var num = parseFloat(number);	//parse the input 
	var smallerI = (gradeIndex.indexOf(unique))+1;	//compute the index of below grade
	var smaller = getValue(gradeIndex,smallerI);	//invoke the function to find the value of the below grade
	var largerI = (gradeIndex.indexOf(unique))-1; 	//compute the index of above grade
	var larger = getValue(gradeIndex,largerI);	//invoke the function to find the value of the above grade
	//calculate the nearest below grade range
	for (var i = gradeIndex.indexOf(unique); i < gradeIndex.length; i++) {
		var len = smaller.length;
		if (len == 0) {
			smallerI++;
			smaller = getValue(gradeIndex,smallerI);
		}
	}
	//calculate the nearest above grade range
	for (var i = gradeIndex.indexOf(unique); i > 0; i--) {
		var len = larger.length;
		if (len == 0) {
			largerI--;
			larger = getValue(gradeIndex,largerI);
		}
	}
	//determine whether the input is in valid grade range
	if ((num) > parseFloat(smaller) && num < parseFloat(larger)) {
			result = true;	//the input is in valid range
		}
	return result;	//return
}
//check whether the input is empty which is caused by entering invalid input
function isInputValid() {
	for (var i = 0; i < histogramResult.length; i++) {
		if (getValue(gradeIndex,i+1) === "") {
			return false;	//return false if input field is empty
		}
	}
	return true;	//return true if the input is a valid one
}
//calculate the number of students in each grade range
function tabulateHistogram() {	
	for (var i = 0; i < grades.length; i++) {	//e.g i=0 to 24 - students' grades
		var j;
		for (j = 0; j < gradeValue.length; j++) {	//find the correct grade range
			if (grades[i] < gradeValue[j] && grades[i] >= gradeValue[j+1]) {
				histogramResult[j]++;	//increse the histogram count
				//alert(grades[i] + ": " + j);
				break;	//skip to next student's grade
			}
		}
	}
}
