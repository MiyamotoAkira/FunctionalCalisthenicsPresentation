#lang slideshow

(require slideshow/code)

(slide
 (bitmap "codurance.png"))

(slide
 (t "ta"))

(slide
 (t "taka"))

(slide
 (t "tataka"))

(slide
 (t "Clojure production code"))

(slide
 (t "Calisthenics"))

(slide
 #:title "Name Everything"
 (t "Everything should have a name")
 'next
 (t "(Including lambdas/anonymous functions)")
 'next
 'alts
 (list
  (list
   (para #:align 'left
         (tt "let GetNeighbours (cell:Cell) : List<Cell> =")
         (tt "    List.fold (fun acc elem ->")
         (tt "        { xPosition = cell.xPosition + fst elem;")
         (tt "          yPosition = cell.yPosition +  snd elem}")
         (tt "       :: acc)")
         (tt "    [] neighbours")
         (tt "    |> List.rev")))
  (list
   (t "new code"))))

(slide
 #:title "No Mutable State"
 (t "We are doing functional programming")
 'next
 'alts
 (list
  (list
   (para #:align 'left
         (tt "let CheckIfAlive cell universe =")
         (tt "    let mutable alive  = GetNeighbours cell")
         (tt "    alive <- FindOnUniverse universe alive")
         (tt "    (List.length alive) = 2")
         (tt "    || (List.length alive = 3)")))
  (list
   (t "new code"))))

(slide
 #:title "Exhaustive Conditionals"
 (t "All your ifs, matches, cases should be able")
 (t "to deal with all possible input")
 'next
 'alts
 (list
  (list
   (para #:align 'left
         (t "Original code")))
  (list
   (t "new code"))))

(slide
 #:title "Do not use intermediate variables"
 (t "Everything should have a name")
 'next
 (t "(Including lambdas/anonymous functions)")
 'next
 'alts
 (list
  (list
   (para #:align 'left 
         (tt "let ``Empty cell becomes alive`` () =")
         (tt "    let u3 = [")
         (tt "        { xPosition = -1; yPosition = -1};")
         (tt "        { xPosition = 1; yPosition = 1};")
         (tt "        { xPosition = -1; yPosition = 1}]")
         (tt "    let u = [{ xPosition = 0; yPosition = 0}]")
         (tt "    let au = NextUniverse u3")
         (tt "    Assert.True (CompareList u au)")))
  (list
   (t "new code"))))

(slide
 #:title "Expressions, not Statements"
 (t "No assignment at any point.")
 'next
 'alts
 (list
  (list
   (para #:align 'left
         (t "Original code")))
  (list
   (t "new code"))))

(slide
 #:title "No Explicit Recursion"
 (t "Map and Reduce should be used instead")
 'alts
 (list
  (list
   (para #:align 'left
         (tt "let GetNeighbours (cell:Cell) : List<Cell> =")
         (tt "    let rec FindNeighbours cU nU =")
         (tt "        match cU with")
         (tt "        | [] -> nU")
         (tt "        | H::T ->")
         (tt "                FindNeighbours T ({ xPosition = cell.xPosition + fst H;")
         (tt "                                    yPosition = cell.yPosition +  snd H}")
         (tt "                                  :: nU)")
         (tt "    FindNeighbours neighbours []")
         (tt "    |> List.rev")))
  (list
   (t "new code"))))

(slide
 #:title "Generic Building Blocks"
 (t "Try to create functions that are not domain aware")
 'alts
 (list
  (list
   (para #:align 'left
         (t "Original code")))
  (list
   (t "new code"))))

(slide
 #:title "Side effects at the boundaries"
 (t "Keep your functions pure")
 'alts
 (list
  (list
   (t "Original code"))
  (list
   (t "new code"))))

(slide
 #:title "Infinite Sequences"
 (t "Don't use fixed sized collections")
 (t "Don't depend on the lenght of the collection")
 'alts
 (list
  (list
   (para #:align 'left
         (t "Original code")))
  (list
   (t "new code"))))

(slide
 #:title "One argument functions"
 (t "Functions should have a single argument")
 'alts
 (list
  (list
   (para #:align 'left
         (t "Original code")))
  (list
   (t "new code"))))

(slide
 #:title "The end")
