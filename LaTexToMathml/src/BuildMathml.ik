#!/usr/bin/env ioke

;;mathml build file


use("LaTexLists.ik")
use("MathmlLists.ik")
use("MathsmlOutPut.ik")

HtmlOutPage = htmlFullHead
xmlID = 5
tab = "  "
funcIndex = [0]
;;htmlBuildPage = nil
;;htmlBuildPage append!( [[#[index]], [#[value]], [#[start]], [#[end]], [#[operatorStart]], [#[operatorEnd]]] )
htmlBuildPage = []
;;htmlBuildPage << { index: #[index], value: #[value], start: #[start] , end: #[end], operatorStart: #[operatorStart], operatorEnd: #[operatorEnd] }
;;htmlBuildPage << { index: 1, value: #[ ], start: 1 , end: 2, operatorStart: #[ ], operatorEnd: #[ ] }


htmlBuildPage append!( [[#[index]], [#[value]], [#[start]], [#[end]], [#[operatorStart]], [#[operatorEnd]]])
htmlBuildPage append!( [[2], [#[]], [1], [1], [#[]], [#[]]])


;;htmlBuildPage println
;;htmlBuildPage[1][1] println

webDir = #[/home/twxt/Documents/WebSites/tests/]
baseDir = "#{System currentWorkingDirectory}/"
fLoc = #[vars]

formula = FileSystem readLines(baseDir + fLoc)
;;formula println
;;(#[Grabing from ] + baseDir + fLoc) println


WriteFile = method(fileName, fileLocation: baseDir, fileContent,
  if(FileSystem exists?(fileLocation + fileName),
    FileSystem removeFile!(fileLocation + fileName)
  )
  FileSystem withOpenFile(fileLocation + fileName, fn(out, out println(fileContent)))
;;  ("file : " + fileName + "printed to : " + fileLocation + "\n contains :\n" + fileContent) println
)

LCharFol = (FileSystem readFully(baseDir + fLoc)) chars


;;(LCharFol length) times(s, LCharFol[s] println)
;;LCharFol println
;;LCharFol = ((FileSystem readFully(baseDir + fLoc)) split("")) trim
;;LCharFol = (FileSystem readFully(baseDir + fLoc)) 
;;MathsmlOutPut SplitString( LCharFol )
;;LCharFol println
;;LCharFol[0..-1] println
;;(LaTexSlhScanForwardEnd include?(LCharFol[17..17])) println
;;MathsmlOutPut SortMathmlString( LCharFol, LaTexSpc, LaTexSpc )
;;LCharFol println

iuytr = []
iuytr = [#[<ni>],#[</ni>]]
MathsmlOutPut SortMathmlString( LCharFol, LaTexSlhScanForwardStart, LaTexSlhScanForwardEnd )
;;MathsmlOutPut TypeMathmlString( LCharFol, LaTexAlp, [#[<ni>],#[</ni>]]);;[#[<ni>]])
LCharFol println 

   2 times(p,
      p println
      iuytr[p] println
      let(tempMathmlString, LCharFol, 
	let( i, 0,
;;	  ("start string" + LCharFol) println
	  while(i < (LCharFol length),
	    if(LaTexAlp include?( LCharFol[i] ),
		tempMathmlString[i] = [tempMathmlString[i]] + [iuytr[(p)]]
			  
	    );; if
	    i++
	  );; while i
	("\n LCharFol " + p + " in line\n\n" + LCharFol) println
	);; let i
;;	tempMathmlString println
	
      );; let tempString
    );; times ListCounter
  );;let
  );; TypeMathmlString



;;htmlBuildPage append!( [[((htmlBuildPage length) + 1)], [#[]], [], [], [#[]], [#[]]])
;;htmlBuildPage append!( [[((htmlBuildPage length) + 1)], [#[]], [], [], [], []])
;;htmlBuildPage append!( [[((htmlBuildPage length) + 1)], [#[base]], [1], [2], [htmlFullHead], [htmlFullFoot]])

;;htmlBuildPage
;;htmlBuildPage println



;;htmlBuildPage println
;;testA[20] println

(formula length) times(i,
  n = 0
  (formula[i] length) times(j,

;;      (xmlID) println
;;      ("Start of loop : " + j) println
;;      ("n : " + n) println
      FIJ = (formula[i][(j + n)..(j+ n)])
      cond(
	LaTexSlh include?(FIJ), HtmlOutPage

;;	  ("Its a Function = " + FIJ) println
	  k=j
	  tempLaTexFun = LaTexFun include?(formula[i][(j + n)..(k + n)])
	  while(tempLaTexFun != true,
	    k++
	    cond(
	      k > formula[i] length, 
		tempLaTexFun = true		
	      ,
	      tempLaTexFun = LaTexFun include?(formula[i][(j + n)..(k + n)])
	    
	    )
	    
	  )
	FSMIJ = (formula[i][(j + n + 1)..(k + n)])
	cond( 
	  (FSMIJ == #[pm]), 
;;	  ("add to xml build : " + (formula[i][(j + n)..(k + n)])) println
	  HtmlOutPage = HtmlOutPage + (tab*xmlID) + (#[<mo>] + PM + #[</mo>\n]),
	  
	  (FSMIJ == #[sqrt]), HtmlOutPage = HtmlOutPage + (tab*xmlID) + (#[<m] + FSMIJ + #[>\n])
	  funcIndex append!([FSMIJ])
	  xmlID++,
	  
	  (FSMIJ == #[frac]), HtmlOutPage = HtmlOutPage + (tab*xmlID) + (#[<m] + FSMIJ + #[>\n])
	  funcIndex append!([(FSMIJ + "bottom")])
	  funcIndex append!([(FSMIJ + "top")])
	  xmlID++,
	  
	  HtmlOutPage = HtmlOutPage + (tab*xmlID) + (#[<m] + FSMIJ + #[>\n] )
	  funcIndex append!([FSMIJ])
	  
	)
	

;;	FSMIJ println
;;	(formula[i][(j + n)..(k + n)]) println
	n = k - j + n
;;	("end of fun n=k-j" + n) println
	,
	
	LaTexFBS include?(FIJ),
	  FILD = funcIndex[((funcIndex length)-1)]
;;	  FILD println
;;	  ("Its a Function Bracket Start= " + FILD) println
;;	  (" MATCH OR NO MATCH ON END BRAKET STUFF" + (FILD)) println
	  cond(
	  
	    (FILD == [#[sqrt]]), xmlID--
;;	     "its a SQRT TRUE" println ,
	  
	    (FILD == [#[fracbottom]]), 
	    (HtmlOutPage = HtmlOutPage + (tab*xmlID) + #[<mrow>\n]),

	    (FILD == [#[fractop]]), 
	    (HtmlOutPage = HtmlOutPage + (tab*xmlID) + #[<mrow>\n])
	  )

;;	  HtmlOutPage = HtmlOutPage + (tab*xmlID) + #[<mrow>\n]
	  xmlID++,  	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  


	LaTexFBE include?(FIJ),  
;;	  xmlID--
	  FILD = funcIndex[((funcIndex length)-1)]
;;	  ("Its a Function Bracket End= " + FIJ) println
	  cond(
	  
	    (FILD == [#[sqrt]]), xmlID--
	    (HtmlOutPage = HtmlOutPage + (tab*xmlID) + #[</msqrt>\n])
	    funcIndex = funcIndex butLast(1),

	    (FILD == [#[fractop]]), xmlID--
	    (HtmlOutPage = HtmlOutPage + (tab*xmlID) + #[</mrow>\n])
	    funcIndex = funcIndex butLast(1),
	  
	    (FILD == [#[fracbottom]]), xmlID--
	    (HtmlOutPage = HtmlOutPage + (tab*xmlID) + #[</mrow>\n] + (tab*(xmlID-1)) + (#[</mfrac>\n]))
	    funcIndex = funcIndex butLast(1),

;;;	  ("func length : " + (funcIndex length)) println
	  asdf = 1
	  ),

;;;;	  HtmlOutPage = HtmlOutPage + (tab*xmlID) + #[</mrow>\n]


	LaTexNum include?(FIJ),  
;;	  ("Its a Number = " + FIJ) println
	  HtmlOutPage = HtmlOutPage + (tab*xmlID) + (#[<mn>]) + FIJ + (#[</mn>\n]),


	LaTexOps include?(FIJ),  
;;	  ("Its a Operator = " + FIJ) println
;;	  FILD = funcIndex[((funcIndex length)-1)]
;;	  cond(
;;	  (FIJ == #[^]) println
;;	  (FIJ == #[^]), HtmlOutPage = (HtmlOutPage + (tab*xmlID) + #[<msup><mn>] + (formula[i][(j + n + 1 )..(j + n + 1)]) + #[</mn></msup>\n])
;;	  n++
;;	  ,

	  HtmlOutPage = HtmlOutPage + (tab*xmlID) + (#[<mo>]) + FIJ + (#[</mo>\n])
;;	  )
,

	LaTexAlp include?(FIJ), 
;;	  ("Its a Text!= " + formula[i][(j + n)..(j + n)]) println
;;	  htmlBuildPage append!( [[((htmlBuildPage length) + 1)], [FIJ], [(htmlBuildPage length)], [], [#[<mi>]], [#[</mi>]]])
	  HtmlOutPage = HtmlOutPage + (tab*xmlID) + (#[<mi>]) + FIJ + (#[</mi>\n])
	  ,


	LaTexSpc include?(FIJ),
	  
;;	  ("it is a Space!= " + FIJ) println,
	
	("we don't know it!= " + FIJ) println

      )
  )
)


HtmlOutPage = HtmlOutPage + htmlFullFoot

WriteFile("index.html", fileLocation: webDir, HtmlOutPage)

