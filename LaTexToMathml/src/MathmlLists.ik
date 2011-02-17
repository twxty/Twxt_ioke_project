;;Mathml Lists

;; setting constants

MathmlLists = Origin mimic do(

  Ground htmlHeader = #[xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en"]
  Ground MathsHeader = #[<math xmlns="http://www.w3.org/1998/Math/MathML">
]
  Ground PM = PlusMinusSign = "&#xB1"
  Ground InvisibleTimes = "&#x2062"
  ;;"MathsmlLists loaded" println

  Ground htmlHead = #[
<head>
  <meta charset="utf-8" /> 
  <meta name="language" content="en-US" /> 
  <meta name="description" content="Example of MathML embedded in an HTML5 file" /> 
  <meta name="keywords" content="Example of MathML embedded in an HTML5 file" /> 
  <title>My ioke latex to MathML embedded in an HTML5 file example</title> 
</head>
<body>
]

  Ground htmlBodyHead = #[<h1>Example of MathML embedded in an HTML5 file</h1>
]
  Ground cat = #[sdf]
  Ground dog = #[qwe]
)