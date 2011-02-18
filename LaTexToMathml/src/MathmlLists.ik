#!/usr/bin/env ioke
;;Mathml Lists

;; setting constants

MathmlLists = Origin mimic do(
	
  Ground PM = PlusMinusSign = "&#xB1"
  Ground InvisibleTimes = "&#x2062"


  Ground htmlFullHead = #[
<html>
  <head>
    <meta charset="utf-8" /> 
    <meta name="language" content="en-US" /> 
    <meta name="description" content="Example of MathML embedded in an HTML5 file" /> 
    <meta name="keywords" content="Example of MathML embedded in an HTML5 file" /> 
    <title>My ioke latex to MathML embedded in an HTML5 file example</title> 
  </head>
  <body>
    <h1>Example of MathML embedded in an HTML5 file</h1>
    <p>
      <math xmlns="http://www.w3.org/1998/Math/MathML">
	<mrow>
]


  Ground htmlFullFoot = #[        </mrow>
      </math>
    </p>
  </body>
</html>
]

)
