#!/usr/bin/env ioke

;;mathml build file


use("LaTexLists.ik")
use("MathmlLists.ik")

HtmlOutPage = htmlFullHead
xmlID = 5
tab = "  "
funcIndex = [0]

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
	  HtmlOutPage = HtmlOutPage + (tab*xmlID) + (#[<mi>]) + FIJ + (#[</mi>\n]),


	LaTexSpc include?(FIJ),
	  
;;	  ("it is a Space!= " + FIJ) println,
	
	("we don't know it!= " + FIJ) println

      )
  )
)


HtmlOutPage = HtmlOutPage + htmlFullFoot

WriteFile("index.html", fileLocation: webDir, HtmlOutPage)

