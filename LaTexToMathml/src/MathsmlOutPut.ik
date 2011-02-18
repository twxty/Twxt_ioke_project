MathsmlOutPut = Origin mimic with(

  SortMathmlString: method( MathmlString, SortStringStart, SortStringEnd,
    let( i, 0,
      while(i < (MathmlString length),
	if(SortStringStart include?( MathmlString[i] ),
	  let( j, i,
	    while( j < (MathmlString length),
	      if(SortStringEnd include?( MathmlString[j] ),
		MathmlString removeAt!(( i + 1 )..( j - 1 ))
		break
	      );;if
	    if( j>i, MathmlString[i] = MathmlString[i] + MathmlString[j])
	    j++	    
	    );; while
	  );; let j
	);; if
	i++
      );; while i
    );; let i
    ;;MathmlString println
  ),;; SortMathmlString

  TypeMathmlString: method( MathmlString, TypeString, AppendString,
   let(TempAppendString, AppendString,
    ListLength = 1
    cond( 
      (TempAppendString kind) == "List", 
      ListLength = (TempAppendString length),
      
      (TempAppendString kind) == "Text",
      TempAppendString = [TempAppendString]
      ListLength = (TempAppendString length),
      
      ListLength = 1
    )

;;   TempAppendString println
   ListLength println

   ListLength times(ListCounter,
      let(tempMathmlString, [],
	(MathmlString)
	let( i, 0,
	  ("start string" + MathmlString) println
	  while(i < (MathmlString length),
	    if(TypeString include?( MathmlString[i] ),
		MathmlString[i] = [MathmlString[i]] + [TempAppendString[(ListCounter - 1)]]	  
	    );; if
	    i++
	  );; while i
	);; let i
;;	tempMathmlString println
	MathmlString println
;;      );; let tempString
    );; times ListCounter
  );;let
  );; TypeMathmlString  
  
;;  SplitStringText: method( StringText,
;;    let(tmpString, StringText,
;;      StringText = []
;;      (tmpString length) times(i,
;;	StringText[i] = tmpString[i..i]
;;      )
;;    )
;;  )

);; MathsmlOutPut