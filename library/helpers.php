<?php 

// default I18N echo
function e($str, $output = true){ 
	if($output) {
		echo htmlspecialchars($str);
	} else { 
		return htmlspecialchars($str); 
	}
}

// I18N echo with new line afterwards
function en($str, $output = true){ 
	if($output) {
		echo nl2br(htmlspecialchars($str), true); 
	} else { 
		return nl2br(htmlspecialchars($str), true);
	}
}

// I18N echo for date
function ed($date, $output = true){
	if($output) {
		echo ucwords(strftime(date_format, $date)); 
	} else { 
		return ucwords(strftime(date_format, $date));
	}
}

// I18N echo for currency
function c($number, $output = true, $decimalPoint = 2) { 
	$localeInformation = localeconv(); 
	if(intval($number)==$number) {
		$decimalPoint = 0; 
	}
	$number = number_format($number, $decimalPoint, $localeInformation['decimal_point'], $localeInformation['thousands_sep']); 
	if($output) {
		echo $number; 
	} else { 
		return $n; 
	}
}

// convert string to HTML ASCII codes - obfuscate emails mainly
function m($str) {
	$output = ""; 
	for ($i = 0; $i < strlen($str); $i++) { 
		$output .= '&#'.ord($str[$i]).';';
	} 
	echo $output;
} 

function between($val, $min, $max) { return ($val >= $min && $val <= $max); }