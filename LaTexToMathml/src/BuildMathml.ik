;;mathml build file


use("LaTexLists.ik")
use("MathmlLists.ik")


HtmlOutPage = htmlHead
xmlID = 1
;;body starts
HtmlOutPage = HtmlOutPage + (#[  ]*xmlID) + htmlBodyHead
;;para starts
HtmlOutPage = HtmlOutPage + (#[  ]*xmlID) + (#[<p>\n])
xmlID = xmlID + 1
HtmlOutPage = HtmlOutPage + (#[  ]*xmlID) + MathsHeader
xmlID = xmlID + 1
HtmlOutPage = HtmlOutPage + (#[  ]*xmlID) + (#[<mrow>\n])
xmlID = xmlID + 1


funcIndex = [0]

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
  ("file : " + fileName + "printed to : " + fileLocation + "\n contains :\n" + fileContent) println
)


(formula length) times(i,
  n = 0
  (formula[i] length) times(j,
;;      ("Start of loop : " + j) println
;;      ("n : " + n) println
      FIJ = (formula[i][(j + n)..(j+ n)])
      cond(
	LaTexSlh include?(FIJ), 

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
	  HtmlOutPage = HtmlOutPage + (#[  ]*xmlID) + (#[<mo>] + PM + #[</mo>\n]),
	  
	  (FSMIJ == #[sqrt]), HtmlOutPage = HtmlOutPage + (#[  ]*xmlID) + (#[<m] + FSMIJ + #[>\n])
	  funcIndex append!([FSMIJ]),
	  
	  (FSMIJ == #[frac]), HtmlOutPage = HtmlOutPage + (#[  ]*xmlID) + (#[<m] + FSMIJ + #[>\n])
	  funcIndex append!([(FSMIJ + "bottom")])
	  funcIndex append!([(FSMIJ + "top")])
	  xmlID = xmlID + 1,
	  
	  HtmlOutPage = HtmlOutPage + (#[  ]*xmlID) + (#[<m] + FSMIJ + #[>\n] )
	  funcIndex append!([FSMIJ])
	)
	xmlID = xmlID + 1

;;	FSMIJ println
;;	(formula[i][(j + n)..(k + n)]) println
	n = k - j + n
;;	("end of fun n=k-j" + n) println
	,
	
	LaTexFBS include?(FIJ),
	  FILD = funcIndex[((funcIndex length)-1)]
;;	  FILD println
;;	  ("Its a Function Bracket Start= " + FIJ) println
;;	  (" MATCH OR NO MATCH ON END BRAKET STUFF" + (FILD)) println
	  cond(
	  
	    (FILD == [#[sqrt]]), asdf = 1 ,
	  
	    (FILD == [#[fracbottom]]), 
	    
	    (HtmlOutPage = HtmlOutPage + (#[  ]*xmlID) + #[<mrow>\n]),

	    (FILD == [#[fractop]]), 
	    (HtmlOutPage = HtmlOutPage + (#[  ]*xmlID) + #[<mrow>\n])
	  )

;;	  HtmlOutPage = HtmlOutPage + (#[  ]*xmlID) + #[<mrow>\n]
	  xmlID = xmlID + 1,  	  


	LaTexFBE include?(FIJ),  
	  xmlID = xmlID - 1
	  FILD = funcIndex[((funcIndex length)-1)]
;;;	  ("Its a Function Bracket End= " + FIJ) println,
	  cond(
	  
	    (FILD == [#[sqrt]]), (HtmlOutPage = HtmlOutPage + (#[  ]*xmlID) + #[</msqrt>\n])
	    funcIndex = funcIndex butLast(1)
	    xmlID = xmlID - 1,

	    (FILD == [#[fractop]]), (HtmlOutPage = HtmlOutPage + (#[  ]*xmlID) + #[</mrow>\n])
	    funcIndex = funcIndex butLast(1)
	    xmlID = xmlID - 1,
	  
	    (FILD == [#[fracbottom]]), (HtmlOutPage = HtmlOutPage + (#[  ]*xmlID) + #[</mrow>\n] + (#[  ]*(xmlID-1)) + (#[</mfrac>\n]))
	    funcIndex = funcIndex butLast(1)
	    xmlID = xmlID - 1,

;;;	  ("func length : " + (funcIndex length)) println
	  asdf = 1
	  ),

;;;;	  HtmlOutPage = HtmlOutPage + (#[  ]*xmlID) + #[</mrow>\n]


	LaTexNum include?(FIJ),  
;;	  ("Its a Number = " + FIJ) println
	  HtmlOutPage = HtmlOutPage + (#[  ]*xmlID) + (#[<mn>]) + FIJ + (#[</mn>\n]),


	LaTexOps include?(FIJ),  
;;	  ("Its a Operator = " + FIJ) println
;;	  FILD = funcIndex[((funcIndex length)-1)]
;;	  cond(
;;	  (FIJ == #[^]) println
;;	  (FIJ == #[^]), HtmlOutPage = (HtmlOutPage + (#[  ]*xmlID) + #[<msup><mn>] + (formula[i][(j + n + 1 )..(j + n + 1)]) + #[</mn></msup>\n])
;;	  n++
;;	  ,

	  HtmlOutPage = HtmlOutPage + (#[  ]*xmlID) + (#[<mo>]) + FIJ + (#[</mo>\n])
;;	  )
,

	LaTexAlp include?(FIJ), 
;;	  ("it is a Text!= " + formula[i][(j + n)..(j + n)]) println,
	  HtmlOutPage = HtmlOutPage + (#[  ]*xmlID) + (#[<mi>]) + FIJ + (#[</mi>\n]),


	LaTexSpc include?(FIJ),
	  
;;	  ("it is a Space!= " + FIJ) println,
	
	("we don't know it!= " + FIJ) println

      )
  )
)

HtmlOutPage = HtmlOutPage + (#[  ]*xmlID) + (#[</mrow>\n])
xmlID = xmlID - 1
HtmlOutPage = HtmlOutPage + (#[  ]*xmlID) + (#[</math>\n])
xmlID = xmlID - 1
HtmlOutPage = HtmlOutPage + (#[  ]*xmlID) + (#[</p>\n])
xmlID = xmlID - 1
HtmlOutPage = HtmlOutPage + (#[  ]*xmlID) + (#[</body>\n])
xmlID = xmlID - 1
HtmlOutPage = HtmlOutPage + (#[  ]*xmlID) + (#[</html>\n])

;;WriteFile("index.html", fileLocation: baseDir, HtmlOutPage)

