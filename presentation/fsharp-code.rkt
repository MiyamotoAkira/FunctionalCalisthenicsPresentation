#lang slideshow

(require "base.rkt")

(provide declarations-fsharp)
(provide bad-naming-fsharp)
(provide good-naming-fsharp)
(provide statement-fsharp)
(provide expression-fsharp)
(provide mutable-state-fsharp)
(provide non-mutable-state-fsharp)
(provide non-exhaustive-1-fsharp)
(provide exhaustive-1-fsharp)
(provide non-exhaustive-2-fsharp)
(provide exhaustive-2-fsharp)
(provide intermediate-variables-fsharp)
(provide non-intermediate-variables-fsharp)
(provide non-intermediate-variables-alternate-fsharp)
(provide recursion-fsharp)
(provide non-recursion-fsharp)
(provide non-recursion-alternate-fsharp)
(provide non-generic-building-block-fsharp)
(provide generic-building-block-fsharp)
(provide generic-building-block-alternate-fsharp)
(provide side-effect-fsharp)
(provide side-effect-injection-fsharp)
(provide side-effect-out-fsharp)
(provide side-effect-out-alternate-fsharp)
(provide non-sequence-fsharp)
(provide sequence-fsharp)
(provide multiple-arguments-fsharp)
(provide single-argument-fsharp)
(provide multiple-arguments-2-fsharp)
(provide composition-fsharp)

(define (letk) (keyword "let "))

(define (equal) (keyword "= "))

(define (tab) (tt "    "))

(define (declarations-fsharp)
  (vc-append 0 (hbl-append 0 (keyword "type ") (function "Cell ") (equal) (keyword "{") (tt "x") (keyword ": int; ") (tt "y") (keyword ": int}") )
        (tt "")
        (hbl-append 0
                    (keyword "let ")
                    (function "neighbours ")
                    (keyword "= [")
                    (tt "(-1,-1)")
                    (keyword "; ")
                    (tt "(0,-1)")
                    (keyword "; ")
                    (tt "(1,-1)")
                    (keyword "; ")
                    (tt "(-1,0)")
                    (keyword "; "))
        (hbl-append 0
                    (tt "                  ")
                    (tt "(1,0)")
                    (keyword "; ")
                    (tt "(-1,1)")
                    (keyword "; ")
                    (tt "(0,1)")
                    (keyword "; ")
                    (tt "(1,1)")
                    (keyword ";]"))))

(define (bad-naming-fsharp)
  (vl-append 0
               (hbl-append 0 (letk) (function "GetNeighbours") (parameter " (cell:Cell) : List<Cell> ") (keyword "="))
               (hbl-append 0 (tab) (letk) (keyword "rec ") (function "FindNeighbours ") (parameter "neighbours universe ") (equal))
               (hbl-append 0 (tab) (tab) (keyword "match ") (tt "neighbours ") (keyword "with"))
               (hbl-append 0 (tab) (tab) (keyword "| ") (keyword "[] -> ") (tt "universe"))
               (hbl-append 0 (tab) (tab) (keyword "| ") (tt "H") (keyword "::") (tt "T ") (keyword "->"))
               (hbl-append 0 (tab) (tab) (tab) (tt "FindNeighbours T ("))
               (hbl-append 0 (tab) (tab) (tab) (tab) (keyword "{") (tt "x ") (equal) (tt "cell.x ") (keyword "+ ") (tt "fst H") (keyword ";"))
               (hbl-append 0 (tab) (tab) (tab) (tab) (tt " y ") (equal) (tt "cell.y ") (keyword "+ ") (tt "snd H") (keyword "}"))
               (hbl-append 0 (tab) (tab) (tab) (tab) (keyword ":: ") (tt "universe)"))
               (hbl-append 0 (tab) (tt "FindNeighbours neighbours ") (keyword "[]"))
               (hbl-append 0 (tab) (keyword "|> ") (tt "List.rev"))))

(define (good-naming-fsharp)
  (vl-append 0
               (hbl-append 0 (keyword "let ") (function "AddNeighbour ") (parameter "cell universe mods ") (equal))
               (hbl-append 0 (tab) (keyword "{") (tt "x ") (equal) (tt "cell.x ") (keyword "+ ") (tt "fst mods") (keyword ";"))
               (hbl-append 0 (tab) (tt " y ") (equal) (tt "cell.y ") (keyword "+ ") (tt "snd mods") (keyword "}"))
               (hbl-append 0 (tab) (keyword ":: ") (tt "universe"))
               (tt "")
               (hbl-append 0 (letk) (function "GetNeighbours") (parameter " (cell:Cell) : List<Cell> ") (equal))
               (hbl-append 0 (tab) (letk) (keyword "rec ") (function "FindNeighbours ") (parameter "neighbours universe ") (equal))
               (hbl-append 0 (tab) (tab) (keyword "match ") (tt "neighbours ") (keyword "with"))
               (hbl-append 0 (tab) (tab) (keyword "| [] -> ") (tt "universe"))
               (hbl-append 0 (tab) (tab) (keyword "| ") (tt "H") (keyword "::") (tt "T ") (keyword "->"))
               (hbl-append 0 (tab) (tab) (tab)) (tt "FindNeighbours T (AddNeighbour cell universe H)")
               (hbl-append 0 (tab) (tt "FindNeighbours neighbours ") (keyword "[]"))

               (hbl-append 0 (tab) (keyword "|> ") (tt "List.rev"))))

(define (statement-fsharp)
  (tt "SomeFunctionCall someparameter"))

(define (expression-fsharp)
  (hbl-append 0 (letk) (function "someResult ") (equal) (tt "SomeFunctionCall someparameter")))

(define (mutable-state-fsharp)
  (vl-append
    0
    (hbl-append 0 (letk) (function "FindOnUniverse ") (parameter "universe (alive:byref<_>) ") (keyword "="))
    (hbl-append 0 (tab) (tt "alive ") (keyword "<- ") (tt "some_calculation"))
    (tt " ")
    (hbl-append 0 (letk) (function "CheckIfAlive ") (parameter "cell universe ") (keyword "="))
    (hbl-append 0 (tab) (letk) (keyword "mutable ") (function "alive ") (keyword "= ") (tt "GetNeighbours cell"))
    (hbl-append 0 (tab) (tt "FindOnUniverse universe ") (keyword "&") (tt "alive"))
    (hbl-append 0 (tab) (tt "(List.length alive) ") (equal) (tt "2"))
    (hbl-append 0 (tab) (keyword "|| ") (tt "(List.length alive ") (equal) (tt "3"))))

(define (non-mutable-state-fsharp)
  (vl-append
    0
    (hbl-append 0 (letk) (function "FindOnUniverse ") (parameter "universe alive ") (equal) (tt "..."))
    (tt " ")
    (hbl-append 0 (letk) (function "CheckIfAlive ") (parameter "cell universe ") (keyword "="))
    (hbl-append 0 (tab) (letk) (function "neighbours ") (equal) (tt "GetNeighbours cell"))
    (hbl-append 0 (tab) (letk) (function "alive ") (equal) (tt "FindOnUniverse universe neighbours"))
    (hbl-append 0 (tab) (tt "(List.length alive) ") (equal) (tt "2"))
    (hbl-append 0 (tab) (keyword "|| ") (tt "(List.length alive ") (equal) (tt "3"))
    ))

(define (non-exhaustive-1-fsharp)
  (vl-append
    0
    (hbl-append 0 (keyword "match ") (tt "CheckIfAlive elem universe ") (keyword "with "))
    (hbl-append 0 (keyword "| true -> ") (tt "elem ") (keyword ":: ") (tt "acc"))))

(define (exhaustive-1-fsharp)
  (vl-append
    0
    (hbl-append 0 (keyword "match ") (tt "CheckIfAlive elem universe ") (keyword "with "))
    (hbl-append 0 (keyword "| true -> ") (tt "elem ") (keyword ":: ") (tt "acc"))
    (hbl-append 0 (keyword "| false -> ") (tt "acc"))))

(define (non-exhaustive-2-fsharp)
  (vl-append
    0
    (hbl-append 0 (keyword "if ") (tt "x ") (equal) (tt "\"let's go\" ") (keyword "then"))
    (hbl-append 0 (tab) (tt "printf \"hey\""))))

(define (exhaustive-2-fsharp)
  (vl-append
    0
    (hbl-append 0 (keyword "if ") (tt "x ") (equal) (tt "\"let's go\" ") (keyword "then"))
    (hbl-append 0 (tab) (tt "printf \"hey\""))
    (keyword "else")
    (hbl-append 0 (tab) (tt "printf \"ho\""))))

(define (intermediate-variables-fsharp)
  (vl-append
    0
    (hbl-append 0 (letk) (function "CompareWith ") (parameter "expected actual ") (equal))
    (tt "    Assert.True (CompareList expected actual)")
    (tt "")
    (hbl-append 0 (letk) (function "``Empty cell becomes alive`` ") (keyword "() ") (equal))
    (hbl-append 0 (tab) (letk) (function "u3 ") (equal) (keyword "["))
    (hbl-append 0 (tab) (tab) (keyword "{") (tt "x ") (equal) (tt "-1") (keyword "; ") (tt "y ") (equal) (tt "-1") (keyword "};"))
    (hbl-append 0 (tab) (tab) (keyword "{") (tt "x ") (equal) (tt "1") (keyword "; ") (tt "y ") (equal) (tt "1") (keyword "};"))
    (hbl-append 0 (tab) (tab) (keyword "{") (tt "x ") (equal) (tt "-1") (keyword "; ") (tt "y ") (equal) (tt "1") (keyword "}]"))
    (hbl-append 0 (tab) (letk) (function "universe ") (equal) (keyword "[{") (tt "x ") (equal) (tt "0") (keyword "; ") (tt "y ") (equal) (tt "0") (keyword "}]"))
    (hbl-append 0 (tab) (letk) (function "actualUniverse ") (equal) (tt"NextUniverse u3"))
    (hbl-append 0 (tab) (tt "CompareWith universe actualUniverse"))))

(define (non-intermediate-variables-fsharp)
  (vl-append
    0
    (hbl-append 0 (letk) (function "CompareWith ") (parameter "expected actual ") (equal))
    (tt "    Assert.True (CompareList expected actual)")
    (tt "")
    (hbl-append 0 (letk) (function "``Empty cell becomes alive`` ") (keyword "() ") (equal))
    (hbl-append 0 (tab) (keyword "[{") (tt "x ") (equal) (tt "-1") (keyword "; ") (tt "y ") (equal) (tt "-1") (keyword "};"))
    (hbl-append 0 (tab) (keyword " {") (tt "x ") (equal) (tt "1") (keyword "; ") (tt "y ") (equal) (tt "1") (keyword "};"))
    (hbl-append 0 (tab) (keyword " {") (tt "x ") (equal) (tt "-1") (keyword "; ") (tt "y ") (equal) (tt "1") (keyword "}]"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "NextUniverse"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "CompareWith ") (keyword "[{") (tt "x ") (equal) (tt "0") (keyword "; ") (tt "y ") (equal) (tt "0") (keyword "}]"))))

(define (non-intermediate-variables-alternate-fsharp)
  (vl-append
    0
    (hbl-append 0 (letk) (function "CompareWith ") (parameter "expected actual ") (equal))
    (tt "    Assert.True (CompareList expected actual)")
    (tt "")
    (hbl-append 0 (letk) (function "expectedUniverse ") (equal))
    (hbl-append 0 (tab) (keyword "[{") (tt "x ") (equal) (tt "0") (keyword "; ") (tt "y ") (equal) (tt "0") (keyword "}]"))
    (tt "")
    (hbl-append 0 (letk) (function "universeWithThreeCells ") (equal))
    (hbl-append 0 (tab) (keyword "[{") (tt "x ") (equal) (tt "-1") (keyword "; ") (tt "y ") (equal) (tt "-1") (keyword "};"))
    (hbl-append 0 (tab) (keyword " {") (tt "x ") (equal) (tt "1") (keyword "; ") (tt "y ") (equal) (tt "1") (keyword "};"))
    (hbl-append 0 (tab) (keyword " {") (tt "x ") (equal) (tt "-1") (keyword "; ") (tt "y ") (equal) (tt "1") (keyword "}]"))
    (tt "")
    (hbl-append 0 (letk) (function "``Empty cell becomes alive`` ") (keyword "() ") (equal))
    (tt "    universeWithThreeCells")
    (hbl-append 0 (tab) (keyword "|> ") (tt "NextUniverse"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "CompareWith expectedUniverse"))))

(define (recursion-fsharp)
  (vl-append
    0
    (hbl-append 0 (letk) (function "AddN ") (parameter "cell universe mods ") (equal))
    (hbl-append 0 (tab) (keyword "{") (tt "x ") (equal) (tt "cell.x ") (keyword "+ ") (tt "fst mods") (keyword ";"))
    (hbl-append 0 (tab) (tt " y ") (equal) (tt "cell.y ") (keyword "+ ") (tt "snd mods") (keyword "}"))
    (hbl-append 0 (tab) (keyword ":: ") (tt "universe"))
    (tt "")
    (hbl-append 0 (letk) (function "GetNeighbours ") (parameter "(cell:Cell) : List<Cell> ") (equal))
    (hbl-append 8 (tab) (letk) (keyword "rec ") (function "FindNeighbours ") (parameter "N U ") (equal))
    (hbl-append 0 (tab) (tab) (keyword "match ") (tt "N ") (keyword "with "))
    (hbl-append 0 (tab) (tab) (keyword "| [] -> ") (tt "U"))
    (hbl-append 0 (tab) (tab) (keyword "| ") (tt "H") (keyword "::") (tt "T ") (keyword "->"))
    (tt "            FindNeighbours T (AddN cell U H)")
    (hbl-append 0 (tt "    FindNeighbours neighbours ") (keyword "[]"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "List.rev"))))

(define (non-recursion-fsharp)
  (vl-append
    0
    (hbl-append 0 (letk) (function "AddN ") (parameter "cell universe mods ") (equal))
    (hbl-append 0 (tab) (keyword "{") (tt "x ") (equal) (tt "cell.x ") (keyword "+ ") (tt "fst mods") (keyword ";"))
    (hbl-append 0 (tab) (tt " y ") (equal) (tt "cell.y ") (keyword "+ ") (tt "snd mods") (keyword "}"))
    (hbl-append 0 (tab) (keyword ":: ") (tt "universe"))
    (tt "")
    (hbl-append 0 (letk) (function "GetNeighbours ") (parameter "(cell:Cell) : List<Cell> ") (equal))
    (hbl-append 0 (tab) (letk) (function "AddNForCell ") (parameter "acc elem ") (equal) (tt "AddN cell acc elem"))
    (hbl-append 0 (tab) (tt "List.fold AddNForCell ") (keyword "[] ") (tt "neighbours"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "List.rev"))))

(define (non-recursion-alternate-fsharp)
  (vl-append
    0
    (hbl-append 0 (letk) (function "AddN ") (parameter "cell universe mods ") (equal))
    (hbl-append 0 (tab) (keyword "{") (tt "x ") (equal) (tt "cell.x ") (keyword "+ ") (tt "fst mods") (keyword ";"))
    (hbl-append 0 (tab) (tt " y ") (equal) (tt "cell.y ") (keyword "+ ") (tt "snd mods") (keyword "}"))
    (hbl-append 0 (tab) (keyword ":: ") (tt "universe"))
    (tt "")
    (hbl-append 0 (letk) (function "GetNeighbours ") (parameter "(cell:Cell) : List<Cell> ") (equal))
    (hbl-append 0 (tab) (tt "List.fold (AddN cell) ") (keyword "[] ") (tt "neighbours"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "List.rev"))))

(define (non-generic-building-block-fsharp)
  (vl-append
    0
    (hbl-append 0 (letk) (function "Born ") (parameter "universe ") (equal))
    (hbl-append 0 (tab) (tt "List.fold ") (keyword "-> ") (tt "CollateNeighbours ") (keyword "[] ") (tt "universe"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "Set.ofList"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "Set.toList"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "NotAnyIn universe"))
    (hbl-append (tab) (keyword "|> ") (tt "List.fold (") (keyword "fun ") (tt "acc e ") (keyword "->"))
    (hbl-append (tab) (tab) (tab) (tab) (keyword "match ") (tt "IfThree e universe ") (keyword "with"))
    (hbl-append 0 (tab) (tab) (tab) (tab) (keyword "| true -> ") (tt "e ") (keyword ":: ") (tt "acc"))
    (hbl-append 0 (tab) (tab) (tab) (tab) (keyword "| false -> ") (tt "acc) ") (keyword "[] ") (tt "acc"))))

(define (generic-building-block-fsharp)
  (vl-append
    0
    (hbl-append 0 (letk) (function "Born ") (parameter "check universe ") (equal))
    (hbl-append 0 (tab) (tt "List.fold ") (keyword "-> ") (tt "CollateNeighbours ") (keyword "[] ") (tt "universe"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "Set.ofList"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "Set.toList"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "NotAnyIn universe"))
    (hbl-append (tab) (keyword "|> ") (tt "List.fold (") (keyword "fun ") (tt "acc e ") (keyword "->"))
    (hbl-append (tab) (tab) (tab) (tab) (keyword "match ") (tt "check e universe ") (keyword "with"))
    (hbl-append 0 (tab) (tab) (tab) (tab) (keyword "| true -> ") (tt "e ") (keyword ":: ") (tt "acc"))
    (hbl-append 0 (tab) (tab) (tab) (tab) (keyword "| false -> ") (tt "acc) ") (keyword "[] ") (tt "acc"))
    (tt "")
    (hbl-append (letk) (function "BornWithThree ") (parameter "universe ") (equal))
    (tt "    Born CheckIfThree universe")))

(define (generic-building-block-alternate-fsharp)
  (vl-append
    0
    (hbl-append 0 (letk) (function "Born ") (parameter "check universe ") (equal))
    (hbl-append 0 (tab) (tt "List.fold ") (keyword "-> ") (tt "CollateNeighbours ") (keyword "[] ") (tt "universe"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "Dedup"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "NotAnyIn universe"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "CheckAll check"))
    (tt "")
    (hbl-append (letk) (function "BornWithThree ") (parameter "universe ") (equal))
    (tt "    Born CheckIfThree universe")))

(define (side-effect-fsharp)
  (vl-append
    0
    (hbl-append 0 (letk) (function "SaveBorns ") (parameter "newBorns ") (equal))
    (tt "    ...Saving in database")
    (tt "    newBorns")
    (tt "")
    (hbl-append 0 (letk) (function "Born ") (parameter "check universe ") (equal))
    (tt "...")
    (hbl-append 0 (tab) (keyword "|> ") (tt "CheckAll check"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "SaveBorns"))))

(define (side-effect-injection-fsharp)
  (vl-append
    0
    (hbl-append 0 (letk) (function "SaveBorns ") (parameter "newBorns ") (equal))
    (tt "    ...Saving in database")
    (tt "    newBorns")
    (tt "")
    (hbl-append 0 (letk) (function "Born ") (parameter "check universe saving ") (equal))
    (tt "    ...")
    (hbl-append 0 (tab) (keyword "|> ") (tt "CheckAll check"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "saving"))
    (tt "")
    (tt "Born check universe SaveBorns")))

(define (side-effect-out-fsharp)
  (vl-append
    0
    (hbl-append 0 (letk) (function "SaveBorns ") (parameter "newBorns ") (equal))
    (tt "   Saving in database")
    (tt "    newBorns")
    (tt "")
    (hbl-append 0 (letk) (function "Born ") (parameter "check universe ") (equal))
    (tt "...")
    (hbl-append 0 (tab) (keyword "|> ") (tt "CheckAll check"))
    (tt "")
    (hbl-append 0 (letk) (keyword "[<EntryPoint>] ") (function "main ") (parameter "_ ") (equal))
    (tt "...")
    (tt "    Born check universe")
    (hbl-append 0 (tab) (keyword "|> ") (tt "SaveBorns"))))

(define (side-effect-out-alternate-fsharp)
  (vl-append
    0
    (hbl-append 0 (letk) (function "SaveBorns ") (parameter "newBorns ") (equal))
    (tt "   Saving in database")
    (tt "    newBorns")
    (tt "")
    (hbl-append 0 (letk) (function "Born ") (parameter "check universe ") (equal))
    (tt "...")
    (hbl-append 0 (tab) (keyword "|> ") (tt "CheckAll check"))
    (tt "")
    (hbl-append 0 (letk) (keyword "[<EntryPoint>] ") (function "main ") (parameter "_ ") (equal))
    (tt "...")
    (tt "    Born check universe")
    (hbl-append 0 (tab) (keyword "|> ") (tt "SaveBorns"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "AddToUniverse"))))

(define (non-sequence-fsharp)
  (vl-append
    0
    (hbl-append 0 (letk) (function "FindOnUniverse ") (parameter "list1 list2 ") (equal))
    (tt "    List.filter ")
    (hbl-append 0 (tab) (tab) (tt "(") (keyword "fun ") (tt "(x) ") (keyword "->"))
    (hbl-append 0 (tab) (tab) (tab) (tt "List.exists (") (keyword "fun ") (tt "(y) ") (keyword "-> ") (tt "x ") (equal) (tt "y) list2)"))
    (tt "        list1")))

(define (sequence-fsharp)
  (vl-append
    0
    (hbl-append 0 (letk) (function "FindOnUniverse ") (parameter "seq1 seq2 ") (equal))
    (tt "    Seq.filter ")
    (hbl-append 0 (tab) (tab) (tt "(") (keyword "fun ") (tt "(x) ") (keyword "->"))
    (hbl-append 0 (tab) (tab) (tab) (tt "Seq.exists (") (keyword "fun ") (tt "(y) ") (keyword "-> ") (tt "x ") (equal) (tt "y) seq2)"))
    (tt "        seq1")))

(define (multiple-arguments-fsharp)
  (vl-append
    0
    (hbl-append 0 (letk) (function "FindOnUniverse ") (parameter "seq1 seq2 ") (equal))
    (tt "    Seq.filter ")
    (hbl-append 0 (tab) (tab) (tt "(") (keyword "fun ") (tt "(x) ") (keyword "->"))
    (hbl-append 0 (tab) (tab) (tab) (tt "Seq.exists (") (keyword "fun ") (tt "(y) ") (keyword "-> ") (tt "x ") (equal) (tt "y) seq2)"))
    (tt "        seq1")))

(define (single-argument-fsharp)
  (vl-append
    0
    (hbl-append 0 (letk) (function "CheckExistence ") (parameter "onSeq ") (equal))
    (hbl-append 0 (tab) (keyword "fun") (tt "(x) ") (keyword "-> ") (tt "Seq.exists (") (keyword "fun") (tt "(y) ") (keyword "-> ") (tt "x ") (equal) (tt "y) onSeq"))
    (tt "")
    (hbl-append 0 (letk) (function "Find ") (parameter "possibles ") (equal))
    (tt "    Seq.Filter (CheckExistence universe) possibles")))

(define (multiple-arguments-2-fsharp)
  (vl-append
    0
    (hbl-append 0 (letk) (function "CheckIfThree ") (parameter "cell universe ") (equal))
    (hbl-append 0 (tab) (letk) (function "allNeighs ") (equal) (tt "GetNeighbours cell"))
    (hbl-append 0 (tab) (letk) (function "alive ") (equal) (tt "FindOnUniverse universe allNeighs"))
    (hbl-append 0 (tab) (tt "List.length alive ") (equal) (tt "3"))))

(define (composition-fsharp)
  (vl-append
    0
    (hbl-append 0 (letk) (function "FWU ") (equal) (tt "FindOnUniverse universe"))
    (hbl-append 0 (letk) (function "CheckForThree ") (parameter "alive ") (equal) (tt "List.length alive ") (equal) (tt "3"))
    (hbl-append 0 (letk) (function "check ") (equal) (tt "GetNeighbours ") (keyword ">> ") (tt "FWU ") (keyword ">> ") (tt "CheckForThree") )))
